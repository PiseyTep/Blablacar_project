import 'package:flutter/material.dart';
import '/model/ride/locations.dart';
import '/service/locations_service.dart';
import '/theme/theme.dart';

class BlaLocationPicker extends StatefulWidget {
  final Location? initLocation;
  final ValueChanged<Location?> onLocationSelected; // Allow null

  const BlaLocationPicker({
    super.key,
    this.initLocation,
    required this.onLocationSelected,
  });

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  List<Location> filteredLocations = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredLocations = LocationsService.availableLocations;
  }

  void _onBackPressed() => Navigator.of(context).pop();

  void _onLocationSelected(Location? location) {
    widget.onLocationSelected(location);
    Navigator.of(context).pop(); // Close the picker
  }

  void _onSearchChanged(String query) {
    setState(() {
      filteredLocations = query.isNotEmpty
          ? LocationsService.availableLocations
              .where((location) =>
                  location.name.toLowerCase().contains(query.toLowerCase()))
              .toList()
          : LocationsService
              .availableLocations; // Show all locations if query is empty
    });
  }

  void _onClearSelection() {
    widget.onLocationSelected(null); // Notify that selection is cleared
    Navigator.of(context).pop(); // Close the picker
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: _onClearSelection,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: "Search for a location",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // List of locations
          Expanded(
            child: ListView.builder(
              itemCount: filteredLocations.length,
              itemBuilder: (ctx, index) {
                final location = filteredLocations[index];
                return LocationTile(
                  location: location,
                  onSelected: _onLocationSelected,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Represents a selectable location tile in the list.
class LocationTile extends StatelessWidget {
  final Location location;
  final ValueChanged<Location?> onSelected;

  const LocationTile({
    super.key,
    required this.location,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onSelected(location),
      title: Text(location.name,
          style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal)),
      subtitle: Text(location.country.name,
          style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
      trailing:
          Icon(Icons.arrow_forward_ios, size: 16, color: BlaColors.iconLight),
    );
  }
}

/// A reusable search bar with a back button and clear functionality.
class BlaSearchBar extends StatefulWidget {
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onBackPressed;

  const BlaSearchBar({
    super.key,
    required this.onSearchChanged,
    required this.onBackPressed,
  });

  @override
  State<BlaSearchBar> createState() => _BlaSearchBarState();
}

class _BlaSearchBarState extends State<BlaSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool get _isSearchNotEmpty => _controller.text.isNotEmpty;

  void _handleSearch(String text) {
    widget.onSearchChanged(text);
    setState(() {}); // Updates clear button visibility
  }

  void _clearSearch() {
    _controller.clear();
    _focusNode.requestFocus();
    _handleSearch("");
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onBackPressed,
            icon: Icon(Icons.arrow_back_ios,
                size: 16, color: BlaColors.iconLight),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: _handleSearch,
              style: TextStyle(color: BlaColors.textLight),
              decoration: const InputDecoration(
                hintText: "Any city, street...",
                border: InputBorder.none,
              ),
            ),
          ),
          if (_isSearchNotEmpty)
            IconButton(
              icon: Icon(Icons.close, color: BlaColors.iconLight),
              onPressed: _clearSearch,
            ),
        ],
      ),
    );
  }
}
