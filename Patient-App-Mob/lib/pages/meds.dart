import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lotus/colors.dart' as colors;
import 'package:lotus/home1.dart' as home;
import 'package:lotus/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:calendar_timeline_sbk/calendar_timeline.dart';

class Meds extends StatefulWidget {
  const Meds({super.key});

  @override
  State<Meds> createState() => _MedsState();
}

class _MedsState extends State<Meds> {
  int _selectedIndex = 3;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  _buildInputField(
                    controller: _searchController,
                    hintText: 'Search',
                    icon: Icons.search,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  MedicationWidget(
                    id: '1',
                    name: 'Paralgan 500mg B/20',
                    category: 'Pain Relief',
                    description: 'For headache relief',
                    unitPrice: 5.0,
                    unitReductionPrice: 4.0,
                    reorderLevel: 10,
                    expirationDate: DateTime.now().add(Duration(days: 365)),
                    stockLevel: 0,
                  ),
                  MedicationWidget(
                    id: '2',
                    name: 'Ibuprofen 200mg B/30',
                    category: 'Pain Relief',
                    description: 'Anti-inflammatory drug',
                    unitPrice: 3.0,
                    unitReductionPrice: 2.5,
                    reorderLevel: 15,
                    expirationDate: DateTime.now().add(Duration(days: 180)),
                    stockLevel: 20,
                  ),
                  MedicationWidget(
                    id: '3',
                    name: 'Metformin 500mg B/20',
                    category: 'Diabetes',
                    description: 'Helps control blood sugar levels',
                    unitPrice: 7.0,
                    unitReductionPrice: 6.0,
                    reorderLevel: 5,
                    expirationDate: DateTime.now().add(Duration(days: 200)),
                    stockLevel: 0,
                  ),
                  MedicationWidget(
                    id: '4',
                    name: 'Moxicillin 250mg B/15',
                    category: 'Antibiotic',
                    description: 'Used to treat infections',
                    unitPrice: 8.0,
                    unitReductionPrice: 7.0,
                    reorderLevel: 8,
                    expirationDate: DateTime.now().add(Duration(days: 400)),
                    stockLevel: 30,
                  ),
                ],
              ),
            ),
            Spacer(),
            MenuBotBar(selectedIndex: _selectedIndex),
          ],
        ),
      ),
    );
  }
}

final Widget Curved = SvgPicture.asset(
  'assets/Curved.svg',
  semanticsLabel: 'Curved',
  fit: BoxFit.fill, // Ensures the SVG fills the width
);

Widget _buildInputField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  bool obscureText = false,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    style: TextStyle(
      color: colors.TextColor2.withOpacity(0.5),
      fontFamily: 'Poppins',
    ),
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: colors.TextColor2.withOpacity(0.5),
        fontFamily: 'Poppins',
      ),
      filled: true,
      fillColor: Colors.white,
      suffixIcon: Icon(
        icon,
        color: colors.TextColor2.withOpacity(0.3),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.blue),
      ),
    ),
  );
}

class MedicationWidget extends StatelessWidget {
  final String id;
  final String name;
  final String category;
  final String description;
  final double unitPrice;
  final double unitReductionPrice;
  final int reorderLevel;
  final DateTime expirationDate;
  final int stockLevel;

  MedicationWidget({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.unitPrice,
    required this.unitReductionPrice,
    required this.reorderLevel,
    required this.expirationDate,
    required this.stockLevel,
  });

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the bottom sheet to expand fully
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(20), // Adjust the radius as needed
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: Colors.black, // Color of the line
                  thickness: 3, // Thickness of the line
                  indent: 160, // Left spacing
                  endIndent: 160, // Right spacing
                ),
                Center(
                  child: Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 500,
                  decoration: BoxDecoration(
                    color: Color(0xFFE3EBFC),
                    borderRadius: BorderRadius.circular(
                        20), // Adjust the radius as needed
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 26),
                        Text(
                          'Available At :',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D2A88),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Pharmacie De garde Khaldoun',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF2D2A88)),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Pharmacie BAIDA - KOUBA',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF2D2A88)),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Pharmacie Les Bananiers',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF2D2A88)),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Side Effecte :',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D2A88),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Dizziness, lightheadedness, drowsiness, nausea, vomiting, tiredness, excess saliva/drooling, blurred vision, weight gain, constipation, headache, and trouble sleeping may occur. If any of these effects persist or worsen, consult your doctor.',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF2D2A88)),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'How to use :',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D2A88),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Take this medication by mouth with or without food as directed by your doctor, usually once daily.',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF2D2A88)),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isOutOfStock = stockLevel == 0;

    return Container(
      width: 333,
      height: 84,
      padding: EdgeInsets.only(right: 17, left: 11),
      margin: EdgeInsets.only(bottom: 15.86),
      decoration: BoxDecoration(
        color: isOutOfStock ? Color(0xFFFFEBEB) : Color(0xFFE5F8FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isOutOfStock ? Color(0xFFFFCFCF) : Color(0xFFBBF1FA),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.medication,
              color: isOutOfStock ? Colors.red : Colors.blue,
              size: 30,
            ),
          ),
          SizedBox(width: 13),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D2A88),
                ),
              ),
              Row(
                children: [
                  Icon(
                    isOutOfStock ? Icons.report_problem : Icons.check_circle,
                    color: isOutOfStock ? Colors.red : Colors.blue,
                    size: 16,
                  ),
                  SizedBox(width: 5),
                  Text(
                    isOutOfStock ? 'Out of Stock' : 'Available',
                    style: TextStyle(
                      color: isOutOfStock ? Colors.red : Colors.blue,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: Colors.black,
            ),
            onPressed: () => _showBottomSheet(context),
          ),
        ],
      ),
    );
  }
}
