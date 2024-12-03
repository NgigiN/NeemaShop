import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import 'package:shop_project/configs/theme.dart';
import 'package:shop_project/screens/main_screen.dart';
import 'package:shop_project/widgets/add_to_cart_button.dart';
import 'package:shop_project/widgets/custom_snackbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Soda {
  final String name;
  final int quantity;
  final double price;
  final String imagePath;

  Soda(
      {required this.name,
      required this.quantity,
      required this.price,
      required this.imagePath});
}

class SodaScreen extends StatefulWidget {
  const SodaScreen({super.key});

  @override
  SodaScreenState createState() => SodaScreenState();
}

class SodaScreenState extends State<SodaScreen> {
  List<Soda> sodas = [];
  Map<int, int> quantities = {};
  final cart = FlutterCart();

  @override
  void initState() {
    super.initState();
    fetchSodas();
  }

  Future<void> fetchSodas() async {
    final url = Uri.parse('http://127.0.0.1:8000/products/soda/price/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          sodas = data.map((item) {
            return Soda(
              name: item['name'],
              quantity: item['stock'],
              price: double.parse(item['price']),
              imagePath: item['imagePath'] ?? 'assets/images/sonda.png',
            );
          }).toList();

          // Initialize quantities with 0 for each soda.
          quantities = {for (var i = 0; i < sodas.length; i++) i: 0};
        });
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
      // Optionally show an error message in the UI
    }
  }

  void incrementQuantity(int index) {
    setState(() {
      quantities[index] = quantities[index]! + 1;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (quantities[index]! > 0) {
        quantities[index] = quantities[index]! - 1;
      }
    });
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
        context: context,
        message: '${soda.name} added to cart',
        isError: false,
      );
      MainScreenState.cartLengthNotifier.value = cart.cartLength;
    } else {
      CustomSnackBar.show(
        context: context,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Soda",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.black,
      ),
      body: sodas.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: sodas.length,
              itemBuilder: (context, index) {
                final soda = sodas[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          soda.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text('Ksh ${soda.price}'),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => decrementQuantity(index),
                                  icon: const Icon(Icons.remove),
                                  style: IconButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Text('${quantities[index]}'),
                                IconButton(
                                  onPressed: () => incrementQuantity(index),
                                  icon: const Icon(Icons.add),
                                  style: IconButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AddToCartButton(
                              onPressed: () => addToCart(index),
                              padding: const EdgeInsets.all(10),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Total: ${calculateTotal()}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
