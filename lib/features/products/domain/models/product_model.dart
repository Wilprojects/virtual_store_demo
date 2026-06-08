class ProductModel {
  final String id;
  final String categoryId;
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
        id: json['id'] as String,
        categoryId: json['category_id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        imageUrl: json['image_url'] as String,
        price: json['price'] as double
    );
  }

}