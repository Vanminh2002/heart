import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../models/patient.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

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
      backgroundColor: const Color.fromARGB(255, 3, 226, 215),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Center(
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.white),
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage("assets/icons/avatar.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            FutureBuilder<Patient?>(
              future: fetchPatient(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return const Center(
                    child: Text(
                      'Không thể tải thông tin bệnh nhân',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  final patient = snapshot.data!;
                  return Column(
                    children: [
                      Text(
                        patient.fullName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text("Tên đăng nhập: ${patient.username}",
                          style: const TextStyle(fontSize: 14, color: Colors.white)),
                      const SizedBox(height: 5),
                      Text("SĐT: ${patient.phoneNumber}",
                          style: const TextStyle(fontSize: 14, color: Colors.white)),
                      const SizedBox(height: 5),
                      Text("Ngày Sinh: ${patient.birthday}",
                          style: const TextStyle(fontSize: 14, color: Colors.white)),
                      const SizedBox(height: 5),
                      Text("Giới tính: ${patient.gender == 1 ? 'Nam' : 'Nữ'}",
                          style: const TextStyle(fontSize: 14, color: Colors.white)),
                      const SizedBox(height: 5),
                      Text("Email: ${patient.email ?? 'Chưa có'}",
                          style: const TextStyle(fontSize: 14, color: Colors.white)),
                      const SizedBox(height: 5),
                      Text("Địa chỉ: ${patient.address ?? 'Chưa có'}",
                          style: const TextStyle(fontSize: 14, color: Colors.white)),
                      const SizedBox(height: 30),
                    ],
                  );
                }
              },
            ),

            Container(
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
                  ListTile(
                    leading: Image.asset("assets/icons/heart2.png", width: 30),
                    title: const Text("Thông tin cá nhân"),
                  ),
                  const Divider(indent: 25, endIndent: 25),
                  ListTile(
                    leading: Image.asset("assets/icons/appoint.png", width: 30),
                    title: const Text("Lịch hẹn"),
                  ),
                  const Divider(indent: 25, endIndent: 25),
                  ListTile(
                    leading: Image.asset("assets/icons/logout.png", width: 30),
                    title: const Text("Đăng xuất", style: TextStyle(color: Colors.red)),
                    onTap: () {
                      // Xử lý đăng xuất
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
