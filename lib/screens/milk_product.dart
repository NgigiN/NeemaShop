import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/milk_product_controller.dart';
import '../../configs/theme.dart';
import '../widgets/add_to_cart_button.dart';

class MilkProduct extends StatelessWidget {
  final String label;
  final double pricePerLitre;
  final String imagePath;

  const MilkProduct({
    super.key,
    required this.label,
    required this.pricePerLitre,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final milkProductController = Get.put(MilkProductController(
      label: label,
      pricePerLitre: pricePerLitre,
      imagePath: imagePath,
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.black,
      ),
      body: GetBuilder<MilkProductController>(
        builder: (controller) {
          return Column(
            children: [
              Flexible(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        imagePath,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Price: Ksh $pricePerLitre per Litre",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom half
              Flexible(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "This is fresh milk sourced from local farms, perfect for daily use.",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      Obx(() => Text(
                            '${controller.quantity} litre${controller.quantity > 1 ? 's' : ''} @ $pricePerLitre/=',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: controller.decrementQuantity,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Icon(Icons.remove),
                          ),
                          const SizedBox(width: 20),
                          Obx(() => Text(
                                '${controller.quantity}',
                                style: const TextStyle(
                                    fontSize: 48, fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: controller.incrementQuantity,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      const Spacer(), // Pushes the row to the bottom
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Price:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              Obx(() => Text(
                                    '${controller.quantity * pricePerLitre}/=',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ],
                          ),
                          AddToCartButton(onPressed: controller.addToCart)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
