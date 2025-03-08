class AuthSerivce {
  final Map<String, String> _mockUserData = {
    //Phone
    '+639612345678': 'password123',
    '+19612345678': 'password123',
    '+449612345678': 'password123',
  };

  Future<bool> login(String phone, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (_mockUserData.containsKey(phone) && _mockUserData[phone] == password) {
      return true;
    } else {
      return false;
    }
  }
}
