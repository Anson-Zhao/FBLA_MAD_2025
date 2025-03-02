import 'package:shared_preferences/shared_preferences.dart';

class LocalStoragePassword {
  // Save user data
  static Future<void> saveUserData(
      String email, String code) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('code', code);
    await prefs.setString('email', email);
 // Update cache
    print('User data saved successfully!');
  }

  // Save email
  static Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    print('Email saved successfully!');
  }

  // Save code
  static Future<void> saveCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('code', code);
    print('Code saved successfully!');
  }

  // Retrieve user data
  static Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    // Print values for debugging
    String? code = prefs.getString('code');
    String? email = prefs.getString('email');

    return {
      'code': code,
      'email': email,
    };
  }

  // Clear user data
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears all data
    print('User data cleared successfully!');
  }

  // Getter for token (String type)
  static Future<String?> get code async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('cdoe');
  }

  // Getter for email (String type)
  static Future<String?> get email async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }
}
