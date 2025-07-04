import 'dart:convert';

class Product {
  final int? id;
  final int? price;
  final String title;
  final String image;
  final String description;
  final String? brand;
  final String? model;
  final String? color;
  final String? category;
  final int? discount;

  Product({
    required this.id,
    required this.price,
    required this.title,
    required this.image,
    required this.description,
    required this.brand,
    required this.model,
    required this.color,
    required this.category,
    required this.discount,
  });

  Map<String?, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'title': title,
      'image': image,
      'description': description,
      'brand': brand,
      'model': model,
      'color': color,
      'category': category,
      'discount': discount,
    };
  }

  static Product? fromMap(Map<String?, dynamic>? map) {
    if (map == null) return null;
    print("inside the map ${map["id"].runtimeType}");
    try {
      return Product(
        id: map['id'],
        price: int.tryParse("${map['price']}"),
        title: map['title'],
        image: map['image'],
        description: map['description'],
        brand: map['brand'],
        model: map['model'],
        color: map['color'],
        category: map['category'],
        discount: map['discount'],
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  String? toJson() => json.encode(toMap());

  // static Product? fromJson(String? source) =>
  //     Product.fromMap(json.decode(source));
}
