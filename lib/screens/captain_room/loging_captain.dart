import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class LogingCaptain extends StatefulWidget {
  @override
  _LogingCaptain createState() => _LogingCaptain();
}

class _LogingCaptain extends State<LogingCaptain> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _showOtpPage = false;
  String _verificationId = ''; // This would normally come from your auth service

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 247, 74, 35),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40),
            // Image.asset(
            //   'assets/login.png', // Replace with your image path
            //   height: 150,
            // ),
            Center(
              child: Text(
                'Welcome back!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 30),
            if (!_showOtpPage) _buildPhoneLoginPage(),
            if (_showOtpPage) _buildOtpVerificationPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneLoginPage() {
    return Column(
      children: [
        Text(
          'Login with Mobile Number',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Mobile Number',
            prefixText: '+91 ',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.phone),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(width: 150,
          child:      ElevatedButton(
          onPressed: () {
            // In a real app, you would verify the phone number with Firebase or another service
            if (_phoneController.text.length == 10) {
              setState(() {
                _showOtpPage = true;
              });
              // Here you would typically call your OTP sending service
              // For example: await FirebaseAuth.instance.verifyPhoneNumber(...);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a valid 10-digit mobile number')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 115, 23, 2),
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Set rounded corners
            ),
          ),
          child: Text('Send OTP', style: TextStyle(color: Colors.white)),
        ),
     
        ),
    ],
    );
  }

  Widget _buildOtpVerificationPage() {
    return Column(
      children: [
        Text(
          'Verify OTP',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Enter the OTP sent to +91 ${_phoneController.text}',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20),
        TextField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'OTP',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () {
            // Resend OTP logic
          },
          child: Text('Resend OTP'),
        ),
        SizedBox(height: 20),
        SizedBox(width: 150,
          child:
       // Button to verify OTP
        ElevatedButton(
          onPressed: () {
            // Verify OTP logic
            // In a real app, you would verify the OTP with Firebase or another service
            if (_otpController.text.length == 6) {
              // Successful verification
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a valid 6-digit OTP')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 115, 23, 2),
            padding: EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Set rounded corners
            ),
          ),
          child: Text('Verify OTP', style: TextStyle(color: Colors.white)),
        ),
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () {
            setState(() {
              _showOtpPage = false;
            });
          },
          child: Text('Change Phone Number'),
        ),
      ],
    );
  }

Widget _buildOtpVerificationPage2() {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(4, (index) {
      return Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (value) {
            if (value.isNotEmpty && index < 3) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            }
          },
          onEditingComplete: () {
            if (index == 3) {
              FocusScope.of(context).unfocus();
            }
          },
          onFieldSubmitted: (value) {
            if (index < 3 && value.isNotEmpty) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            }
          },
          onTap: () {
            // Clear the text field when tapped
            _controllers[index].clear();
          },
          // Backspace handling
          // onKeyEvent: (node, event) {
          //   if (event.logicalKey == LogicalKeyboardKey.backspace) {
          //     if (_controllers[index].text.isEmpty && index > 0) {
          //       // Move focus to previous field if current is empty
          //       FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
          //       return KeyEventResult.handled;
          //     } else if (_controllers[index].text.isNotEmpty) {
          //       // Clear current field if it has text
          //       _controllers[index].clear();
          //       return KeyEventResult.handled;
          //     }
          //   }
          //   return KeyEventResult.ignored;
          // },
        ),
      );
    }
    
    ),
    
  );
}


  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    
    super.dispose();
  }
}

// Example home page after successful login
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: const Color.fromARGB(255, 115, 23, 2),
      ),
      body: Center(
        child: Text('Welcome!', style: TextStyle(fontSize: 24)),
    ),
    );
  }
}