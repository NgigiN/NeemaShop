import '../models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8000';

  Future<http.Response> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('$baseUrl/users/register/');
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
    final url = Uri.parse('$baseUrl/users/login/');
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
    final url = Uri.parse('$baseUrl/users/$endpoint');
    final headers = {
      'Content-Type': 'application/json',
    };

    return await http.put(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
  }

  static String get bookingsUrl => '$baseUrl/products/bookings/';
  static String get bookingHistoryUrl => '$baseUrl/products/bookings/history/';
  static String get milkPricesUrl => '$baseUrl/products/milk/price/';
  static String get sodaPricesUrl => '$baseUrl/products/soda/price/';
}
