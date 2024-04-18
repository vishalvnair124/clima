import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpScreen extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final int rand;

  const OtpScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.password,
    required this.rand,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController _otpController;
  bool _isLoading = false;
  bool isSignupreq = false;
  String msg = "";
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
        // print('Name: ${widget.name}');
        // print('Email: ${widget.email}');
        // print('Password: ${widget.password}');
        // print('Random number: ${widget.rand}');
        createUser(widget.email, widget.email, widget.password);
        // Proceed with further actions after successful OTP verification
      } else {
        // OTP verification failed
        // print('OTP verification failed');
        // print('Random number: ${widget.rand}');
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
              visible: !isSignupreq,
              child: TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Enter OTP', focusColor: Colors.green),
              ),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: !isSignupreq,
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
                  visible: isSignupreq,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text("   $msg   "),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> createUser(
      String userName, String userEmail, String userPassword) async {
    final url = Uri.parse('http://10.0.2.2:8000/add_user/');

    final Map<String, String> data = {
      'user_name': userName,
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
      print('User created successfully:');
      setState(() {
        msg = "Account created successfully,now you can login";
        isSignupreq = true;
      });
      // print(response.body);
    } else if (response.statusCode == 409) {
      // print(response.body);
    } else {
      print('Failed to create user. Status code: ${response.statusCode}');
      // print('Response body: ${response.body}');
    }
  }
}
