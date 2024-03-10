import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgotOtpScreen extends StatefulWidget {
  final String email;

  final int rand;

  const ForgotOtpScreen({
    Key? key,
    required this.email,
    required this.rand,
  }) : super(key: key);

  @override
  State<ForgotOtpScreen> createState() => _ForgotOtpScreenState();
}

class _ForgotOtpScreenState extends State<ForgotOtpScreen> {
  late TextEditingController _otpController;
  bool _isLoading = false;
  bool showMsg = false;
  String msg1 = "";
  String msg2 = "";
  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    setState(() {
      _isLoading = true;
    });

    // Simulate OTP verification delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      // Compare the OTP entered by the user with the random number
      if (_otpController.text == widget.rand.toString()) {
        // OTP verification successful, proceed with further actions
        print('OTP verification successful');

        // Now you can access the passed parameters using widget.name, widget.email, widget.password, and widget.rand

        print('Email: ${widget.email}');

        print('Random number: ${widget.rand}');
        updatePasswordAndNotify(widget.email);
        setState(() {
          msg1 = "Password updated successfully";
          msg2 = " New password sent to email";
          showMsg = true;
        });
        // Proceed with further actions after successful OTP verification
      } else {
        // OTP verification failed
        print('OTP verification failed');
        print('Random number: ${widget.rand}');
      }
    });
  }

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
              fontWeight: FontWeight.w500),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        flexibleSpace: Image(
          image: AssetImage('assets/images/ForestBG-1.png'),
          fit: BoxFit.fill,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !showMsg,
              child: TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Enter OTP', focusColor: Colors.green),
              ),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: !showMsg,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF3BDD38), // Set the background color
                  ),
                ),
                onPressed: _isLoading ? null : _verifyOtp,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        'Verify OTP',
                        style: GoogleFonts.mada(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
              ),
            ),
            Center(
              child: Visibility(
                  visible: showMsg,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "   $msg1  ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 59, 221, 56),
                                  fontSize: 20),
                            ),
                            Text("   $msg2   ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 59, 221, 56),
                                    fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> updatePasswordAndNotify(String userEmail) async {
    // Define the URL of the FastAPI endpoint
    final String apiUrl = 'http://10.0.2.2:8000/update_password_and_notify/';

    try {
      // Prepare the request body as JSON
      final Map<String, dynamic> requestData = {
        'user_email': userEmail,
      };
      final String requestBody = json.encode(requestData);

      // Send the POST request
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        print('Password updated successfully! New password sent to user.');
      } else {
        print('Failed to update password: ${response.body}');
      }
    } catch (e) {
      print('Error sending POST request: $e');
    }
  }
}
