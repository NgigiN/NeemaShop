import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:shop_project/configs/theme.dart';
import 'package:shop_project/widgets/custom_app_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final FlutterCart cart = FlutterCart();

  void _removeItem(CartModel item) {
    setState(() {
      cart.removeItem(item.productId, item.variants);
    });
  }

  void _updateQuantity(CartModel item, int newQuantity) {
    setState(() {
      cart.updateQuantity(item.productId, item.variants, newQuantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Cart",
        automaticallyImplyLeading: false, // Disable leading widget for HomePage
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItemsList.length,
              itemBuilder: (context, index) {
                final item = cart.cartItemsList[index];
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
                        onPressed: () => _updateQuantity(
                            item,
                            item.quantity > 1
                                ? item.quantity - 1
                                : item.quantity),
                      ),
                      Text('${item.quantity}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () =>
                            _updateQuantity(item, item.quantity + 1),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removeItem(item),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total: Ksh ${cart.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    // Implement checkout logic
                    cart.clearCart();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Order placed successfully!')),
                    );
                  },
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
