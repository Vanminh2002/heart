import 'package:flutter/material.dart';
import 'package:heart/screens/user/view/doctor_detail_screen.dart';
import 'package:heart/screens/user/view/home_screen.dart';

import 'package:page_transition/page_transition.dart';

import '../../../models/common.dart';
import '../../../models/doctor.dart';
import '../../../models/patient.dart';
import '../../../services/doctor_services.dart';

class DoctorSearch extends StatefulWidget {
  final Patient patient;
  const DoctorSearch({super.key, required this.patient});

  @override
  _DoctorSearchState createState() => _DoctorSearchState();
}

class _DoctorSearchState extends State<DoctorSearch> {

  final DoctorServices doctorServices = DoctorServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: const HomeScreen(),
              ),
            );
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
        title: const Text(
          "List Doctors",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/more.png"),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: FutureBuilder<List<Doctor>>(
          future: doctorServices.fetchDoctors(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No doctors found.'));
            }

            final doctors = snapshot.data!;
            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: DoctorDetailScreen(id: doctor.id, patient: widget.patient,),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: doctor.imageUrl.isNotEmpty
                          ? NetworkImage(getFullImageUrl(doctor.imageUrl))
                          : const AssetImage("assets/icons/unknow.png") as ImageProvider,
                    ),
                    title: Text(doctor.fullName),
                    subtitle: Text('${doctor.specialty} • ${doctor.phoneNumber}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String getFullImageUrl(String imageUrl) {
    final String baseUrl = '${Common.domain}/upload/doctor';
    return "$baseUrl/$imageUrl";
  }
}