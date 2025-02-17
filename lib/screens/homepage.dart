import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_page_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../screens/soda.dart';
import 'package:shop_project/widgets/fat_homepage_buttons.dart';
import '../screens/milk_product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homePageController = Get.put(HomePageController());

    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: const CustomAppBar(
        title: "Neema Milk Shop",
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<HomePageController>(
        builder: (controller) {
          return Center(
            child: controller.prices.isEmpty
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
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => MilkProduct(
                                //       label: "Milk",
                                //       pricePerLitre: double.parse(
                                //           controller.prices['Milk']),
                                //       imagePath: 'assets/images/milo.png',
                                //     ),
                                //   ),
                                // );
                                Get.to(
                                  () => MilkProduct(
                                    label: "Milk",
                                    pricePerLitre:
                                        double.parse(controller.prices['Milk']),
                                    imagePath: 'assets/images/milo.png',
                                  ),
                                  preventDuplicates: false,
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
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => MilkProduct(
                                //       label: "Mala",
                                //       pricePerLitre: double.parse(
                                //           controller.prices['Mala']),
                                //       imagePath: 'assets/images/ka_mala.png',
                                //     ),
                                //   ),
                                // );
                                Get.to(
                                  () => MilkProduct(
                                    label: "Mala",
                                    pricePerLitre:
                                        double.parse(controller.prices['Mala']),
                                    imagePath: 'assets/images/ka_mala.png',
                                  ),
                                  preventDuplicates: false,
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
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => MilkProduct(
                                //       label: "Yoghurt",
                                //       pricePerLitre: double.parse(
                                //           controller.prices['Yoghurt']),
                                //       imagePath: 'assets/images/yonje.png',
                                //     ),
                                //   ),
                                // );
                                Get.to(
                                  () => MilkProduct(
                                    label: "Yoghurt",
                                    pricePerLitre: double.parse(
                                        controller.prices['Yoghurt']),
                                    imagePath: 'assets/images/yonje.png',
                                  ),
                                  preventDuplicates: false,
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
          );
        },
      ),
    );
  }
}
