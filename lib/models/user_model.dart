class UserData {
  UserData({
    required this.data,
    required this.token,
  });

  final User? data;
  final String? token;

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      data: json["data"] == null ? null : User.fromJson(json["data"]),
      token: json["token"],
    );
  }
}

class User {
  User({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.pass,
  });

  final int id;
  final String phoneNumber;
  final String name;
  final String pass;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      phoneNumber: json["phone_number"],
      name: json["name"],
      pass: json["pass"],
    );
  }
}
