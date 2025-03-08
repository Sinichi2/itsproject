import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/auth.dart';
import 'Loginloginscreen.dart';
import 'loginScreen.dart';

// This comment shows the mock auth data for reference:
// AuthSerivce mock data:
// Phone: +639612345678, Password: password123
// Phone: +19612345678, Password: password123
// Phone: +449612345678, Password: password123

class Country {
  final String name;
  final String dialCode;
  final String flagPath;

  Country({required this.name, required this.dialCode, required this.flagPath});
}

class Loginx2 extends StatefulWidget {
  const Loginx2({Key? key}) : super(key: key);

  @override
  _Loginx2ScreenState createState() => _Loginx2ScreenState();
}

class _Loginx2ScreenState extends State<Loginx2> {
  // Countries list
  final List<Country> countries = [
    Country(
      name: 'Philippines',
      dialCode: '+63',
      flagPath: 'assets/images/Flag_of_Philippines-128x64.png',
    ),
    Country(
      name: 'United States',
      dialCode: '+1',
      flagPath: 'assets/images/Flag_of_United_States-128x67.png',
    ),
    Country(
      name: 'United Kingdom',
      dialCode: '+44',
      flagPath: 'assets/images/Flag_of_United_Kingdom-128x64.png',
    ),
  ];

  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthSerivce _authService = AuthSerivce();

  Country? _selectedCountry;
  bool _isLoading = false;
  String? _errorMessage;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    if (countries.isNotEmpty) {
      _selectedCountry = countries[0];
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // This is a modification to your existing Loginx2 class
  // Only the _handleLogin method is changed to redirect to verification

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    // Add the country code to the phone number without any spaces
    final fullPhoneNumber = '${_selectedCountry?.dialCode}$phone';

    // For debugging - you can remove this in production
    print('Attempting login with: $fullPhoneNumber and password: $password');

    final success = await _authService.login(fullPhoneNumber, password);
    setState(() => _isLoading = false);

    if (success) {
      // Instead of going directly to home, go to verification screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => VerificationScreen(phoneNumber: fullPhoneNumber),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid phone number or password.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            // Gradient overlay at 15% opacity
            Opacity(
              opacity: 0.15, // 15% visibility
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                    ),

                    // Login title
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 15),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Archivo',
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Phone number section
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Enter your phone',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontFamily: 'Archivo',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Phone input with country dropdown
                    Row(
                      children: [
                        // Country dropdown in a container
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Country>(
                              value: _selectedCountry,
                              dropdownColor: const Color(0xFF3A1078),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              borderRadius: BorderRadius.circular(28),
                              onChanged: (Country? newValue) {
                                if (newValue != _selectedCountry) {
                                  setState(() {
                                    _selectedCountry = newValue;
                                  });
                                }
                              },
                              items:
                                  countries.map<DropdownMenuItem<Country>>((
                                    Country country,
                                  ) {
                                    return DropdownMenuItem<Country>(
                                      value: country,
                                      child: Image.asset(
                                        country.flagPath,
                                        width: 35,
                                        height: 20,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return const Icon(
                                            Icons.flag,
                                            color: Colors.red,
                                          );
                                        },
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        // Phone number input field with dial code prefix
                        Expanded(
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                // Display the dial code
                                Container(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    _selectedCountry?.dialCode ?? '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                // Phone number field that only accepts numbers
                                Expanded(
                                  child: TextField(
                                    controller: _phoneController,
                                    style: const TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    decoration: InputDecoration(
                                      hintText: 'Please enter a number',
                                      hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Password section
                    const Padding(
                      padding: EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        'Enter your password',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Password input field
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        style: const TextStyle(color: Colors.white),
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 15),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),

                    const Spacer(),

                    // Send button
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 30),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
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
}
