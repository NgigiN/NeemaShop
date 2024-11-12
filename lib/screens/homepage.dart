import 'package:flutter/material.dart';
import 'package:shop_project/configs/theme.dart';
import 'package:shop_project/widgets/fat_homepage_buttons.dart';
import 'package:shop_project/screens/milk_product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        title: const Text(
          "Neema Milk Shop",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareIconButton(
                  icon: Icons.water_drop_outlined,
                  size: 200,
                  color: Colors.white,
                  label: "Milk",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const MilkProduct(label: "Milk", pricePerLitre: 80),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
                SquareIconButton(
                  icon: Icons.water_drop_rounded,
                  size: 200,
                  color: Colors.yellow,
                  label: "Mala",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MilkProduct(
                          label: "Mala",
                          pricePerLitre: 100,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareIconButton(
                  icon: Icons.water_drop_outlined,
                  size: 200,
                  color: Colors.pink,
                  label: "Yoghurt",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MilkProduct(
                            label: "Yoghurt", pricePerLitre: 140),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
                SquareIconButton(
                  icon: Icons.water_drop_rounded,
                  size: 200,
                  color: Colors.red,
                  label: "Soda",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const MilkProduct(label: "Soda", pricePerLitre: 50),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
