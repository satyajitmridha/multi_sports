import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../api/fetch_apis.dart';
import 'darts_match_details.dart';


class OtpVerificationScreen extends StatefulWidget {
  final String mobileNumber;

  const OtpVerificationScreen({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  bool _resendLoading = false;

  Future<void> _verifyOtpThen() async {
     try {
      final response = await ApiService.fetchToDayMatchDetails();
      
      if (response['process_status'] == 'YES') {
        // Navigate to home screen or perform login
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DartsMatchDetails(matchData: response),
          ),
       );
      } else {
        Fluttertoast.showToast(msg: response['message'] ?? 'Invalid OTP',backgroundColor: const Color.fromARGB(255, 247, 74, 35));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    } 
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.length != 4) { // Assuming 6-digit OTP
      Fluttertoast.showToast(msg: 'Please enter a valid OTP',backgroundColor: const Color.fromARGB(255, 247, 74, 35));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiService.verifyOtp(widget.mobileNumber, _otpController.text);
      
      if (response['process_status'] == 'NO') {
        // Navigate to home screen or perform login
        Fluttertoast.showToast(msg: 'Login successful',backgroundColor: const Color.fromARGB(255, 2, 186, 152));
        _verifyOtpThen();
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Fluttertoast.showToast(msg: response['message'] ?? 'Invalid OTP',backgroundColor: const Color.fromARGB(255, 247, 74, 35));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _resendOtp() async {
    setState(() {
      _resendLoading = true;
    });

    try {
      final response = await ApiService.sendOtp(widget.mobileNumber);
      Fluttertoast.showToast(msg: response['message'] ?? 'OTP resent successfully');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    } finally {
      setState(() {
        _resendLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP'),
      centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 247, 74, 35),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter OTP sent to ${widget.mobileNumber}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            PinCodeTextField(
              appContext: context,
              length: 4,
              controller: _otpController,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
                selectedColor: Colors.green,
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _verifyOtp,
                    child: const Text('Verify OTP',style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 247, 74, 35),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                  ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _resendLoading ? null : _resendOtp,
              child: _resendLoading
                  ? const CircularProgressIndicator()
                  : const Text('Resend OTP'),
                  
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
  //  _otpController.dispose();
    super.dispose();
  }
}