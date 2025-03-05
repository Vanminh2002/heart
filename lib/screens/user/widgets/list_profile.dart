import 'package:flutter/material.dart';

class ListProfile extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final VoidCallback? onTap;

  const ListProfile({super.key, required this.title, required this.image, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.1500,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 247, 250, 247),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(image),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.5800,
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: color),
                    ),
                  ),
                ]),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.1100,
                  decoration: const BoxDecoration(),
                  child: Image.asset("assets/icons/forward.png")),
            ]),
          ),
        ],
      ),
    );
  }
}
