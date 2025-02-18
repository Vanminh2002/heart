import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:heart/screens/user/view/article_page.dart';
import 'package:heart/screens/user/view/doctor_search.dart';
import 'package:heart/screens/user/view/find_doctor_screen.dart';
import 'package:heart/screens/user/view/pharmacy_screen.dart';
import 'package:heart/screens/user/widgets/article.dart';
import 'package:heart/screens/user/widgets/banner.dart';
import 'package:heart/screens/user/widgets/list_doctor.dart';
import 'package:heart/screens/user/widgets/list_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/doctor.dart';
import '../../../models/patient.dart';
import '../../../services/doctor_services.dart';
import '../widgets/doctor_list.dart';
import 'ambulance_screen.dart';
import 'hospital_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DoctorServices _doctorService = DoctorServices();
  late Future<List<Doctor>> _doctorList;
  late Future<Patient?> _patientFuture;

  @override
  void initState() {
    super.initState();
    _doctorList = DoctorServices().fetchDoctors(); // Tải danh sách bác sĩ khi màn hình được khởi tạo
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.06,
              child: Image.asset(
                "assets/icons/bell.png",
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ],
        title: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Find your desire\nhealth solution",
              style: TextStyle(
                  color: Color.fromARGB(255, 51, 47, 47),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
          ],
        ),
        toolbarHeight: 130,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(),
              child: TextField(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: FindDoctor()));
                },
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.none,
                autofocus: false,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  focusColor: Colors.black26,
                  fillColor: Color.fromARGB(255, 247, 247, 247),
                  filled: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Container(
                      height: 10,
                      width: 10,
                      child: Image.asset(
                        "assets/icons/search.png",
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  prefixIconColor: const Color.fromARGB(255, 3, 190, 150),
                  label: Text("Search doctor, drugs, articles..."),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //Body Start fro here
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListIcons(
                Icon: "assets/icons/Doctor.png",
                text: "Doctor",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DoctorSearch()),
                  );
                },
              ),
              ListIcons(
                Icon: "assets/icons/Pharmacy.png",
                text: "Pharmacy",
                onTap: () {
                  // Chuyển sang trang Pharmacy
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PharmacyScreen()),
                  );
                },
              ),
              ListIcons(
                Icon: "assets/icons/Hospital.png",
                text: "Hospital",
                onTap: () {
                  // Chuyển sang trang Hospital
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HospitalScreen()),
                  );
                },
              ),
              ListIcons(
                Icon: "assets/icons/Ambulance.png",
                text: "Ambulance",
                onTap: () {
                  // Chuyển sang trang Ambulance
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AmbulanceScreen()),
                  );
                },
              ),
            ],
          ),

          //List icons (Can Edit in Widgets )
          SizedBox(
            height: 10,
          ),
          const BannerWidget(),
          // Banner Design
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Doctor",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 46, 46, 46),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: DoctorSearch()));
                  },
                  child: Text(
                    "See all",
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 3, 190, 150),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // list doctor using FutureBuilder
          FutureBuilder<Patient?>(
            future: _patientFuture,  // Lấy dữ liệu Patient
            builder: (context, patientSnapshot) {
              if (patientSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (patientSnapshot.hasError) {
                return Center(child: Text("Error: ${patientSnapshot.error}"));
              } else if (patientSnapshot.hasData) {
                var patient = patientSnapshot.data;
                return FutureBuilder<List<Doctor>>(
                  future: _doctorList,
                  builder: (context, doctorSnapshot) {
                    if (doctorSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (doctorSnapshot.hasError) {
                      return Center(child: Text("Error: ${doctorSnapshot.error}"));
                    } else if (doctorSnapshot.hasData) {
                      var doctorList = doctorSnapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          height: 180,
                          width: 400,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: doctorList.length,
                            itemBuilder: (context, index) {
                              return DoctorList(
                                doctor: doctorList[index],
                                patient: patient!,  // Truyền patient vào DoctorList
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return Center(child: Text("No doctors found"));
                    }
                  },
                );
              } else {
                return Center(child: Text("No patient data"));
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Health article",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 46, 46, 46),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ArticlePage()));
                  },
                  child: Text(
                    "See all",
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 3, 190, 150),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //Article banner here import from widget>article
          Article(
              image: "assets/images/article1.png",
              dateText: "Jun 10, 2021 ",
              duration: "5min read",
              mainText:
              "The 25 Healthiest Fruits You Can Eat,\nAccording to a Nutritionist"),
        ]),
      ),
    );
  }
}
