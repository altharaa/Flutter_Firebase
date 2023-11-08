class ProductModel {
  final String name;
  final String category;
  final String id;

  ProductModel({
  required this.name, 
  required this.category, 
  required this.id
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'category': category,
      'id': id,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? "",
      category: map['category'] ?? "",
      id: map['id'] ?? "",
    );
  }
}