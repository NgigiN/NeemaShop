import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shop_project/configs/theme.dart';
import 'package:shop_project/widgets/custom_app_bar.dart';
import 'package:shop_project/screens/soda.dart';
import 'package:shop_project/widgets/fat_homepage_buttons.dart';
import 'package:shop_project/screens/milk_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // Initialize an empty map for prices
  Map<String, dynamic> _prices = {};

  @override
  void initState() {
    super.initState();
    _fetchPrices(); // Fetch prices when the page loads
  }

  Future<void> _fetchPrices() async {
    final url = Uri.parse('http://192.168.24.58:8000/products/milk/price/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _prices = {
            for (var item in data) item['name']: item['price_per_litre']
          };
        });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: const CustomAppBar(
        title: "Neema Milk Shop",
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: _prices.isEmpty
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SquareIconButton(
                          imagePath: 'assets/images/milo.png',
                          size: 200,
                          color: Colors.white.withOpacity(0.9),
                          label: "Milk",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MilkProduct(
                                  label: "Milk",
                                  pricePerLitre: double.parse(_prices['Milk']),
                                  imagePath: 'assets/images/milo.png',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SquareIconButton(
                          imagePath: 'assets/images/ka_mala.png',
                          size: 200,
                          color: Colors.yellow.shade300,
                          label: "Mala",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MilkProduct(
                                  label: "Mala",
                                  pricePerLitre: double.parse(_prices['Mala']),
                                  imagePath: 'assets/images/ka_mala.png',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SquareIconButton(
                          imagePath: 'assets/images/yonje.png',
                          size: 200,
                          color: Colors.pink.shade100,
                          label: "Yoghurt",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MilkProduct(
                                  label: "Yoghurt",
                                  pricePerLitre:
                                      double.parse(_prices['Yoghurt']),
                                  imagePath: 'assets/images/yonje.png',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SquareIconButton(
                          imagePath: 'assets/images/sonda.png',
                          size: 200,
                          color: Colors.red,
                          label: "Soda",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SodaScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
