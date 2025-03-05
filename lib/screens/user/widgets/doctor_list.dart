import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:heart/models/patient.dart';
import 'package:heart/screens/user/view/doctor_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/common.dart';
import '../../../models/doctor.dart';

class DoctorList extends StatefulWidget {
  final Doctor doctor;
  final Patient patient;

  const DoctorList({
    Key? key,
    required this.doctor, required this.patient,
  }) : super(key: key);

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  late Future<Patient?> _patientFuture;



  @override
  void initState() {
    super.initState();

    _patientFuture = _loadPatientData(); // Đảm bảo có dữ liệu được gán
  }
  Future<Patient?> _loadPatientData() async {
    try {
      final patient = await getPatientFromStorage();
      return patient;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Kiểm tra trước khi điều hướng
        if (widget.doctor == null || widget.patient == null) {
          print("Doctor: ${widget.doctor}, Patient: ${widget.patient}"); // In ra log để kiểm tra dữ liệu
          showSnackbarMessage(context, "Doctor or Patient data is missing!");
          return;
        }

        // Điều hướng nếu dữ liệu hợp lệ
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDetailScreen(
              id: widget.doctor.id,
              patient: widget.patient,
              doctor: widget.doctor,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color.fromARGB(134, 228, 227, 227)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Center(
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: 80,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.doctor.imageUrl.isNotEmpty
                            ? NetworkImage(getFullImageUrl(widget.doctor.imageUrl)) as ImageProvider
                            : const AssetImage("assets/icons/unknow.png"),
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        widget.doctor.fullName,
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.doctor.specialty,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            "Phone: ${widget.doctor.phoneNumber}",
                            style: TextStyle(
                                fontSize: 11, color: Color.fromARGB(255, 4, 179, 120)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getFullImageUrl(String imageUrl) {
    final String baseUrl = '${Common.domain}/upload/doctor';
    return "$baseUrl/$imageUrl";
  }

  Future<Patient?> getPatientFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    String? patientJson = prefs.getString('patient');

    if (patientJson != null) {
      return Patient.fromJson(jsonDecode(patientJson));
    } else {
      print("❌ Chưa có thông tin bệnh nhân!");
      return null;
    }
  }
}
