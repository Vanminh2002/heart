class Doctor {
  final int id;
  final String fullName;
  final String specialty;
  final String phoneNumber;
  final String email;
  final String imageUrl;
  final DateTime availableTime;
  final DateTime dateJoined;

  Doctor(
      {required this.id,
      required this.fullName,
      required this.specialty,
      required this.phoneNumber,
      required this.email,
      required this.imageUrl,
      required this.availableTime,
      required this.dateJoined});

  // Factory constructor to create a Doctor from JSON
  // Factory constructor to create a Doctor from JSON
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] ?? 0,  // Default value if null
      fullName: json['fullName'] ?? 'Unknown',  // Default value if null
      specialty: json['specialty'] ?? 'Unknown',  // Default value if null
      phoneNumber: json['phoneNumber'] ?? 'N/A',  // Default value if null
      email: json['email'] ?? 'N/A',  // Default value if null
      imageUrl: json['imageUrl'] ?? '',  // Default value if null
      availableTime: json['available_time'] != null
          ? DateTime.parse(json['available_time'])
          : DateTime.now(),  // Default to current time if null
      dateJoined: json['date_joined'] != null
          ? DateTime.parse(json['date_joined'])
          : DateTime.now(),  // Default to current time if null
    );
  }

  // Convert a Doctor to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'specialty': specialty,
      'phoneNumber': phoneNumber,
      'email': email,
      'imageUrl': imageUrl,
      'available_time': availableTime.toIso8601String(),
      'date_joined': dateJoined.toIso8601String(),
    };
  }

  // CopyWith method for immutability
  Doctor copyWith({
    int? id,
    String? fullName,
    String? specialty,
    String? phoneNumber,
    String? email,
    String? imageUrl,
    DateTime? availableTime,
    DateTime? dateJoined,
  }) {
    return Doctor(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      specialty: specialty ?? this.specialty,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      availableTime: availableTime ?? this.availableTime,
      dateJoined: dateJoined ?? this.dateJoined,
    );
  }

  // Override toString for better debugging
  @override
  String toString() {
    return 'Doctor(id: $id, fullName: $fullName, specialty: $specialty, '
        'phoneNumber: $phoneNumber, email: $email, imageUrl: $imageUrl, '
        'availableTime: $availableTime, dateJoined: $dateJoined)';
  }
}