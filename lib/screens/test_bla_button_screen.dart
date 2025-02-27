import 'package:flutter/material.dart';
import '../widgets/actions/bla_button.dart'; // Adjust the path if necessary

class TestBlaButtonScreen extends StatelessWidget {
  const TestBlaButtonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test BlaButton')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlaButton(
              label: 'Contact Volodia',
              icon: Icons.chat,
              onPressed: () {
                // Handle contact action
                print('Contact Volodia');
              },
            ),
            const SizedBox(height: 20),
            BlaButton(
              label: 'Request to Book',
              icon: Icons.calendar_today,
              isPrimary: true,
              onPressed: () {
                // Handle booking action
                print("Request to Book");
              },
            ),
          ],
        ),
      ),
    );
  }
}
