import 'package:flutter/material.dart';
class SheduleTab2 extends StatelessWidget {
  const SheduleTab2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Text(
            "Nothing to show",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
        )
      ]),
    );
  }
}
