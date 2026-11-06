class User {
  int id;
  String name;
  String email;
  String password;

  User(
  {
    required this.id,
    required this.name,
    required this.email,
    required this.password
  }
  );

  // factory user.fromJson(Map<String, dynamic> json) {
  //   return user(
  //     id: json['id'] as int,
  //     nama: json['nama'] as String,
  //     email: json['email'] as String,
  //     password: json['password'] as String,
  //   );
  // }
}