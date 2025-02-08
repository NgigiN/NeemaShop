import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final FlutterCart cart = FlutterCart();
  var cartLength = 0.obs;
  var isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeCart();
  }

  Future<void> initializeCart() async {
    if (!isInitialized.value) {
      await cart.initializeCart(isPersistenceSupportEnabled: true);
      isInitialized.value = true;
      _updateCartLength();
    }
  }

  void _updateCartLength() {
    cartLength.value = cart.cartItemsList.length;
  }

  void addToCart(CartModel cartModel) {
    cart.addToCart(cartModel: cartModel);
    _updateCartLength();
  }

  void removeItem(String productId, List<ProductVariant> variants) {
    cart.removeItem(productId, variants);
    _updateCartLength();
  }

  void updateQuantity(
      String productId, List<ProductVariant> variants, int newQuantity) {
    cart.updateQuantity(productId, variants, newQuantity);
    _updateCartLength();
  }

  void clearCart() {
    cart.clearCart();
    _updateCartLength();
  }
}
