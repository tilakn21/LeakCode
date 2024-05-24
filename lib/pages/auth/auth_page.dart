// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> registerUser(String email, String password) async {
  final url = Uri.parse('http://your_backend_url/register');
  final response = await http.post(
    url,
    body: jsonEncode({'email': email, 'password': password}),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 201) {
    print('User registered successfully');
    // Navigate to success page or handle accordingly
  } else {
    print('Registration failed');
    // Handle error response
  }
}

Future<void> loginUser(String email, String password) async {
  final url = Uri.parse('http://your_backend_url/login');
  final response = await http.post(
    url,
    body: jsonEncode({'email': email, 'password': password}),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 200) {
    print('Login successful');
    // Navigate to home page or handle accordingly
  } else {
    print('Login failed');
    // Handle error response
  }
}
