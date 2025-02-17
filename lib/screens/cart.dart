import 'package:flutter/material.dart';
import 'package:shop_project/configs/theme.dart';
import 'package:shop_project/controllers/cart_controller.dart';
import 'package:shop_project/widgets/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:shop_project/utils/cart_utils.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.find<CartController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool _isLoading = false;
  bool _isHistoryLoading = false;
  String? _userToken;
  String? _userName;
  String? _userEmail;
  String? _userPhoneNumber;
  late CartUtils cartUtils;

  @override
  void initState() {
    super.initState();
    cartUtils = CartUtils(
      cartController: cartController,
      context: context,
      nameController: nameController,
      phoneController: phoneController,
      setLoading: (value) => setState(() => _isLoading = value),
      setHistoryLoading: (value) => setState(() => _isHistoryLoading = value),
      setUserToken: (value) => setState(() => _userToken = value),
      setUserName: (value) => setState(() => _userName = value),
      setUserEmail: (value) => setState(() => _userEmail = value),
      setUserPhoneNumber: (value) => setState(() => _userPhoneNumber = value),
    );
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    await cartUtils.loadUserToken();
    await cartUtils.loadUserName();
    await cartUtils.loadUserEmail();
    await cartUtils.loadUserPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Cart",
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          if (cartController.cart.cartItemsList.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cart.cartItemsList[index];
                  return ListTile(
                    leading: Image.asset(
                      item.productMeta?['imagePath'] ?? '',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.productName),
                    subtitle: Text('Ksh ${item.variants.first.price} each'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => cartUtils.updateQuantity(
                            item,
                            item.quantity > 1
                                ? item.quantity - 1
                                : item.quantity,
                          ),
                        ),
                        Text('${item.quantity}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () =>
                              cartUtils.updateQuantity(item, item.quantity + 1),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => cartUtils.removeItem(item),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          if (_isLoading) const LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total: Ksh ${cartController.cart.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              cartController.cart.cartItemsList.isEmpty
                                  ? Colors.grey
                                  : AppTheme.primaryColor,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: cartController.cart.cartItemsList.isEmpty
                            ? null
                            : () => cartUtils.showBookingDialog(
                                _userEmail, _userToken),
                        child: const Text('Book Now'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        minimumSize: const Size(100, 50),
                      ),
                      onPressed: _isHistoryLoading
                          ? null
                          : () => cartUtils.showHistoryDialog(
                              _userName, _userToken),
                      child: _isHistoryLoading
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.history),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
