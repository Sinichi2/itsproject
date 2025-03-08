import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/auth.dart';
import 'homepage.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const VerificationScreen({Key? key, required this.phoneNumber})
    : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  final AuthSerivce _authService = AuthSerivce();
  bool _isLoading = false;
  String? _errorMessage;
  int _remainingSeconds = 90; // 1:30 in seconds
  Timer? _timer;
  String _generatedOtp = '';

  @override
  void initState() {
    super.initState();
    _generateAndSendOtp();
    _startTimer();

    // Add a small delay to allow the UI to build before filling the OTP
    Future.delayed(const Duration(milliseconds: 300), () {
      _autoFillGeneratedOtp();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();

    for (var controller in _otpControllers) {
      controller.dispose();
    }

    for (var node in _focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  // In a real app, this would connect to your backend to generate and send an OTP
  void _generateAndSendOtp() {
    // Generate a random 6-digit OTP (for demonstration)
    // In a real app, this would come from your backend service
    _generatedOtp =
        (100000 + (DateTime.now().millisecondsSinceEpoch % 900000)).toString();

    // Print for demo purposes - in a real app, this would be sent to the user's phone
    print('Generated OTP: $_generatedOtp for ${widget.phoneNumber}');
  }

  // Auto-fill the generated OTP into the text fields
  void _autoFillGeneratedOtp() {
    if (_generatedOtp.length == 6) {
      for (int i = 0; i < 6; i++) {
        _otpControllers[i].text = _generatedOtp[i];
      }
    }
  }

  void _resendOtp() {
    setState(() {
      _remainingSeconds = 90;
      _errorMessage = null;
    });

    _generateAndSendOtp();
    _startTimer();

    // Auto-fill the new OTP after resend
    Future.delayed(const Duration(milliseconds: 300), () {
      _autoFillGeneratedOtp();
    });
  }

  String _getEnteredOtp() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  void _verifyOtp() async {
    final enteredOtp = _getEnteredOtp();

    if (enteredOtp.length != 6) {
      setState(() {
        _errorMessage = 'Please enter all 6 digits';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulate verification delay
    await Future.delayed(const Duration(seconds: 1));

    // In a real app, this would verify with your backend
    // For demo, we'll compare with our generated OTP
    final isValid = enteredOtp == _generatedOtp;

    setState(() {
      _isLoading = false;
    });

    if (isValid) {
      // Navigate to home screen on success
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid verification code. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    String seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            // Gradient overlay at 15% opacity
            Opacity(
              opacity: 0.15,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: const [
                      Color(0xFFA59E9E), // 0%
                      Color(0xFFEA1A6E), // 50%
                      Color(0xFF9B51E0), // 80%
                      Color(0xFF9B51E0), // 100%
                    ],
                    stops: const [0.0, 0.5, 0.8, 1.0],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),

                    // Verification title
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 15),
                      child: Text(
                        'Verification',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Archivo',
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Instructions
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Enter 6 digit code we sent to ${widget.phoneNumber}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontFamily: 'Archivo',
                        ),
                      ),
                    ),

                    // Notice about auto-fill (for development only)
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 4),
                      child: Text(
                        '(Auto-filled for development purposes)',
                        style: const TextStyle(
                          color: Colors.pink,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // OTP Input Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => _buildOtpDigitBox(index),
                      ),
                    ),

                    // Error message
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 15),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ),

                    const SizedBox(height: 25),

                    // Reset code timer
                    GestureDetector(
                      onTap: _remainingSeconds == 0 ? _resendOtp : null,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            const Text(
                              'Reset code in ',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '$minutes:$seconds',
                              style: TextStyle(
                                color:
                                    _remainingSeconds == 0
                                        ? Colors.pink
                                        : Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Send button
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 30),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _verifyOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE91E63), // Pink
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child:
                            _isLoading
                                ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : const Text(
                                  'Send',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpDigitBox(int index) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          // If digit entered and not the last box, move to next box
          if (value.isNotEmpty && index < 5) {
            _focusNodes[index + 1].requestFocus();
          }
          // If backspace pressed and not the first box, move to previous box
          else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }

          // Clear error message when typing
          if (_errorMessage != null) {
            setState(() {
              _errorMessage = null;
            });
          }
        },
      ),
    );
  }
}
