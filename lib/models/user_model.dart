class UserModel {
  String uid;
  String email;
  String name;
  String phone;
  String password;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? phone,
    String? password,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
    );
  }
}
