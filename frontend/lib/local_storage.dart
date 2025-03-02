import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static String? _cachedUsername;
  // Save user data
  static Future<void> saveUserData(
      String token, int userId, String username, String email) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', token);
    await prefs.setInt('user_id', userId);
    await prefs.setString('username', username);
    await prefs.setString('email', email);

    _cachedUsername = username; // Update cache
    print('User data saved successfully!');
  }

  // Retrieve user data
  static Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    // Print values for debugging
    String? token = prefs.getString('token');
    int? userId = prefs.getInt('user_id');
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');

    print('Retrieved token: $token');
    print('Retrieved userId: $userId');
    print('Retrieved username: $username');
    print('Retrieved email: $email');

    return {
      'token': token,
      'user_id': userId,
      'username': username,
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
  static Future<String?> get token async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Getter for userId (int type)
  static Future<int?> get userId async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  // Getter for username (String type)
  static Future<String> get username async {
    if (_cachedUsername != null) {
      return _cachedUsername!;
    }
    final prefs = await SharedPreferences.getInstance();
    _cachedUsername = prefs.getString('username') ?? 'Guest';
    return _cachedUsername!;
  }

  // Getter for email (String type)
  static Future<String?> get email async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

    static Future<void> updateUsername(String newUsername) async {
    if (newUsername.trim().isEmpty) {
      throw Exception('Username cannot be empty');
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', newUsername); // Update in SharedPreferences
    _cachedUsername = newUsername; // Update cache
    print('Username updated successfully!');
  }
}
