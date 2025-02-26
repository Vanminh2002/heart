import 'package:flutter/material.dart';
import 'package:heart/screens/user/view/shedule_tab_1.dart';
import 'package:heart/screens/user/view/shedule_tab_2.dart';
import 'package:heart/services/patient_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:heart/services/appointment_service.dart';
import 'package:heart/models/appointment.dart';

import '../../../models/patient.dart';

class Shedule_Screen extends StatefulWidget {
  const Shedule_Screen({super.key});

  @override
  State<Shedule_Screen> createState() => _Shedule_ScreenState();
}

class _Shedule_ScreenState extends State<Shedule_Screen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<Appointment> appointments = [];
  List<Appointment> upcomingAppointments = [];
  List<Appointment> completedAppointments = [];
  List<Appointment> cancelledAppointments = [];
  int? patientId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initializePatientData();
  }

  Future<void> fetchAndSavePatient() async {
    try {
      Patient patient = await PatientService().getPatientInfo();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt("patientId", patient.id);

      print("✅ Đã lấy và lưu patientId: ${patient.id}");
    } catch (e) {
      print("❌ Lỗi khi lấy thông tin bệnh nhân: $e");
    }
  }

  Future<void> _initializePatientData() async {
    final prefs = await SharedPreferences.getInstance();
    int? storedPatientId = prefs.getInt("patientId");
    String? token = prefs.getString("token");

    print("🔍 Checking stored data in Schedule_Screen...");
    print("✅ Stored patientId: $storedPatientId");
    print("✅ Stored token: $token");

    if (storedPatientId != null && token != null) {
      setState(() => patientId = storedPatientId);
      _fetchAppointments(storedPatientId, token);
    } else {
      print("❗ patientId or token is null, trying to fetch from API...");

      await fetchAndSavePatient();
      storedPatientId = prefs.getInt("patientId");
      token = prefs.getString("token");

      if (storedPatientId != null && token != null) {
        setState(() => patientId = storedPatientId);
        _fetchAppointments(storedPatientId, token);
      } else {
        print("❗ Still null after retry");
      }
    }
  }

  Future<void> _fetchAppointments(int patientId, String token) async {
    print("📡 Fetching appointments for patientId: $patientId");

    try {
      List<Appointment> fetchedAppointments =
      await AppointmentService.fetchAppointments(patientId, token);

      print("📥 Fetched appointments: ${fetchedAppointments.length}");

      List<Appointment> upcoming = [];
      List<Appointment> completed = [];
      List<Appointment> cancelled = [];

      for (var appointment in fetchedAppointments) {
        if (appointment.status == "PENDING") {
          upcoming.add(appointment);
        } else if (appointment.status == "COMPLETED") {
          completed.add(appointment);
        } else if (appointment.status == "CANCELLED") {
          cancelled.add(appointment);
        }
      }

      setState(() {
        appointments = fetchedAppointments;
        upcomingAppointments = upcoming;
        completedAppointments = completed;
        cancelledAppointments = cancelled;
      });
    } catch (e) {
      print("❌ Error fetching appointments: $e");
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Shedule-Appointment",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/bell.png"),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 235, 235, 235)),
                          color: const Color.fromARGB(255, 241, 241, 241),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: TabBar(
                                indicator: BoxDecoration(
                                  color: const Color.fromARGB(255, 5, 185, 155),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                indicatorColor:
                                const Color.fromARGB(255, 241, 241, 241),
                                unselectedLabelColor:
                                const Color.fromARGB(255, 32, 32, 32),
                                labelColor:
                                const Color.fromARGB(255, 255, 255, 255),
                                controller: _tabController,
                                tabs: const [
                                  Tab(text: "Upcoming"),
                                  Tab(text: "Completed"),
                                  Tab(text: "Cancel"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          SheduleTab1(appointments: upcomingAppointments),
                          SheduleTab2(appointments: completedAppointments),
                          SheduleTab2(appointments: cancelledAppointments),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
