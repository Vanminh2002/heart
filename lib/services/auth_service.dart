import 'dart:convert';
import 'package:heart/services/patient_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/common.dart';
import '../models/patient.dart';
import '../models/user.dart';

class AuthService {
  final String baseUrl = '${Common.domain}/auth'; // Đảm bảo URL chính xác

  // Hàm đăng nhập và lấy token
  Future<User?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      print("Raw Response: ${response.body}"); // Debug response

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Kiểm tra dữ liệu tránh lỗi Null
        if (data['data'] == null || data['data']['token'] == null || data['data']['id'] == null) {
          print("❌ API không trả về dữ liệu hợp lệ!");
          return null;
        }

        String token = data['data']['token'];
        String userId = data['data']['id'].toString(); // ✅ Ép kiểu về String để tránh lỗi

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('userId', userId); // ✅ Lưu ID dạng String

        print("✅ Đăng nhập thành công! User ID: $userId");

        // Lấy thông tin bệnh nhân nếu có ID
        PatientService patientService = PatientService();
        var patientData = await patientService.fetchPatientAPI(userId, token);

        if (patientData != null) {
          Patient patient = Patient.fromJson(patientData);
          await patientService.savePatientInfo(patient);
          print("✅ Lưu thông tin bệnh nhân thành công!");
        } else {
          print("❌ Không tìm thấy thông tin bệnh nhân!");
        }

        // ✅ Sử dụng User.fromJson để lấy chính xác dữ liệu từ API
        return User.fromJson(data);
      } else {
        print("❌ Lỗi đăng nhập: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Error during login: $e");
    }
    return null;
  }

  // Hàm lấy token từ SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Hàm lấy ID người dùng từ SharedPreferences
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  // Hàm đăng xuất
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userId'); // Xóa luôn ID
  }

  // Hàm lấy thông tin user
  Future<User?> fetchUserInfo() async {
    final token = await getToken(); // ✅ Lấy token trước khi gọi API
    if (token == null) {
      print("⚠️ Không tìm thấy token, cần đăng nhập lại.");
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse('${Common.domain}/user'),
        headers: {
          'Authorization': 'Bearer $token', // ✅ Gửi token trong header
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data['data']); // ✅ Chuyển đổi từ JSON sang User
      } else {
        print("❌ Lỗi lấy thông tin user: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Error fetching user data: $e");
    }
    return null;
  }
}
