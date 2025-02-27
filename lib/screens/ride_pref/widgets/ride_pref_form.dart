import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../../widgets/inputs/location_picker.dart';

/// A Ride Preference Form to select:
///   - A departure location
///   - An arrival location
///   - A date
///   - A number of seats
class RidePrefForm extends StatefulWidget {
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location departure =
      const Location(name: 'Toulouse', country: Country.france);
  DateTime departureDate = DateTime.now();
  Location arrival = const Location(name: 'Bordeaux', country: Country.france);
  int requestedSeats = 1; // Default to 1 seat

  @override
  void initState() {
    super.initState();
    // Initialize with provided RidePref if available
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    }
  }

  // Select Departure Location
  void _selectDeparture() {
    showDialog(
      context: context,
      builder: (context) {
        return BlaLocationPicker(
          initLocation: departure,
          onLocationSelected: (selectedLocation) {
            setState(() {
              departure = selectedLocation ?? departure; // Use previous if null
            });
          },
        );
      },
    );
  }

  // Select Arrival Location
  void _selectArrival() {
    showDialog(
      context: context,
      builder: (context) {
        return BlaLocationPicker(
          initLocation: arrival,
          onLocationSelected: (selectedLocation) {
            setState(() {
              arrival = selectedLocation ?? arrival; // Use previous if null
            });
          },
        );
      },
    );
  }

  // Select Departure Date
  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        departureDate = pickedDate;
      });
    }
  }

  // Show Seats Dialog
  void _showSeatsDialog() {
    int tempSeats = requestedSeats;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              'Number of seats to book',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$tempSeats',
                    style: TextStyle(color: Colors.white, fontSize: 48),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.white),
                        onPressed: () {
                          if (tempSeats > 1) {
                            setState(() {
                              tempSeats--;
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          if (tempSeats < 10) {
                            setState(() {
                              tempSeats++;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  requestedSeats = tempSeats; // Update the main variable
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Confirm',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  // Swap departure and arrival locations
  void _swapLocations() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  // Build the widgets
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BlaSpacings.m),
      child: Container(
        decoration: BoxDecoration(
          color: BlaColors.white,
          borderRadius: BorderRadius.circular(BlaSpacings.radius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(BlaSpacings.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Departure Location
            GestureDetector(
              onTap: _selectDeparture,
              child: Container(
                padding: const EdgeInsets.all(BlaSpacings.s),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: BlaColors.greyLight),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: BlaColors.primary),
                        SizedBox(width: 8),
                        Text(departure.name,
                            style: BlaTextStyles.label), // Display Departure
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.swap_vert, color: BlaColors.primary),
                      onPressed: _swapLocations,
                      tooltip: 'Swap locations',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: BlaSpacings.s),
            // Arrival Location
            GestureDetector(
              onTap: _selectArrival,
              child: Container(
                padding: const EdgeInsets.all(BlaSpacings.s),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: BlaColors.greyLight),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: BlaColors.primary),
                    SizedBox(width: 8),
                    Text(arrival.name,
                        style: BlaTextStyles.label), // Display Arrival
                  ],
                ),
              ),
            ),
            const SizedBox(height: BlaSpacings.s),
            // Date Picker
            GestureDetector(
              onTap: _selectDate,
              child: Container(
                padding: const EdgeInsets.all(BlaSpacings.s),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: BlaColors.greyLight),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: BlaColors.primary),
                    SizedBox(width: 8),
                    Text(DateFormat('EEE d MMM').format(departureDate),
                        style: BlaTextStyles.label), // Display Date
                  ],
                ),
              ),
            ),
            const SizedBox(height: BlaSpacings.s),
            // Number of Seats Button
            GestureDetector(
              onTap: _showSeatsDialog,
              child: Container(
                padding: const EdgeInsets.all(BlaSpacings.s),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: BlaColors.greyLight),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.event_seat, color: BlaColors.primary),
                    SizedBox(width: 8),
                    Text('Number of seats: $requestedSeats',
                        style: BlaTextStyles.label), // Display Seats
                  ],
                ),
              ),
            ),
            const SizedBox(height: BlaSpacings.s),
            // Submit Button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print(
                      'Searching rides from ${departure.name} to ${arrival.name} on ${departureDate.toLocal()} with $requestedSeats passengers.');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: BlaColors.primary,
                  padding: const EdgeInsets.all(BlaSpacings.l),
                  textStyle: BlaTextStyles.button,
                ),
                child: Text('Search', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
