import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../configs/theme.dart';

class HomePageController extends GetxController {
  Map<String, dynamic> _prices = {};

  @override
  void onInit() {
    super.onInit();
    _fetchPrices();
  }

  Future<void> _fetchPrices() async {
    final url = Uri.parse('http://127.0.0.1:8000/products/milk/price/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _prices = {
          for (var item in data) item['name']: item['price_per_litre']
        };
        update();
      } else {
        Get.snackbar(
          'Error',
          'Failed to load prices. Status code: ${response.statusCode}',
          backgroundColor: AppTheme.errorColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load prices. Error: $e',
        backgroundColor: AppTheme.errorColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Map<String, dynamic> get prices => _prices;
}
