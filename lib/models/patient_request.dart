class PatientRequest {
  String fullName;
  String birthday;
  int gender;
  String phoneNumber;
  String email;
  String address;
  String username;
  String password;

  PatientRequest({
    required this.fullName,
    required this.birthday,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'birthday': birthday,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'username': username,
      'password': password,
    };
  }
}