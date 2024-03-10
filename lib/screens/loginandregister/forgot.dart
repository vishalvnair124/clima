import 'dart:convert';
import 'dart:math';
import 'package:clima/screens/loginandregister/forgototp.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  String msg = "";
  bool showMsg = false;
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Clima',
          style: GoogleFonts.mada(
            color: Color.fromARGB(255, 28, 207, 16),
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
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
              borderRadius: BorderRadius.circular(30),
            ),
            height: MediaQuery.of(context).size.height * 0.55,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Change password",
                    style: GoogleFonts.aladin(
                      color: Color.fromARGB(255, 28, 207, 16),
                      fontSize: 30,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(),
                                onPressed: () async {
                                  setState(() {
                                    showMsg = false;
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    String email = _emailController.text;

                                    int rand = Random().nextInt(9000) + 1000;
                                    bool emailExists =
                                        await checkEmailExistence(email);
                                    if (emailExists) {
                                      await sendEmailWithOTP(
                                          email, rand.toString());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ForgotOtpScreen(
                                            email: email,
                                            rand: rand,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  'Send mail',
                                  style: GoogleFonts.mada(
                                    color: Color.fromARGB(255, 28, 207, 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: showMsg,
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
    );
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
        if (responseData['exists'] == false) {
          setState(() {
            msg = "please create account";
            showMsg = true;
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
