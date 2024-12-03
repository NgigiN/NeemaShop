class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  Product({this.id = '', this.name = '', this.price = 0.0, this.imageUrl = ''});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      imageUrl: map['imageUrl'],
    );
  }
}
