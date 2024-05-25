import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lotus/colors.dart';
import 'package:lotus/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:calendar_timeline_sbk/calendar_timeline.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  int _selectedIndex = 0; // Track the selected index
  bool _noMedications = false;
  DateTime _selectedDate =
      DateTime.now(); // Add a state variable for the selected date

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final DateTime startDate = DateTime(today.year, today.month - 3, today.day);
    final DateTime endDate = DateTime(today.year, today.month + 3, today.day);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Expand the SVG to fill the width
                SizedBox(
                  width: double.infinity,
                  child: Curved,
                ),
                // Overlay text on top of the SVG
                Positioned(
                  top: 70, // Adjust top position as needed
                  left: 20, // Adjust left position as needed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning',
                        style: TextStyle(
                          color: TextColor1, // Adjust text color
                          fontSize: 24, // Adjust font size
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins', // Adjust font weight
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 70.0),
                        child: Text(
                          'Hmimed',
                          style: TextStyle(
                            color: TextColor1, // Adjust text color
                            fontSize: 24, // Adjust font size
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins', // Adjust font weight
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 80, // Adjust top position as needed
                  right: 20, // Adjust right position as needed
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Button background color
                      shape: BoxShape.circle, // Make the button circular
                    ),
                    child: IconButton(
                      icon: Icon(
                        MdiIcons.bellBadgeOutline,
                        color: TextColor1, // Icon color
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: CalendarTimeline(
                initialDate: _selectedDate, // Use the state variable
                firstDate: startDate,
                lastDate: endDate,
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date; // Update the state variable
                    _noMedications = date.day == 26 && date.month == 5;
                  });
                },
                monthColor: Colors.blueGrey,
                dayColor: TextColor1,
                activeDayColor: Colors.white,
                activeBackgroundDayColor: TextColor1,
                dotsColor: Color.fromARGB(255, 255, 255, 255),
                selectableDayPredicate: (date) => date.day != 23,
                locale: 'en',
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(right: 200),
              child: Text(
                'Up Coming',
                style: TextStyle(
                  color: TextColor1, // Adjust text color
                  fontSize: 24, // Adjust font size
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins', // Adjust font weight
                ),
              ),
            ),
            Expanded(
              child: _noMedications
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/no_meds.png'),
                          SizedBox(height: 20),
                          Text(
                            'You Have No Schedule Today',
                            style: TextStyle(
                              color: TextColor1,
                              fontSize: 24,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            'Stay Safe!',
                            style: TextStyle(
                              color: TextColor1,
                              fontSize: 24,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      children: [
                        MedicationSchedule(
                          time: '8:00 AM',
                          medications: [
                            Medication(
                              name: 'Paralgan 500mg B/20',
                              dosage: '2 Pill',
                              timing: 'Before Meal',
                              status: 'Not Taken',
                              daysLeft: '16 days left',
                              pillsLeft: 12,
                              isTaken: false,
                            ),
                            Medication(
                              name: 'Paralgan 500mg B/20',
                              dosage: '1 Packet',
                              timing: 'After Meal',
                              status: 'Taken',
                              daysLeft: '3 days left',
                              pillsLeft: 8,
                              refillNeeded: true,
                              isTaken: true,
                            ),
                          ],
                        ),
                        MedicationSchedule(
                          time: '12:30 PM',
                          medications: [
                            Medication(
                              name: 'Paralgan 500mg B/20',
                              dosage: '2 Pill',
                              timing: 'Before Meal',
                              status: 'Not Taken',
                              daysLeft: '16 days left',
                              pillsLeft: 12,
                              isTaken: false,
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
            MenuBotBar(selectedIndex: _selectedIndex),
          ],
        ),
      ),
    );
  }
}

class MedicationSchedule extends StatelessWidget {
  final String time;
  final List<Medication> medications;

  MedicationSchedule({required this.time, required this.medications});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            time,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: TextColor1,
            ),
          ),
        ),
        ...medications
            .map((medication) => MedicationWidget(medication: medication))
            .toList(),
      ],
    );
  }
}

class Medication {
  final String name;
  final String dosage;
  final String timing;
  final String status;
  final String daysLeft;
  final int pillsLeft;
  final bool isTaken;
  final bool refillNeeded;

  Medication({
    required this.name,
    required this.dosage,
    required this.timing,
    required this.status,
    required this.daysLeft,
    required this.pillsLeft,
    this.isTaken = false,
    this.refillNeeded = false,
  });
}

class MedicationWidget extends StatelessWidget {
  final Medication medication;

  MedicationWidget({required this.medication});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFE5F8FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 131.08,
              width: 60.27,
              decoration: BoxDecoration(
                color:
                    medication.isTaken ? Color(0XFFF8DEB7) : Color(0XFFC9EDF4),
                borderRadius:
                    BorderRadius.circular(60), // Adjust the radius as needed
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/pill.svg', // Path to your SVG asset
                    height: 40, // Adjust the height as needed
                  ),
                  SizedBox(height: 15),
                  Column(
                    children: [
                      Icon(
                        medication.isTaken ? Icons.check : Icons.close,
                        color: medication.isTaken ? Colors.green : Colors.red,
                        size: 20,
                      ),
                      SizedBox(
                          height: 4), // Adjust the space between icon and text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (!medication.isTaken)
                            Text(
                              'Not',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12, // Adjust the font size as needed
                              ),
                            ),
                          SizedBox(
                              width:
                                  2), // Adjust the space between the two texts
                          Text(
                            'Taken',
                            style: TextStyle(
                              color: medication.isTaken
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 12, // Adjust the font size as needed
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medication.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2A88),
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.local_hospital, size: 16, color: TextColor2),
                    SizedBox(width: 5),
                    Text(medication.dosage,
                        style: TextStyle(color: TextColor2)),
                    SizedBox(width: 10),
                    Icon(Icons.access_time, size: 16, color: TextColor2),
                    SizedBox(width: 5),
                    Text(medication.timing,
                        style: TextStyle(color: TextColor2)),
                  ],
                ),
                SizedBox(height: 5),
                Text(medication.daysLeft, style: TextStyle(color: TextColor2)),
                if (medication.refillNeeded)
                  Text('Refill Needed', style: TextStyle(color: Colors.orange)),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right, color: Colors.black),
            onPressed: () => _showBottomSheet(context, medication),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context, Medication medication) {
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
                  decoration: BoxDecoration(
                    color: Color(0xFFE3EBFC),
                    borderRadius: BorderRadius.circular(
                        20), // Adjust the radius as needed
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        SizedBox(height: 26),
                        Text(
                          medication.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D2A88),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white, // Button background color
                                shape:
                                    BoxShape.circle, // Make the button circular
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/pill.svg', // Path to your SVG asset
                                  height: 30, // Adjust the height as needed
                                ),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(medication.dosage,
                                style: TextStyle(fontSize: 18)),
                            SizedBox(width: 30),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.dining_rounded,
                                  color: TextColor1, // Icon color
                                ),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(medication.timing,
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              '${medication.daysLeft.split(' ')[0]}',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF2D2A88)),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'days left',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF2D2A88)),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              '${medication.pillsLeft}',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'pills left',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Mon, Tue, Fri',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D2A88)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: doctor,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Icon(
                    Icons.check_circle,
                    size: 50,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

final Widget Curved = SvgPicture.asset(
  'assets/Curved.svg',
  semanticsLabel: 'Curved',
  fit: BoxFit.fill, // Ensures the SVG fills the width
);

final Widget doctor = SvgPicture.asset(
  'assets/doctor.svg',
  semanticsLabel: 'doctor',
  // Ensures the SVG fills the width
);

final Widget no_meds =
    SvgPicture.asset('assets/no_meds.svg', semanticsLabel: 'no_meds');

final Color TextColor1 = Color(0xFF2D2A88);
final Color TextColor2 = Color(0xFF5A5A5A);
