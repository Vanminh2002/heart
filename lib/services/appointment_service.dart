import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:heart/services/patient_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/appointment.dart';
import '../models/common.dart';
import '../models/doctor.dart';
import '../models/patient.dart';

class AppointmentService {
  final String baseUrl = '${Common.domain}/appointment';

  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  Future<List<Doctor>> fetchDoctors() async {
    final response =
        await http.get(Uri.parse('${Common.domain}/doctor'), headers: headers);
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((doctor) => Doctor.fromJson(doctor))
          .toList();
    } else {
      throw Exception('Failed to fetch doctors');
    }
  }

  Future<AppointmentResponse> bookAppointment(
      AppointmentRequest request) async {
    print("📤 Sending request: ${json.encode(request.toJson())}");

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: json.encode(request.toJson()),
    );

    print("📥 Received response: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return AppointmentResponse.fromJson(json.decode(response.body));
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
      throw Exception('Failed to book appointment: ${response.body}');
    }
  }

  Future<Patient?> getCurrentPatient() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
      String? token = prefs.getString('token');

      if (userId == null || token == null) {
        throw Exception('User not logged in');
      }

      PatientService patientService = PatientService();
      var patientData = await patientService.fetchPatientAPI(userId, token);
      if (patientData != null) {
        return Patient.fromJson(patientData);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching current patient: $e');
      return null;
    }
  }

  // static Future<List<Appointment>> fetchAppointments(int patientId) async {
  //
  //   print("📡 Fetching appointments for patientId: $patientId");
  //   final String baseUrl = '${Common.domain}/appointment/get-by-patient/$patientId';
  //   final Uri url = Uri.parse(baseUrl);
  //   final prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString("token"); // Lấy token từ SharedPreferences
  //
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json; charset=UTF-8",
  //     if (token != null) "Authorization": "Bearer $token",
  //     // Truyền token nếu có
  //   };
  //
  //   final response = await http.get(url, headers: headers);
  //
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonResponse = json.decode(response.body);
  //     return jsonResponse.map((json) => Appointment.fromJson(json)).toList();
  //   } else {
  //     throw Exception("Failed to load appointments: ${response.body}");
  //   }
  // }
  static Future<List<Appointment>> fetchAppointments(int patientId, String token) async {
    try {
      print("📌 Fetching appointments for patientId: $patientId");

      final response = await http.get(
        Uri.parse('${Common.domain}/appointment/get-by-patient/$patientId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("📌 API Response: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic> && responseData.containsKey("data")) {
          List<dynamic> appointmentList = responseData["data"];
          return appointmentList.map((json) => Appointment.fromJson(json)).toList();
        } else {
          throw Exception("Invalid API response format: expected a list in 'data' key");
        }
      } else {
        throw Exception("Failed to load appointments: ${response.body}");
      }
    } catch (e) {
      print("❌ Error fetching appointments: $e");
      return [];
    }
  }
  //  Future<bool> updateAppointment(Appointment appointment) async {
  //   final url = Uri.parse('$baseUrl/${appointment.id}');
  //
  //   final response = await http.put(
  //     url,
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode({
  //       "date": appointment.date,
  //       "time": appointment.time,
  //       "doctorId": appointment.doctorId,  // Nếu muốn cập nhật bác sĩ
  //     }),
  //   );
  //
  //   return response.statusCode == 200;
  // }
  Future<bool> updateAppointment(int appointmentId, Map<String, dynamic> updateData) async {
    final url = Uri.parse('$baseUrl/$appointmentId');  // ✅ Sử dụng ID thay vì `appointment.id`

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(updateData),  // ✅ Truyền dữ liệu update dạng Map
    );

    return response.statusCode == 200;
  }
}
