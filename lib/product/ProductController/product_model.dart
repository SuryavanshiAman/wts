class ProductModel {
  final String purchaseDate;
  final String id;
  final String name;
  final int price;
  final String image;
  final String description;
  final int totalIncome;
  final String productValidity;

  ProductModel({
    required this.purchaseDate,
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.totalIncome,
    required this.productValidity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      purchaseDate: json['purchaseDate'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      price: int.parse(json['price']),
      image: json['image'] as String,
      description: json['description'] as String,
      totalIncome: int.parse(json['total_income']),
      productValidity: json['product_validity'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'purchaseDate': purchaseDate,
      'id': id,
      'name': name,
      'price': price.toString(),
      'image': image,
      'description': description,
      'total_income': totalIncome.toString(),
      'product_validity': productValidity,
    };
  }
}
