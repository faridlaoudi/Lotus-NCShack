import 'package:flutter/material.dart';
import 'package:lotus/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 4; // Track the selected index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
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
