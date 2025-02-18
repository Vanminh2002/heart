import 'package:flutter/material.dart';
import 'package:heart/screens/user/widgets/shedule_card.dart';
class SheduleTab1 extends StatelessWidget {
  const SheduleTab1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        const SizedBox(
          height: 30,
        ),
        SheduleCart(
          confirmation: "Confirmed",
          mainText: "Dr. Marcus Horizon",
          subText: "Chardiologist",
          date: "26/06/2022",
          time: "10:30 AM",
          image: "assets/icons/male-doctor.png",
        ),
        const SizedBox(
          height: 20,
        ),
        SheduleCart(
          confirmation: "Confirmed",
          mainText: "Dr. Marcus Horizon",
          subText: "Chardiologist",
          date: "26/06/2022",
          time: "2:00 PM",
          image: "assets/icons/female-doctor2.png",
        )
      ]),
    );
  }
}
