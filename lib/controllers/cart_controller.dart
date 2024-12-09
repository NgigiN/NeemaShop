import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final FlutterCart cart = FlutterCart();
  var cartLength = 0.obs;

  CartController() {
    // Initialize the cart before trying to use it
    _initializeCart();
  }

  Future<void> _initializeCart() async {
    // Enable persistence if needed
    await cart.initializeCart(isPersistenceSupportEnabled: true);
    _updateCartLength();
  }

  @override
  void onInit() {
    super.onInit();
    // Ensure cart is initialized
    // Add observer to track cart changes
    cart.addObserver(_updateCartLength);
  }

  void _updateCartLength() {
    // Safely get cart length after initialization
    cartLength.value = cart.cartItemsList.length;
  }

  @override
  void onClose() {
    // Remove observer when controller is closed
    cart.removeObserver(_updateCartLength);
    super.onClose();
  }

  // Add methods to explicitly update cart length when needed
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
