import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String? password;
  final String token;

  User({required this.id, required this.username, this.password, required this.token});

  // Chuyển đổi từ JSON thành đối tượng User
  factory User.fromJson(Map<String, dynamic> json) {
    final data = json["data"]; // Lấy object "data"
    if (data == null || data["token"] == null || data["id"] == null || data["username"] == null) {
      throw Exception("Missing required fields in API response");
    }

    return User(
      id: data["id"].toString(), // ✅ Ép kiểu về String để tránh lỗi
      username: data["username"], // ✅ Lấy từ `data`, không phải `json`
      password: json.containsKey('password') ? json['password'] as String? : null, // ✅ Kiểm tra tránh lỗi
      token: data["token"],
    );
  }

  // Chuyển đổi từ đối tượng User thành JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "password": password,
      "token": token,
    };
  }

  @override
  List<Object?> get props => [id, username, token];
}
