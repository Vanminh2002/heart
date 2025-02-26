import 'package:flutter/material.dart';
import 'package:heart/screens/user/widgets/shedule_card.dart';
import 'package:heart/models/appointment.dart';

class SheduleTab1 extends StatelessWidget {
  final List<Appointment> appointments;

  const SheduleTab1({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: appointments.isEmpty
          ? Center(child: Text("No upcoming appointments"))
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                print(
                    "📝 Showing appointment: ${appointment.doctorName}, ${appointment.date}");

                return SheduleCart(
                  confirmation: appointment.status ?? "Pending",
                  mainText: appointment.doctorName ?? "Unknown Doctor",
                  subText: "No Specialty",
                  date: appointment.date,
                  time: appointment.time,
                  image: "assets/icons/male-doctor.png",
                  appointments: appointment,
                );
              },
            ),
    );
  }
}
