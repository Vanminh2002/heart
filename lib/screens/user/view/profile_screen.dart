import 'package:flutter/material.dart';
import 'package:heart/screens/user/widgets/list_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../models/user.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Hàm fetch dữ liệu người dùng
  Future<User?> fetchUserInfo() async {
    try {
      final response = await http.get(Uri.parse('URL_API'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Sử dụng User.fromJson để chuyển đổi từ Map thành đối tượng User
        return User.fromJson(data['data']);
      } else {
        // Xử lý lỗi nếu có
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 226, 215),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Stack(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1))
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage("assets/icons/avatar.png"),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.white),
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage("assets/icons/camra.png"))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            FutureBuilder<User?>(
              future: fetchUserInfo(),  // Sử dụng hàm fetchUserInfo
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return Center(child: Text('Error loading profile'));
                } else {
                  final user = snapshot.data;

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user?.username ?? "Loading...",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.0900,
                              width: MediaQuery.of(context).size.width * 0.2500,
                              child: Column(children: [
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.0400,
                                  width: MediaQuery.of(context).size.width * 0.1500,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/icons/callories.png"),
                                        filterQuality: FilterQuality.high),
                                  ),
                                ),
                                Text(
                                  "Calories",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 245, 243, 243)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                // Text(
                                //   "${user?.calories ?? 'Loading...'}",
                                //   style: TextStyle(
                                //       fontSize: 13,
                                //       fontWeight: FontWeight.w600,
                                //       color: Color.fromARGB(255, 255, 255, 255)),
                                // ),
                              ]),
                            ),
                            Container(
                              height: 50,
                              width: 1,
                              color: Colors.white,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.0900,
                              width: MediaQuery.of(context).size.width * 0.2500,
                              child: Column(children: [
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.0400,
                                  width: MediaQuery.of(context).size.width * 0.1500,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/icons/weight.png"),
                                        filterQuality: FilterQuality.high),
                                  ),
                                ),
                                Text(
                                  "Weight",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 245, 243, 243)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                // Text(
                                //   "${user?.weight ?? 'Loading...'}",
                                //   style: TextStyle(
                                //       fontSize: 13,
                                //       fontWeight: FontWeight.w600,
                                //       color: Color.fromARGB(255, 255, 255, 255)),
                                // ),
                              ]),
                            ),
                            Container(
                              height: 50,
                              width: 1,
                              color: Colors.white,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.0900,
                              width: MediaQuery.of(context).size.width * 0.2500,
                              child: Column(children: [
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.0400,
                                  width: MediaQuery.of(context).size.width * 0.1500,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/icons/heart.png"),
                                        filterQuality: FilterQuality.high),
                                  ),
                                ),
                                Text(
                                  "Heart rate",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 245, 243, 243)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                // Text(
                                //   "${user?.heartRate ?? 'Loading...'}",
                                //   style: TextStyle(
                                //       fontSize: 13,
                                //       fontWeight: FontWeight.w600,
                                //       color: Color.fromARGB(255, 255, 255, 255)),
                                // ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 550,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(children: [
                SizedBox(
                  height: 50,
                ),
                ListProfile(
                  image: "assets/icons/heart2.png",
                  title: "My Saved",
                  color: Colors.black87,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                ListProfile(
                  image: "assets/icons/appoint.png",
                  title: "Appointmnet",
                  color: Colors.black87,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                ListProfile(
                  image: "assets/icons/Chat.png",
                  title: "FAQs",
                  color: Colors.black87,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                ListProfile(
                  image: "assets/icons/pay.png",
                  title: "Payment Method",
                  color: Colors.black87,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Divider(),
                ),
                ListProfile(
                  image: "assets/icons/logout.png",
                  title: "Log out",
                  color: Colors.red,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
