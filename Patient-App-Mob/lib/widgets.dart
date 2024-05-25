import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lotus/home1.dart'; // Importing Home from home1.dart
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:lotus/colors.dart';
import 'package:lotus/pages/pharmacy.dart';
import 'package:lotus/pages/ai.dart';
import 'package:lotus/pages/meds.dart';
import 'package:lotus/pages/profile.dart';

final Widget logo =
    SvgPicture.asset('assets/Logo.svg', semanticsLabel: 'Lotus Logo');

final Widget Curved =
    SvgPicture.asset('assets/Curved.svg', semanticsLabel: 'Curved');

class MenuBotBar extends StatefulWidget {
  final int selectedIndex; // Add a parameter to receive the selected index

  MenuBotBar({required this.selectedIndex});

  @override
  _MenuBotBarState createState() => _MenuBotBarState();
}

class _MenuBotBarState extends State<MenuBotBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex; // Initialize the selected index
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildMenuButton(0, Icons.home_outlined, 'Home', HomePage1()),
              _buildMenuButton(
                  1, Icons.local_pharmacy_outlined, 'Pharmacies', Pharmacy()),
              _buildMenuButton(2, MdiIcons.robotHappy, 'AI Lotus', AI()),
              _buildMenuButton(
                  3, MdiIcons.medication, 'Pharmaceuticals', Meds()),
              _buildMenuButton(
                  4, Icons.person_2_outlined, 'Profile', Profile()),
            ],
          ),
          SizedBox(
            height: 17,
          )
        ],
      ),
    );
  }

  Widget _buildMenuButton(int index, IconData icon, String label, Widget page) {
    Color iconColor =
        index == _selectedIndex ? IconSelectedColor : IconIdleColor;
    Color textColor =
        index == _selectedIndex ? IconSelectedColor : IconIdleColor;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor),
            Text(label, style: TextStyle(color: textColor)),
          ],
        ),
      ),
    );
  }
}

class OutOfStockWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFFFEBEB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFFFCFCF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.medication,
              color: Colors.red,
              size: 30,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Paralgan 500mg B/20',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2A88),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.report_problem,
                    color: Colors.red,
                    size: 16,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Out of Stock',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.chevron_right,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
