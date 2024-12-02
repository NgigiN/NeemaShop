import 'package:flutter/material.dart';
import 'package:shop_project/widgets/custom_app_bar.dart';
import 'package:shop_project/screens/soda.dart';
import 'package:shop_project/widgets/fat_homepage_buttons.dart';
import 'package:shop_project/screens/milk_product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: const CustomAppBar(
        title: "Neema Milk Shop",
        automaticallyImplyLeading: false, // Disable leading widget for HomePage
      ),
      body: Center(
        child: Column(
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
                          builder: (context) => const MilkProduct(
                            label: "Milk",
                            pricePerLitre: 80,
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
                          builder: (context) => const MilkProduct(
                            label: "Mala",
                            pricePerLitre: 100,
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
                          builder: (context) => const MilkProduct(
                            label: "Yoghurt",
                            pricePerLitre: 140,
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
