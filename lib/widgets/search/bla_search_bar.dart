import 'package:flutter/material.dart';

class BlaSearchBar extends StatefulWidget {
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onBackPressed;

  const BlaSearchBar({
    Key? key,
    required this.onSearchChanged,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  State<BlaSearchBar> createState() => _BlaSearchBarState();
}

class _BlaSearchBarState extends State<BlaSearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _handleSearch(String text) {
    widget.onSearchChanged(text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: widget.onBackPressed,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: _handleSearch,
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
              _handleSearch('');
            },
          ),
        ],
      ),
    );
  }
}
