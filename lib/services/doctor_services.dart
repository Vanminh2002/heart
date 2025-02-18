import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/common.dart';
import '../models/doctor.dart';

class DoctorServices {
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
  final String baseUrl = '${Common.domain}/doctor';
  Future<List<Doctor>> fetchDoctors() async {
    final response = await http.get(Uri.parse(baseUrl));
    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);  // Giải mã thành Map<String, dynamic>

        // Kiểm tra xem trong dữ liệu trả về có trường 'data' chứa danh sách bác sĩ hay không
        if (data.containsKey('data')) {
          List<dynamic> doctorData = data['data'];  // Lấy danh sách bác sĩ từ trường 'data'

          return doctorData.map((json) => Doctor.fromJson(json)).toList();  // Chuyển danh sách dữ liệu thành danh sách đối tượng Doctor
        } else {
          throw Exception("No 'data' field found in the response.");
        }
      } else {
        throw Exception("Failed to load doctors. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching doctors: $e");
    }
  }
  Future<Doctor> fetchDoctorById(int id) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/$id"));
      if (response.statusCode == 200) {
        return Doctor.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load doctor. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching doctor by ID: $e");
    }
  }


}
