import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:lotus/api.dart';
import 'package:lotus/colors.dart';
import 'widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isChecked = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  final Dio _dio = Dio();
  final CookieJar cookieJar = CookieJar();

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    try {
      _dio.interceptors.add(CookieManager(cookieJar));

      final response = await _dio.post(
        url + 'login',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['status'] == 'OK') {
          final String token = responseData['token'];
          final String userId = responseData['userId'];

          print('Login successful, token: $token');

          // Save userId in a cookie
          cookieJar.saveFromResponse(
            Uri.parse(url),
            [Cookie('userId', userId)],
          );

          // Navigate to Home interface
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else {
          setState(() {
            _errorMessage = 'Login error: ${responseData['error']}';
          });
        }
      } else if (response.statusCode == 404) {
        setState(() {
          _errorMessage = 'Check your username or/and password';
        });
      } else {
        // Handle server error
        setState(() {
          _errorMessage = 'Server error: ${response.statusCode}';
        });
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 120),
            Center(
              child: Container(
                width: 105,
                height: 144,
                child: logo,
              ),
            ),
            SizedBox(height: 71),
            Text(
              'Login to your profile',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: TextColor1,
                fontWeight: FontWeight.w700,
                fontSize: 28,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Access to your account so you can manage your money even faster',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: TextColor2.withOpacity(0.5), // Set opacity to 50%
                fontSize: 14,
              ),
            ),
            SizedBox(height: 40),
            // Username input field with icon
            _buildInputField(
              controller: _usernameController,
              hintText: 'Username',
              icon: Icons.person_outline,
            ),
            SizedBox(height: 20),
            // Password input field with icon
            _buildInputField(
              controller: _passwordController,
              hintText: 'Password',
              icon: Icons.remove_red_eye,
              obscureText: true,
            ),
            SizedBox(height: 14),

            SizedBox(height: 70),
            // Button
            OutlinedButton(
              onPressed: _login,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(TextColor1),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // No curved borders
                  ),
                ),
              ),
              child: Container(
                width: 380,
                height: 65,
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              _errorMessage,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.red,
                fontSize: 13,
              ),
            ),
            // Checkbox
          ],
        ),
      ),
    );
  }

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
        color: TextColor2.withOpacity(0.5),
        fontFamily: 'Poppins',
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: TextColor2.withOpacity(0.5),
          fontFamily: 'Poppins',
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: Icon(
          icon,
          color: TextColor2.withOpacity(0.3),
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
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to Home'),
      ),
    );
  }
}
