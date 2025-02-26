import 'package:flutter/material.dart';

import '../../../models/appointment.dart';
import '../widgets/shedule_card.dart';

class SheduleTab2 extends StatelessWidget {
  final List<Appointment> appointments;

  const SheduleTab2({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    print("🖥️ SheduleTab2 - Appointments Count: ${appointments.length}");

    if (appointments.isEmpty) {
      return Center(child: Text("Nothing to show"));
    }

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
