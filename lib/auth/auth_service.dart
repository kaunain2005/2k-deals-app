import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://localhost:5000/api'; // Update to your backend URL

  // Signup API function
  Future<String?> signup(String email, String password) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return null; // Success
    } else {
      final responseBody = jsonDecode(response.body);
      return responseBody['message']; // Return error message
    }
  }

  // Login API function
  Future<String?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return null; // Success
    } else {
      final responseBody = jsonDecode(response.body);
      return responseBody['message']; // Return error message
    }
  }
}
