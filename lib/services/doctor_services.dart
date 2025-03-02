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
      print("API Response: ${response.body}"); // 🔥 Debug response từ API
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Lấy dữ liệu đúng từ `data`
        if (jsonResponse.containsKey('data')) {
          return Doctor.fromJson(jsonResponse['data']);
        } else {
          throw Exception("API response does not contain 'data' field");
        }
      } else {
        throw Exception("Failed to load doctor");
      }
    } catch (e) {
      throw Exception("Error fetching doctor by ID: $e");
    }
  }

   Future<List<Doctor>> searchDoctors(String name) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/name/$name'));
      final jsonData = jsonDecode(response.body);

      print("API Response: $jsonData"); // Kiểm tra dữ liệu trả về

      if (jsonData is List) {
        List<Doctor> results = jsonData.map((doc) => Doctor.fromJson(doc)).toList();
        return results;
      } else if (jsonData is Map<String, dynamic>) {
        if (jsonData.containsKey("data")) {
          // Giả sử API trả về { "data": [...] }
          List<Doctor> results = (jsonData["data"] as List)
              .map((doc) => Doctor.fromJson(doc))
              .toList();
          return results;
        } else {
          throw Exception("Invalid API response format");
        }
      } else {
        throw Exception("Unexpected response type");
      }
    } catch (e) {
      print("Error fetching doctors: $e");
      throw Exception("Failed to load doctors");
    }

  }
}
