import 'package:flutter/material.dart';
import 'package:heart/screens/user/widgets/list_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../models/common.dart';
import '../../../models/patient.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  Future<Patient?> fetchPatient() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? patientJson = prefs.getString("patient");

      if (patientJson == null) {
        print("⚠️ Không tìm thấy dữ liệu bệnh nhân trong Local Storage.");
        return null;
      }

      return Patient.fromJson(jsonDecode(patientJson));
    } catch (e) {
      print("🚨 Lỗi khi lấy bệnh nhân từ local storage: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 226, 215),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Center(
              child: FutureBuilder<Patient?>(
                future: fetchPatient(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return Column(
                      children: [
                        _buildAvatar(null), // Avatar mặc định
                        const SizedBox(height: 10),
                        const Text(
                          "Không thể tải thông tin bệnh nhân",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  } else {
                    final patient = snapshot.data;
                    return Column(
                      children: [
                        _buildAvatar(patient?.imageUrl),
                        const SizedBox(height: 10),
                        Text(
                          patient?.fullName ?? "Tên bệnh nhân",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "SĐT: ${patient?.phoneNumber ?? 'Chưa có'}",
                          style: const TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Ngày Sinh: ${patient?.birthday ?? 'Chưa có'}",
                          style: const TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        const SizedBox(height: 30),
                      ],
                    );
                  }
                },
              ),
            ),

            Container(
              height: 550,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  ListProfile(
                    image: "assets/icons/heart2.png",
                    title: "Thông tin cá nhân",
                    color: Colors.black87,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Divider(),
                  ),
                  ListProfile(
                    image: "assets/icons/appoint.png",
                    title: "Lịch hẹn",
                    color: Colors.black87,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Divider(),
                  ),
                  ListProfile(
                    image: "assets/icons/logout.png",
                    title: "Đăng xuất",
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget hiển thị ảnh bệnh nhân với fallback khi ảnh lỗi
  Widget _buildAvatar(String? imageUrl) {
    return Center(
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: Colors.white),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 10,
              color: Colors.black.withOpacity(0.1),
            )
          ],
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageUrl != null && imageUrl.isNotEmpty
                ? NetworkImage(getFullImageUrl(imageUrl))
                : const AssetImage("assets/icons/avatar.png") as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  /// Hàm tạo URL đầy đủ cho ảnh bệnh nhân
  String getFullImageUrl(String imageUrl) {
    if (imageUrl.startsWith("http")) {
      return imageUrl;
    }
    final String baseUrl = '${Common.domain}/upload/patient';
    return "$baseUrl/$imageUrl";
  }
}
