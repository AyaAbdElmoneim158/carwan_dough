class MenuItemModel {
  final String id;
  final String name;
  final String image;
  final double price;
  const MenuItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'price': price,
    };
  }

  factory MenuItemModel.fromMap(Map<String, dynamic> map) {
    return MenuItemModel(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      // price: map['price'] as double,
      price: (map['price'] as num).toDouble(), // ✅ FIX
    );
  }
}
