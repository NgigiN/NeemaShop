import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:shop_project/configs/theme.dart';
import 'package:shop_project/controllers/cart_controller.dart';
import 'package:shop_project/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartUtils {
  final CartController cartController;
  final BuildContext context;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final Function(bool) setLoading;
  final Function(bool) setHistoryLoading;
  final Function(String?) setUserToken;
  final Function(String?) setUserName;
  final Function(String?) setUserEmail;
  final Function(String?) setUserPhoneNumber;

  CartUtils({
    required this.cartController,
    required this.context,
    required this.nameController,
    required this.phoneController,
    required this.setLoading,
    required this.setHistoryLoading,
    required this.setUserToken,
    required this.setUserName,
    required this.setUserEmail,
    required this.setUserPhoneNumber,
  });

  Future<void> loadUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    setUserToken(prefs.getString('user_token'));
  }

  Future<void> loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('first_name') ?? 'none';
    setUserName(name);
    nameController.text = name;
  }

  Future<void> loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setUserEmail(prefs.getString('email'));
  }

  Future<void> loadUserPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString('phone_number');
    setUserPhoneNumber(phone);
    phoneController.text = phone ?? '';
  }

  void removeItem(CartModel item) {
    cartController.cart.removeItem(item.productId, item.variants);
  }

  void updateQuantity(CartModel item, int newQuantity) {
    cartController.cart
        .updateQuantity(item.productId, item.variants, newQuantity);
  }

  void showBookingDialog(String? userEmail, String? userToken) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Booking'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your Name:'),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Your Phone Number:'),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your phone number',
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Items in your cart:'),
                ...cartController.cart.cartItemsList.map((item) {
                  return ListTile(
                    title: Text(item.productName),
                    subtitle: Text(
                        '${item.quantity} x Ksh ${item.variants.first.price.toStringAsFixed(2)}'),
                  );
                }),
                const SizedBox(height: 10),
                Text(
                  'Total: Ksh ${cartController.cart.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => confirmBooking(userEmail, userToken),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  Future<void> confirmBooking(String? userEmail, String? userToken) async {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name to book.')),
      );
      return;
    }

    if (userEmail == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in!')),
      );
      return;
    }

    setLoading(true);

    try {
      final response = await http.post(
        Uri.parse(ApiService.bookingsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $userToken',
        },
        body: jsonEncode({
          'email': userEmail,
          'customer_name': nameController.text,
          'phone_number': phoneController.text,
          'total_price': cartController.cart.total.toString(),
          'items': cartController.cart.cartItemsList
              .map((item) => {
                    'product_name': item.productName,
                    'quantity': item.quantity,
                    'price_per_litre': item.variants.first.price,
                  })
              .toList(),
        }),
      );

      if (response.statusCode == 201) {
        cartController.clearCart();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking confirmed!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking failed: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setLoading(false);
    }
  }

  Future<List<dynamic>> fetchHistory(
      String? userName, String? userToken) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiService.bookingHistoryUrl}$userName'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $userToken',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load history');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load history. Error: $e',
        backgroundColor: AppTheme.errorColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return [];
    }
  }

  void showHistoryDialog(String? userName, String? userToken) async {
    setHistoryLoading(true);

    try {
      final history = await fetchHistory(userName, userToken);
      setHistoryLoading(false);

      if (!context.mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Booking History"),
          content: SizedBox(
            width: double.maxFinite,
            child: history.isEmpty
                ? const Center(child: Text("No booking history found"))
                : ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final booking = history[index];
                      final items = booking['items'] is List
                          ? booking['items']
                          : [booking['items']];
                      final createdAt = DateTime.parse(booking['created_at']);
                      final formattedDate =
                          "${createdAt.day}/${createdAt.month}/${createdAt.year} ${createdAt.hour}:${createdAt.minute}";

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Center(child: Text(formattedDate)),
                            subtitle: Text(
                              "Total: Ksh ${booking['total_price']}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (final item in items)
                                  Text(
                                      "${item['product_name']} x ${item['price_per_litre']} = ${item['quantity'] * item['price_per_litre']}/="),
                                const Divider(),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      setHistoryLoading(false);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching history: $e')),
      );
    }
  }
}
