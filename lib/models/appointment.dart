class AppointmentRequest {
  final int? id;
  final int patientId;
  final int doctorId;
  final String date;
  final String time;

  AppointmentRequest({
     this.id,
    required this.patientId,
    required this.doctorId,
    required this.date,
    required this.time,
  });
  DateTime parseAppointmentDateTime(String date, String time) {
    return DateTime.parse("$date $time"); // "2025-02-15 14:30:00"
  }
  // Chuyển từ JSON thành Object
  factory AppointmentRequest.fromJson(Map<String, dynamic> json) {
    return AppointmentRequest(
      id: json['id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      date: json['date'], // "2025-02-15"
      time: json['time'], // "14:30:00"
    );
  }

  // Chuyển từ Object thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'date': date,
      'time': time,
    };
  }
}

enum AppointmentStatus {
  pending,
  confirmed,
  completed,
  canceled,
}

class AppointmentResponse {
  int id;
  String appointmentTime;
  AppointmentStatus status;

  AppointmentResponse({
    required this.id,
    required this.appointmentTime,
    required this.status,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentResponse(
      id: json['id'],
      appointmentTime: json['appointmentTime'],
      status: AppointmentStatus.values.firstWhere((e) => e.toString() == 'AppointmentStatus.${json['status']}'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appointmentTime': appointmentTime,
      'status': status.toString().split('.').last,
    };
  }
}
