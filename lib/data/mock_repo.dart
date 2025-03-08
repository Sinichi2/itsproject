import 'dart:math';

class User {
  final int userID;
  final String PhoneNumber;
  final String passwordHash;
  bool phoneVerified;

  User({
    required this.userID,
    required this.PhoneNumber,
    required this.passwordHash,
    this.phoneVerified = false,
  });
}

class OTPRequest {
  final int otpID;
  final int userID;
  final String otpCode;
  DateTime expiresAt;
  bool used;

  OTPRequest({
    required this.otpID,
    required this.userID,
    required this.otpCode,
    required this.expiresAt,
    this.used = false,
  });
}

class MockDatabaseRepository {
  // Simulated "tables"
  final List<User> _users = [];
  final List<OTPRequest> _otps = [];

  MockDatabaseRepository() {
    _users.add(
      User(
        userID: 1,
        PhoneNumber: '+63961234567895',
        passwordHash: 'password123',
      ),
    );
  }

  //Checking the phone/password
  Future<User?> getUserByPhoneandPassword(String phone, String password) async {
    //simulate network/db delay
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _users.firstWhere(
        (u) => u.PhoneNumber == phone && u.passwordHash == password,
      );
    } catch (e) {
      return null;
    }
  }

  //Generation of OTP and storing the OTP
  Future<OTPRequest> createOTP(int userID) async {
    await Future.delayed(const Duration(milliseconds: 500));
    //Generation of a 6 digit code
    final code = (Random().nextInt(900000) + 100000).toString();
    final newOtp = OTPRequest(
      otpID: _otps.length + 1,
      userID: userID,
      otpCode: code,
      expiresAt: DateTime.now().add(const Duration(minutes: 3)),
    );
    _otps.add(newOtp);
    return newOtp;
  }
}
