import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class MessageAllWidget extends StatelessWidget {
  final String Maintext;
  final String subtext;
  final String image;
  final String time;
  final String message_count;

  const MessageAllWidget({super.key, required this.Maintext, required this.subtext, required this.image, required this.time, required this.message_count});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width * 0.9,
          color: Colors.white,
          child: Row(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.1500,
              decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(image),
                      filterQuality: FilterQuality.high)),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.6,
                color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      //Main text here "lib/icons/male-doctor.png"
                      Text(
                        Maintext,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      //Subtext here e.g  "I don,t have any fever, but headchace..."
                      Text(
                        subtext,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ]),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.1200,
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                //Time of chat text here e.g 10:24
                Text(time),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 2, 134, 117),
                      shape: BoxShape.circle,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Message Count Here
                          Text(
                            message_count,
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          )
                        ]),
                  ),
                )
              ]),
            )
          ]),
        ),
      ]),
    );
  }
}
