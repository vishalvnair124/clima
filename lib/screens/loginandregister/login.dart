import 'dart:convert';
import 'package:clima/screens/loginandregister/forgot.dart';
import 'package:http/http.dart' as http;
import 'package:clima/screens/loginandregister/signupscreen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool isLogin = false;
  String msg = "";

  @override
  void initState() {
    super.initState();
    // Check if user credentials exist in SharedPreferences
    _checkUserLoggedIn();
  }

  // Function to check if the user is already logged in
  Future<void> _checkUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');
    String? userPassword = prefs.getString('userPassword');
    if (userEmail != null && userPassword != null) {
      // If credentials exist, attempt to log in
      loginUser(userEmail, userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 234, 229, 229),
                  border: Border.all(color: Colors.green, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 112, 242, 179),
                      offset: const Offset(
                        3.0,
                        3.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                  borderRadius: BorderRadius.circular(30)),
              height: MediaQuery.of(context).size.height * 0.55,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "LOGIN",
                      style: GoogleFonts.aladin(
                          color: Color.fromARGB(255, 28, 207, 16),
                          fontSize: 60,
                          fontWeight: FontWeight.w500),
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
                                fontWeight: FontWeight.w500),
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
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                  style: ButtonStyle(),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // Login button action
                                      String email = _emailController.text;
                                      String password =
                                          _passwordController.text;
                                      // Perform login action with email and password
                                      loginUser(email, password);
                                    }
                                  },
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.mada(
                                        color:
                                            Color.fromARGB(255, 28, 207, 16)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: GoogleFonts.mada(
                                        color:
                                            Color.fromARGB(255, 28, 207, 16)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ForgotPassword(),
                                      ),
                                    );
                                  },
                                  child: Text("Forgot password?")),
                            ],
                          ),
                          Visibility(
                              visible: isLogin,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser(String userEmail, String userPassword) async {
    final url =
        Uri.parse('http://10.0.2.2:8000/login/'); // Change the URL accordingly

    final Map<String, String> data = {
      'user_email': userEmail,
      'user_password': userPassword,
    };

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Login successful');
      // print(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userEmail', userEmail);
      prefs.setString('userPassword', userPassword);
      Navigator.pushReplacementNamed(context, "home");
    } else if (response.statusCode == 401) {
      setState(() {
        msg = "wrong user name or password";
        isLogin = true;
      });
      print('Invalid credentials');
      // Handle invalid credentials, e.g., show error message
    } else {
      print('Failed to login. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Handle other error cases
    }
  }
}
