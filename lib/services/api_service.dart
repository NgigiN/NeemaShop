import '../models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8000/api';

  Future<http.Response> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('$baseUrl/register/');
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode(<String, String>{
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'username': username,
      'password': password,
      'password2': confirmPassword,
    });

    return await http.post(url, headers: headers, body: body);
  }

  Future<http.Response> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login/');
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode(<String, String>{
      'email': email,
      'password': password,
    });

    return await http.post(url, headers: headers, body: body);
  }

  Future<http.Response> updateUser(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {
      'Content-Type': 'application/json',
    };

    return await http.put(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
  }
}
