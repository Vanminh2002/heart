import 'package:flutter/material.dart';

class SocialLogin extends StatelessWidget {
  final String text;
  final String logo;

  const SocialLogin({super.key, required this.text, required this.logo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width * 02,
      decoration: BoxDecoration(
          color: Color.fromARGB(225, 225, 225, 225),
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.07,
              child: Image.asset(
                logo,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(225, 44, 44, 44),
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Container(
            height: 10,
            width: 10,
            color: Color.fromARGB(225, 225, 225, 225),
          )
        ],
      ),
    );
  }
}
