import 'dart:convert';

import '../models/common.dart';
import '../models/medicine.dart';
import 'package:http/http.dart' as http;

class MedicineServices {
  final String baseUrl = '${Common.domain}/medication';

  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  Future<List<Medicine>> fetchMedicines() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("Data đã decode: $data"); // Debug kiểm tra API

      if (data is Map<String, dynamic> && data.containsKey("data")) {
        return (data["data"] as List)
            .map((json) => Medicine.fromJson(json))
            .toList();
      } else {
        throw Exception("Dữ liệu API không chứa danh sách thuốc!");
      }
    } else {
      throw Exception("Lỗi khi gọi API: ${response.statusCode}");
    }
  }

}