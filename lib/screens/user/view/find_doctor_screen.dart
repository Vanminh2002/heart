import 'package:flutter/material.dart';
import 'package:heart/models/doctor.dart';
import 'package:heart/screens/user/view/doctor_detail_screen.dart';

import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import '../../../models/patient.dart';
import '../../../services/doctor_services.dart';

class FindDoctor extends StatefulWidget {
  final Patient patient; // Nhận patient từ constructor

  const FindDoctor({super.key, required this.patient});

  @override
  State<FindDoctor> createState() => _FindDoctorState();
}

class _FindDoctorState extends State<FindDoctor> {
  late final Patient patient;
  final TextEditingController _searchController = TextEditingController();
  List<Doctor> _doctors = [];
  final DoctorServices _doctorService = DoctorServices();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    patient = widget.patient; // Gán patient từ widget
  }

  Future<void> _handleSearch(String name) async {
    if (name.isEmpty) {
      setState(() => _doctors = []);
      return;
    }

    setState(() => _isLoading = true);
    final results = await _doctorService.searchDoctors(name);

    setState(() {
      _doctors = results;
      _isLoading = false;
    });
  }

  Widget _buildLoadingShimmer() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorList() {
    if (_doctors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              "No doctors found",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _doctors.length,
      itemBuilder: (context, index) {
        final doctor = _doctors[index];
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/icons/male-doctor.png"),
            ),
            title: Text(doctor.fullName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            subtitle: Text(doctor.specialty, style: TextStyle(color: Colors.grey[600])),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Colors.blue),
              onPressed: () => _navigateToDoctorDetail(doctor),
            ),
            onTap: () => _navigateToDoctorDetail(doctor),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Text("Find Doctors", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            TextField(
              controller: _searchController,
              onChanged: (value) => _handleSearch(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: "Search doctor...",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _isLoading ? _buildLoadingShimmer() : _buildDoctorList(),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDoctorDetail(Doctor doctor) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: DoctorDetailScreen(id: doctor.id, patient: patient),
      ),
    );
  }
}
