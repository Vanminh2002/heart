import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/common.dart';
import '../models/patient.dart';
import '../models/patient_request.dart';

class PatientService {
  final String baseUrl = '${Common.domain}/patient';

  // Đăng ký bệnh nhân
  Future<void> registerPatient(
      PatientRequest patientRequest, String token) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // ✅ Thêm xác thực nếu cần
        },
        body: json.encode(patientRequest.toJson()),
      );

      if (response.statusCode == 201) {
        print('✅ Patient registered successfully');
      } else {
        print("❌ Lỗi khi đăng ký bệnh nhân: ${response.body}");
        throw Exception('Failed to register patient');
      }
    } catch (e) {
      print("🚨 Error in registerPatient: $e");
      throw Exception("Error registering patient: $e");
    }
  }

  // Lấy thông tin bệnh nhân từ SharedPreferences
  Future<Patient?> fetchPatient() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? patientJson = prefs.getString("patient");

      if (patientJson == null) {
        print("⚠️ Không tìm thấy dữ liệu bệnh nhân trong Local Storage.");
        return null; // ✅ Trả về null thay vì ném Exception
      }

      return Patient.fromJson(jsonDecode(patientJson));
    } catch (e) {
      print("🚨 Lỗi khi lấy bệnh nhân từ local storage: $e");
      return null;
    }
  }

  // Hàm lấy bệnh nhân từ bộ nhớ (thực tế giống fetchPatient, có thể gộp lại)
  Future<Patient?> getPatientFromStorage() async {
    return fetchPatient(); // ✅ Dùng chung với fetchPatient()
  }

  // Gọi API lấy thông tin bệnh nhân bằng userId
  Future<Map<String, dynamic>?> fetchPatientAPI(
      String userId, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/by-user/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['data'] == null) {
          print("⚠️ API không trả về dữ liệu bệnh nhân.");
          return null; // ✅ Xử lý trường hợp dữ liệu null
        }

        print("✅ Lấy thông tin bệnh nhân thành công: ${response.body}");
        return responseData['data'];
      } else {
        print(
            "❌ Lỗi lấy thông tin bệnh nhân: ${response.statusCode}, ${response.body}");
        return null;
      }
    } catch (e) {
      print("🚨 Lỗi khi gọi API lấy bệnh nhân: $e");
      return null;
    }
  }

  // Lưu thông tin bệnh nhân vào SharedPreferences
  // Future<void> savePatientInfo(Patient patient) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     String patientJson = jsonEncode(patient.toJson());
  //
  //     print("💾 Đang lưu thông tin bệnh nhân: $patientJson");
  //     await prefs.setString('patient', patientJson);
  //     print("✅ Lưu thông tin bệnh nhân thành công!");
  //   } catch (e) {
  //     print("🚨 Lỗi khi lưu thông tin bệnh nhân: $e");
  //   }
  // }
// Xóa
  // Future<void> clearStoredData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  //   print("🗑 Đã xóa toàn bộ dữ liệu SharedPreferences");
  // }

  Future<void> savePatientInfo(Patient patient) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("💾 Đang lưu thông tin bệnh nhân: ${jsonEncode(patient.toJson())}");

    await prefs.setInt('patientId', patient.id); // Lưu patientId
    await prefs.setString(
        'patientInfo', jsonEncode(patient.toJson())); // Lưu thông tin bệnh nhân

    print("✅ Lưu thông tin bệnh nhân thành công!");
  }

  // Xóa thông tin bệnh nhân khi đăng xuất
  Future<void> clearPatientInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('patient');
      print("✅ Đã xóa thông tin bệnh nhân khỏi bộ nhớ.");
    } catch (e) {
      print("🚨 Lỗi khi xóa thông tin bệnh nhân: $e");
    }
  }

  Future<Patient> getPatientInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      String? userId =
          prefs.getString("userId"); // 🔥 Lấy userId từ storage nếu có

      if (token == null || userId == null) {
        throw Exception("❌ Token hoặc userId bị null.");
      }

      final response = await http.get(
        Uri.parse('$baseUrl/by-user/$userId'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['data'] != null) {
          Patient patient = Patient.fromJson(responseData['data']);

          // ✅ Lưu lại thông tin bệnh nhân vào SharedPreferences
          await savePatientInfo(patient);

          print("✅ Lấy thông tin bệnh nhân thành công: ${patient.id}");
          return patient;
        } else {
          throw Exception("⚠️ API không trả về dữ liệu bệnh nhân.");
        }
      } else {
        throw Exception(
            "❌ Lỗi khi gọi API: ${response.statusCode}, ${response.body}");
      }
    } catch (e) {
      print("🚨 Lỗi trong getPatientInfo(): $e");
      rethrow;
    }
  }
}
