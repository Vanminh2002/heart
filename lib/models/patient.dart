class Patient {
  int id;
  String fullName;
  String birthday;
  int gender;
  String phoneNumber;
  String? email; // ✅ Cho phép null
  String? address; // ✅ Cho phép null
  String? imageUrl; // ✅ Cho phép null
  String? dateJoined; // ✅ Cho phép null
  int? doctorId; // ✅ Cho phép null
  String username;
  String? password; // ✅ Cho phép null

  Patient({
    required this.id,
    required this.fullName,
    required this.birthday,
    required this.gender,
    required this.phoneNumber,
    this.email,
    this.address,
    this.imageUrl,
    this.dateJoined,
    this.doctorId,
    required this.username,
    this.password,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? 0,
      fullName: json['fullName'] ?? 'Unknown',
      birthday: json['birthday'] ?? '',
      gender: json['gender'] ?? 0,
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'], // ✅ Không ép kiểu nếu null
      address: json['address'], // ✅ Không ép kiểu nếu null
      imageUrl: json['imageUrl'], // ✅ Không ép kiểu nếu null
      dateJoined: json['dateJoined'], // ✅ Không ép kiểu nếu null
      doctorId: json['doctorId'], // ✅ Không ép kiểu nếu null
      username: json['username'] ?? '',
      password: json['password'], // ✅ Không ép kiểu nếu null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'birthday': birthday,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email, // ✅ Có thể null
      'address': address, // ✅ Có thể null
      'imageUrl': imageUrl, // ✅ Có thể null
      'dateJoined': dateJoined, // ✅ Có thể null
      'doctorId': doctorId, // ✅ Có thể null
      'username': username,
      'password': password, // ✅ Có thể null
    };
  }
}
