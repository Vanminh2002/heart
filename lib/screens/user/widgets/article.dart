import 'package:flutter/material.dart';
class Article extends StatelessWidget {
  final String mainText;
  final String dateText;
  final String duration;
  final String image;
  const Article({super.key, required this.mainText, required this.dateText, required this.duration, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.8500,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(255, 231, 231, 231)),
        ),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const SizedBox(
            width: 5,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.1200,
            child: Image.asset(image),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.5,
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                mainText,
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      dateText,
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      duration,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 136, 102),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
          const SizedBox(
            width: 25,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.09,
            child: Image.asset(
              "assets/icons/Bookmark.png",
              filterQuality: FilterQuality.high,
            ),
          ),
        ]),
      ),
    );
  }
}
