import 'package:flutter/material.dart';
import 'package:lotus/colors.dart' as colors;
import 'package:lotus/colors.dart';
import 'package:lotus/home1.dart' as home;
import 'package:lotus/widgets.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

const apiKey = 'AIzaSyBnmudhOY3tdRVTeRLWS2gvylZ-ukofIOA';

class AI extends StatefulWidget {
  const AI({super.key});

  @override
  State<AI> createState() => _AIState();
}

class _AIState extends State<AI> {
  int _selectedIndex = 2; // Track the selected index
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  DateTime? _lastRequestTime;
  late final GenerativeModel _model;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({"sender": "user", "message": message});
    });

    print('Sending message: $message');

    try {
      if (_lastRequestTime != null) {
        final timeSinceLastRequest =
            DateTime.now().difference(_lastRequestTime!);
        if (timeSinceLastRequest.inSeconds < 20) {
          // Ensure at least 20 seconds between requests to stay under 3 RPM
          await Future.delayed(
              Duration(seconds: 20 - timeSinceLastRequest.inSeconds));
        }
      }

      _lastRequestTime = DateTime.now();

      final content = [
        Content.text(
            "Please limit your responses to pharmacies and their medicines in Algeria. $message")
      ];
      final response = await _model.generateContent(content);

      if (response.text != null) {
        final botMessage = response.text!.trim();

        setState(() {
          _messages.add({"sender": "bot", "message": botMessage});
        });
      } else {
        setState(() {
          _messages.add({
            "sender": "bot",
            "message": "Sorry, I couldn't process your request."
          });
        });
      }
    } catch (error) {
      print('Error sending message: $error');
      setState(() {
        _messages.add(
            {"sender": "bot", "message": "Sorry, an error occurred: $error"});
      });
    }
  }

  Widget _buildMessage(Map<String, String> message) {
    bool isUser = message['sender'] == 'user';
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset('assets/chatboticon.png'),
              radius: 25, // Increased radius for bot icon
            ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.all(16),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            decoration: BoxDecoration(
              color: isUser ? ChatBotHuman : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isUser ? 40 : 0),
                topRight: Radius.circular(isUser ? 0 : 40),
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Text(
              message['message']!,
              style: TextStyle(
                color: isUser ? Colors.white : TextColor1,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: colors.TextColor1,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => home.HomePage1()),
                      );
                    },
                  ),
                  SizedBox(width: 125),
                  Text(
                    'LotusAI',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/chat_background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return _buildMessage(message);
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type a question..',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: colors.TextColor1,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward, color: Colors.white),
                      onPressed: () {
                        final message = _controller.text;
                        if (message.isNotEmpty) {
                          _sendMessage(message);
                          _controller.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
