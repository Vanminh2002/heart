import 'package:flutter/material.dart';
class ListIcons extends StatelessWidget {
  final String Icon;
  final String text;
  final VoidCallback onTap; // Thêm callback khi nhấn vào icon

  const ListIcons({
    super.key,
    required this.Icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Gọi hàm onTap khi nhấn vào icon
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 1,
                    color: Color.fromARGB(135, 238, 236, 236),
                  )
                ],
                image: DecorationImage(
                  image: AssetImage(Icon),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              text,
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}