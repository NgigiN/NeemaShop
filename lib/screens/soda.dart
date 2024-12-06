import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/soda_screen_controller.dart';
import '../../configs/theme.dart';
import '../widgets/add_to_cart_button.dart';

class SodaScreen extends StatelessWidget {
  const SodaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sodaScreenController = Get.put(SodaScreenController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Soda",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.black,
      ),
      body: GetBuilder<SodaScreenController>(
        builder: (controller) {
          return controller.sodas.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: controller.sodas.length,
                  itemBuilder: (context, index) {
                    final soda = controller.sodas[index];
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
                                      onPressed: () =>
                                          controller.decrementQuantity(index),
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Obx(() => Text(
                                        '${controller.quantities[index]}')),
                                    IconButton(
                                      onPressed: () =>
                                          controller.incrementQuantity(index),
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                                AddToCartButton(
                                  onPressed: () => controller.addToCart(index),
                                  padding: const EdgeInsets.all(10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Text(
            'Total: ${sodaScreenController.calculateTotal()}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
