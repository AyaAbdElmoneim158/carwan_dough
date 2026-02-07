import 'package:carwan_dough/models/cart_model.dart';

class OrderModel {
  final String id;
  final String uid;

  final String name;
  final String phone;
  final String address;
  final String notes;

  final List<CartItemModel> cartItems;
  final double total;
  final String deliveryDate;
  final String status;

  OrderModel({
    required this.id,
    required this.status,
    required this.uid,
    required this.name,
    required this.phone,
    required this.address,
    required this.notes,
    required this.cartItems,
    required this.total,
    required this.deliveryDate,
  });

  OrderModel copyWith({
    String? id,
    String? status,
    String? uid,
    String? name,
    String? phone,
    String? address,
    String? notes,
    List<CartItemModel>? cartItems,
    double? total,
    String? deliveryDate,
  }) {
    return OrderModel(
      id: id ?? this.id,
      status: status ?? this.status,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      cartItems: cartItems ?? this.cartItems,
      total: total ?? this.total,
      deliveryDate: deliveryDate ?? this.deliveryDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'uid': uid,
      'name': name,
      'phone': phone,
      'address': address,
      'notes': notes,
      'cartItems': cartItems.map((x) => x.toMap()).toList(),
      'total': total,
      'deliveryDate': deliveryDate,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      status: map['status'] as String,
      uid: map['uid'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      notes: map['notes'] as String,
      cartItems: List<CartItemModel>.from(
        (map['cartItems'] as List).map((x) => CartItemModel.fromMap(x as Map<String, dynamic>)),
      ),
      total: (map['total'] as num).toDouble(),
      deliveryDate: map['deliveryDate'] as String,
    );
  }
}
