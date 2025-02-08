import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:shop_project/configs/theme.dart';
import 'package:shop_project/controllers/cart_controller.dart';
import 'package:shop_project/widgets/custom_app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.find<CartController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool _isLoading = false;
  String? _userToken;
  String? _userName;
  String? _userEmail;
  String? _userPhoneNumber;

  @override
  void initState() {
    super.initState();
    _loadUserToken();
    _loadUserName();
    _loadUserEmail();
    _loadUserPhoneNumber();
  }

  Future<void> _loadUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userToken = prefs.getString('user_token');
    });
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('first_name') ?? 'none';
      nameController.text = _userName ?? '';
    });
  }

  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userEmail = prefs.getString('email');
    });
  }

  Future<void> _loadUserPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userPhoneNumber = prefs.getString('phone_number');
      phoneController.text = _userPhoneNumber ?? '';
    });
  }

  void _removeItem(CartModel item) {
    setState(() {
      cartController.cart.removeItem(item.productId, item.variants);
    });
  }

  void _updateQuantity(CartModel item, int newQuantity) {
    setState(() {
      cartController.cart
          .updateQuantity(item.productId, item.variants, newQuantity);
    });
  }

  void _showBookingDialog() {
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
              onPressed: _confirmBooking,
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _confirmBooking() async {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name to book.')),
      );
      return;
    }

    if (_userEmail == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in!')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/products/bookings/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $_userToken',
        },
        body: jsonEncode({
          'email': _userEmail,
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
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<List<dynamic>> fetchHistory() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8000/products/bookings/history/$_userName'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $_userToken',
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

  void showHistoryDialog() async {
    try {
      final history = await fetchHistory();
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching history: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Cart",
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          if (cartController.cart.cartItemsList.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cart.cartItemsList.length,
                itemBuilder: (context, index) {
                  final item = cartController.cart.cartItemsList[index];
                  return ListTile(
                    leading: Image.asset(
                      item.productMeta?['imagePath'] ?? '',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.productName),
                    subtitle: Text('Ksh ${item.variants.first.price} each'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => _updateQuantity(
                            item,
                            item.quantity > 1
                                ? item.quantity - 1
                                : item.quantity,
                          ),
                        ),
                        Text('${item.quantity}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () =>
                              _updateQuantity(item, item.quantity + 1),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeItem(item),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          if (_isLoading) const LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total: Ksh ${cartController.cart.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              cartController.cart.cartItemsList.isEmpty
                                  ? Colors.grey
                                  : AppTheme.primaryColor,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: cartController.cart.cartItemsList.isEmpty
                            ? null
                            : _showBookingDialog,
                        child: const Text('Book Now'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        minimumSize: const Size(100, 50),
                      ),
                      onPressed: showHistoryDialog,
                      child: const Icon(Icons.history),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
