class CartItemModel {
  final String id;
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String image;

  const CartItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.image = "",
  });

  CartItemModel copyWith({
    String? id,
    String? productId,
    String? name,
    double? price,
    int? quantity,
    String? image,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
    );
  }

  // Helper methods
  double get totalPrice => price * quantity;

  String get displayName => name;

  String get displayPrice => '${price.toStringAsFixed(2)} E£';

  String get displayTotal => '${totalPrice.toStringAsFixed(2)} E£';

  String get quantityString => 'x$quantity';

  // For UI comparison
  bool isSameProduct(CartItemModel other) {
    return productId == other.productId;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': image,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as String,
      productId: map['productId'] as String,
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      quantity: (map['quantity'] as num).toInt(),
      image: map['image'] as String,
    );
  }

  // For API requests
  Map<String, dynamic> toApiJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemModel && runtimeType == other.runtimeType && id == other.id && productId == other.productId && name == other.name && price == other.price && quantity == other.quantity && image == other.image;

  @override
  int get hashCode => id.hashCode ^ productId.hashCode ^ name.hashCode ^ price.hashCode ^ quantity.hashCode ^ image.hashCode;

  @override
  String toString() {
    return 'CartItemModel(id: $id, productId: $productId, name: $name, price: $price, quantity: $quantity, image: $image)';
  }
}
