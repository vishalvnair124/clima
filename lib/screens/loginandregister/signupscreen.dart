import 'dart:convert';
import 'dart:math';
import 'package:clima/screens/loginandregister/otpscreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool isSignupreq = false;
  String msg = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Clima',
            style: GoogleFonts.mada(
                color: Color.fromARGB(255, 28, 207, 16),
                fontSize: 30,
                fontWeight: FontWeight.w500),
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.05,
          flexibleSpace: Image(
            image: AssetImage('assets/images/ForestBG-1.png'),
            fit: BoxFit.fill,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 234, 229, 229),
                  border: Border.all(color: Colors.green, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 112, 242, 179),
                      offset: const Offset(3.0, 3.0),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(30),
                ),
                height: MediaQuery.of(context).size.height * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "SIGN UP",
                        style: GoogleFonts.aladin(
                          color: Color.fromARGB(255, 28, 207, 16),
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              style: GoogleFonts.mada(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Name',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              style: GoogleFonts.mada(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                // Check if the entered email address is valid
                                if (!EmailValidator.validate(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              style: GoogleFonts.mada(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              controller: _passwordController,
                              obscureText:
                                  _obscurePassword, // Set the obscureText property dynamically
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword =
                                          !_obscurePassword; // Toggle the obscurePassword state
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                } else if (!_isPasswordValid(value)) {
                                  return 'Password must have at least 6 characters including one uppercase letter, one lowercase letter, one number, and one special character.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              style: GoogleFonts.mada(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please confirm your password';
                                } else if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      isSignupreq = false;
                                    });
                                    String name = _nameController.text;
                                    String email = _emailController.text;
                                    String password = _passwordController.text;
                                    int rand = Random().nextInt(9000) + 1000;
                                    bool emailExists = await checkEmailExistence(
                                        email); // Use await within an async function
                                    if (!emailExists) {
                                      await sendEmailWithOTP(
                                          email, rand.toString());
                                    }
                                    if (_formKey.currentState!.validate() &&
                                        !emailExists) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OtpScreen(
                                            name: name,
                                            email: email,
                                            password: password,
                                            rand: rand,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: GoogleFonts.mada(
                                      color: Color.fromARGB(255, 28, 207, 16),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.mada(
                                      color: Color.fromARGB(255, 28, 207, 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: isSignupreq,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Text("          $msg          "),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isPasswordValid(String password) {
    // Password must have at least 6 characters including one uppercase letter, one lowercase letter, one number, and one special character
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> sendEmailWithOTP(String recipientEmail, String otp) async {
    final url = Uri.parse(
        'http://10.0.2.2:8000/send_email/'); // Replace with your server's URL

    final Map<String, String> data = {
      'user_email': recipientEmail,
      'otp': otp,
    };

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Email sent successfully');
      print(response.body);
      // Handle successful email sending
    } else {
      print('Failed to send email. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Handle error cases
    }
  }

  Future<bool> checkEmailExistence(String email) async {
    final url = Uri.parse(
        'http://10.0.2.2:8000/check_email/'); // Replace with your server's URL

    final Map<String, String> data = {
      'user_email': email,
    };

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData['exists']);
        if (responseData['exists'] == true) {
          setState(() {
            msg = "Email already exists";
            isSignupreq = true;
          });
        }
        return responseData['exists'] as bool;
      } else {
        print(
            'Failed to check email existence. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        // Handle error cases
        throw Exception('Failed to check email existence');
      }
    } catch (e) {
      print('Error checking email existence: $e');
      // Handle network or server-side errors
      throw Exception('Error checking email existence');
    }
  }
}
