import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:shop_project/configs/theme.dart';
import 'package:shop_project/screens/main_screen.dart';
import 'package:shop_project/widgets/add_to_cart_button.dart';
import 'package:shop_project/widgets/custom_snackbar.dart';

class MilkProduct extends StatefulWidget {
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
  MilkProductState createState() => MilkProductState();
}

class MilkProductState extends State<MilkProduct> {
  int _quantity = 1;
  final cart = FlutterCart();

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  void _addToCart() {
    cart.addToCart(
      cartModel: CartModel(
        productId: widget.imagePath,
        productName: widget.label,
        quantity: _quantity,
        variants: [
          ProductVariant(size: 'Default', price: widget.pricePerLitre)
        ],
        productDetails: widget.label,
        productMeta: {
          'imagePath': widget.imagePath,
          'label': widget.label,
        },
      ),
    );

    CustomSnackBar.show(
      context: context,
      message: '${widget.label} added to cart',
      isError: false,
    );

    MainScreenState.cartLengthNotifier.value = cart.cartLength;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.black,
      ),
      body: Column(
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
                    widget.imagePath,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.label,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Price: Ksh ${widget.pricePerLitre} per Litre",
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
                  Text(
                    '$_quantity litre${_quantity > 1 ? 's' : ''} @ ${widget.pricePerLitre}/=',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _decrementQuantity,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        '$_quantity',
                        style: const TextStyle(
                            fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _incrementQuantity,
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
                          Text(
                            '${_quantity * widget.pricePerLitre}/=',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      AddToCartButton(onPressed: _addToCart)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
