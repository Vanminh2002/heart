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
      final response = await http.get(Uri.parse('${Common.domain}/doctor'), headers: headers);
      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((doctor) => Doctor.fromJson(doctor))
            .toList();
      } else {
        throw Exception('Failed to fetch doctors');
      }
    }

    Future<AppointmentResponse> bookAppointment(AppointmentRequest request) async {
      print("📤 Sending request: ${json.encode(request.toJson())}");

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: json.encode(request.toJson()),
      );

      print("📥 Received response: ${response.body}");

      if (response.statusCode == 200) {
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
  }
