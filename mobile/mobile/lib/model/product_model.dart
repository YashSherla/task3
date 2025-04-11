class ProductModel {
  final int id;
  final String name;
  final int price;
  final String imageUrl;
  final int discount;
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.discount,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    int? price,
    String? imageUrl,
    int? discount,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      discount: discount ?? this.discount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'discount': discount,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'] as int,
      imageUrl: map['imageUrl'] as String,
      discount: map['discount'] as int,
    );
  }
}
