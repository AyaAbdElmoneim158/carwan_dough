import 'package:carwan_dough/utils/app_constant.dart';

class UserModel {
  String uid;
  String email;
  String name;
  String phone;
  String password;
  Role role;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
    this.role = Role.client,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? phone,
    String? password,
    Role? role,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'password': password,
      'role': role.name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    map ??= {}; // if null, fallback to empty map
    return UserModel(
      uid: map['uid'] as String? ?? '',
      email: map['email'] as String? ?? '',
      name: map['name'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      password: map['password'] as String? ?? '',
      role: Role.values.firstWhere(
        (role) => role.name == (map!['role'] as String?),
        orElse: () => Role.client,
      ),
    );
  }
}
