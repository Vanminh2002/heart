import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heart/screens/user/view/appointment_screen.dart';
import 'package:heart/screens/user/widgets/date_select.dart';
import 'package:heart/screens/user/widgets/list_doctor.dart';
import 'package:heart/screens/user/widgets/time_select.dart';
import 'package:page_transition/page_transition.dart';

import '../../../models/common.dart';
import '../../../models/doctor.dart';
import '../../../models/patient.dart';
import '../../../services/doctor_services.dart';

class DoctorDetailScreen extends StatefulWidget {
  final int id;
  final Patient? patient;
  final Doctor? doctor;

  const DoctorDetailScreen({super.key, required this.id, this.patient, this.doctor});

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  DateTime? selectedDate = DateTime.now();
  String? selectedTime = "09:00 AM";

  bool showExtendedText = false;
  late Future<Doctor> doctor;

  @override
  void initState() {
    super.initState();
    doctor = DoctorServices().fetchDoctorById(widget.id); // Gọi API khi màn hình được tạo
  }

  void toggleTextVisibility() {
    setState(() {
      showExtendedText = !showExtendedText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/back1.png"),
              ),
            ),
          ),
        ),
        title: Text(
          "Doctor Detail",
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<Doctor>(
        future: doctor,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No doctor found'));
          } else {
            Doctor doctor = snapshot.data!;
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ListView(
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: widget.doctor != null && widget.doctor!.imageUrl.isNotEmpty
                                ? NetworkImage(getFullImageUrl(widget.doctor!.imageUrl)) as ImageProvider
                                : const AssetImage("assets/icons/unknow.png"),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        doctor.fullName, // Tên bác sĩ
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Text(
                        doctor.specialty, // Chuyên môn của bác sĩ
                        style: TextStyle(fontSize: 16, color: Colors.black45),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: toggleTextVisibility,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "About",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  showExtendedText
                                      ? doctor.fullName  // Mô tả đầy đủ của bác sĩ
                                      : doctor.phoneNumber.length > 100
                                      ? doctor.specialty.substring(0, 100) + "..." // Cắt ngắn mô tả
                                      : doctor.email,
                                  style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 37, 37, 37)),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  showExtendedText ? "Read less" : "Read more",
                                  style: TextStyle(color: Color.fromARGB(255, 1, 128, 111), fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Availability",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 100,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(5, (index) {
                                DateTime date = DateTime.now().add(Duration(days: index));
                                String formattedDate = "${date.day}/${date.month}"; // Hiển thị ngày/tháng

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedDate = date;
                                    });
                                  },
                                  child: DateSelect(
                                    date: formattedDate,
                                    maintext: "Day ${date.day}",
                                    isSelected: selectedDate != null && selectedDate!.day == date.day,
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Divider(color: Colors.black12),
                          const SizedBox(height: 20),
                          Text(
                            "Select Time",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: ["09:00 AM", "01:00 PM", "04:00 PM"].map((time) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedTime = time;
                                    });
                                  },
                                  child: TimeSelect(
                                    mainText: time,
                                    isSelected: time == selectedTime,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Divider(color: Colors.black12),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 247, 247, 247),
                            borderRadius: BorderRadius.circular(18),
                            image: DecorationImage(
                              image: AssetImage("assets/icons/Chat.png"),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Kiểm tra xem patient và doctor có null không
                            if (widget.patient == null || widget.doctor == null) {
                              showSnackbarMessage(context, "Please select a patient and doctor!");
                              return;
                            }
                            if (selectedDate == null || selectedTime == null) {
                              showSnackbarMessage(context, "Please select a date and time!");
                              return;
                            }

                            // Truyền dữ liệu cho AppointmentScreen
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: AppointmentScreen(
                                  doctorId: widget.id,
                                  selectedDate: selectedDate != null
                                      ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                      : "",  // Định dạng ngày thành chuỗi
                                  selectedTime: selectedTime!,
                                  patient: widget.patient,
                                  doctor: widget.doctor,
                                  appointmentId: Random().nextInt(10000),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 2, 179, 149),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Book Appointment",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}


String getFullImageUrl(String imageUrl) {
  final String baseUrl = '${Common.domain}/upload/doctor';
  return "$baseUrl/$imageUrl";
}



void showSnackbarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
