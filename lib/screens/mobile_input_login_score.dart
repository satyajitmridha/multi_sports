import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../api/fetch_apis.dart';
import 'otp_verification_screen.dart';
import 'darts_match_details.dart';
import 'package:logger/logger.dart';

class MobileInputScreen extends StatefulWidget {
  const MobileInputScreen({Key? key}) : super(key: key);

  @override
  _MobileInputScreenState createState() => _MobileInputScreenState();
}

class _MobileInputScreenState extends State<MobileInputScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _sendOtp() async {
    var logger = Logger();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await ApiService.sendOtp(_mobileController.text);
        
        if (response['process_status'] == 'YES') {
       

          if (response['playing_today'] == 'YES') {
          

          try {
               // const response = await ApiService.fetchToDayMatchDetails();
               final response = await ApiService.fetchToDayMatchDetails();
              // logger.i("Match Details Response: $response");
              // print(response);
              if (response['process_status'] == 'YES') {
            // Navigate to home screen or perform login
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtpVerificationScreen(
                    mobileNumber: response['OTP'] != null ? response['OTP'] : _mobileController.text,
                  ),
                ),
              );
            //   Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DartsMatchDetails(matchData: response),
            //   ),
            // );
            } 
            else {
              Fluttertoast.showToast(msg: response['message'] ?? 'Failed to fetch match details');
            }
               // print("Match Details Response:", response);
            } catch (error) {
               // print("Error fetching match details:", error);
            }
      
        }else{
          Fluttertoast.showToast(msg: 'You are not playing today');
        }
          
        } else {
          Fluttertoast.showToast(msg: response['message'] ?? 'Failed to Login');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'Error: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login to Darts Score',style: TextStyle(color: Colors.white)),
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'Enter your mobile number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mobile number';
                  }
                  // Add more validation as per your requirements
                  if (value.length < 10) {
                    return 'Enter a valid mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _sendOtp,
                      child: const Text('Login',style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 247, 74, 35),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }
}