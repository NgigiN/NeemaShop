import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shop_project/services/api_service.dart';
import 'dart:convert';
import '../configs/theme.dart';
import '../widgets/custom_snackbar.dart';
import '../controllers/cart_controller.dart';

class Soda {
  final String name;
  final int quantity;
  final double price;
  final String imagePath;

  Soda({
    required this.name,
    required this.quantity,
    required this.price,
    required this.imagePath,
  });
}

class SodaScreenController extends GetxController {
  var sodas = <Soda>[].obs;
  var quantities = <int, int>{}.obs;
  final cart = FlutterCart();
  final CartController cartController = Get.find<CartController>();

  @override
  void onInit() {
    super.onInit();
    fetchSodas();
  }

  Future<void> fetchSodas() async {
    final url = Uri.parse(ApiService.sodaPricesUrl);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        sodas.assignAll(data.map((item) {
          return Soda(
            name: item['name'],
            quantity: item['stock'],
            price: double.parse(item['price']),
            imagePath: item['imagePath'] ?? 'assets/images/sonda.png',
          );
        }).toList());

        // Initialize quantities with 0 for each soda.
        quantities.assignAll({for (var i = 0; i < sodas.length; i++) i: 0});
        update();
      } else {
        throw Exception('Failed to load sodas');
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'Failed to load sodas. Error: $error',
        backgroundColor: AppTheme.errorColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void incrementQuantity(int index) {
    quantities[index] = quantities[index]! + 1;
  }

  void decrementQuantity(int index) {
    if (quantities[index]! > 0) {
      quantities[index] = quantities[index]! - 1;
    }
  }

  void addToCart(int index) {
    final soda = sodas[index];
    final quantity = quantities[index]!;
    if (quantity > 0) {
      cart.addToCart(
        cartModel: CartModel(
          productId: soda.imagePath,
          productName: soda.name,
          quantity: quantity,
          variants: [
            ProductVariant(
              size: 'Default',
              price: soda.price,
            )
          ],
          productDetails: soda.name,
          productMeta: {
            'price': soda.price,
            'imagePath': soda.imagePath,
          },
        ),
      );
      CustomSnackBar.show(
        context: Get.context!,
        message: '${soda.name} added to cart',
        isError: false,
      );
      cartController.cartLength.value = cart.cartLength;
    } else {
      CustomSnackBar.show(
        context: Get.context!,
        message: 'Please select a quantity greater than 0',
        isError: true,
      );
    }
  }

  double calculateTotal() {
    double total = 0;
    for (var i = 0; i < sodas.length; i++) {
      total += sodas[i].price * quantities[i]!;
    }
    return total;
  }
}
