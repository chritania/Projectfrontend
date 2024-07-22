class Product {
  final int id;
  final String productName;
  final String description;
  final double price;


  Product({
    required this.id,
    required this.productName,
    required this.description,
    required this.price,

  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['productId'],
      productName: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': id,
      'name': productName,
      'description': description,
      'price': price,

    };
  }
}
