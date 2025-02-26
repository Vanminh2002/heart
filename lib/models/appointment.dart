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

  DateTime parseAppointmentDateTime() {
    return DateTime.parse("$date $time"); // "2025-02-15 14:30:00"
  }

  factory AppointmentRequest.fromJson(Map<String, dynamic> json) {
    return AppointmentRequest(
      id: json['id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      date: json['date'], // "2025-02-15"
      time: json['time'], // "14:30:00"
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'patientId': patientId,
      'doctorId': doctorId,
      'date': date,
      'time': time,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
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
      id: json['data']['id'],
      appointmentTime: json['data']['appointmentTime'] ?? '',
      status: AppointmentStatus.values.firstWhere(
            (e) => e.toString() == 'AppointmentStatus.${json['data']['status']}',
        orElse: () => AppointmentStatus.pending,
      ),
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

class Appointment {
  final int id;
  final int doctorId; // 👈 Thêm doctorId để đồng bộ dữ liệu bác sĩ
  final String doctorName;
  final String date;
  final String time;
  final String status;

  Appointment({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.date,
    required this.time,
    required this.status,
  });
// Thêm phương thức `copyWith`
  Appointment copyWith({
    int? id,
    int? doctorId,
    String? doctorName,
    String? date,
    String? time,
    String? status,
  }) {
    return Appointment(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] ?? 0,
      doctorId: json['doctorId'] ?? 0, // 👈 Thêm doctorId từ API
      doctorName: json['doctorName'] ?? "Unknown",
      date: json['date'] ?? "N/A",
      time: json['time'] ?? "N/A",
      status: json['status'] ?? "PENDING",
    );
  }
}
