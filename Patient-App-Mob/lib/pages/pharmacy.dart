import 'package:flutter/material.dart';
import 'package:lotus/widgets.dart';

class Pharmacy extends StatefulWidget {
  const Pharmacy({super.key});

  @override
  State<Pharmacy> createState() => _PharmacyState();
}

class _PharmacyState extends State<Pharmacy> {
  int _selectedIndex = 1; // Track the selected index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Column(
          children: [
            // Other widgets can go here
            Spacer(), // Pushes the MenuBotBar to the bottom
            MenuBotBar(selectedIndex: _selectedIndex),
          ],
        ),
      ),
    );
  }
}
