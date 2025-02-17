import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import '../widgets/custom_snackbar.dart';
import '../controllers/cart_controller.dart';

class MilkProductController extends GetxController {
  final String label;
  final double pricePerLitre;
  final String imagePath;
  var quantity = 1.obs;
  final cart = FlutterCart();
  final CartController cartController = Get.find<CartController>();

  MilkProductController({
    required this.label,
    required this.pricePerLitre,
    required this.imagePath,
  });

  @override
  void onClose() {
    quantity.close();
    super.onClose();
  }

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }

  void addToCart() {
    cart.addToCart(
      cartModel: CartModel(
        productId: imagePath,
        productName: label,
        quantity: quantity.value,
        variants: [ProductVariant(size: 'Default', price: pricePerLitre)],
        productDetails: label,
        productMeta: {
          'imagePath': imagePath,
          'label': label,
        },
      ),
    );

    CustomSnackBar.show(
      context: Get.context!,
      message: '$label added to cart',
      isError: false,
    );

    cartController.cartLength.value = cart.cartLength;
  }
}
