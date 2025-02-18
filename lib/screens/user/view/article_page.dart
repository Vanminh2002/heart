import 'package:flutter/material.dart';
import 'package:heart/screens/user/view/home_screen.dart';
import 'package:heart/screens/user/widgets/article.dart';

import 'package:page_transition/page_transition.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Articles",
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 100, 98, 98),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        elevation: 0,
        leading: IconButton(
          icon: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.06,
              child: Image.asset("assets/icons/back2.png")),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: const HomeScreen()));
          },
        ),
        actions: [
          Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.06,
              child: Image.asset("assets/icons/more.png")),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: const BoxDecoration(),
              child: TextField(
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.none,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  focusColor: Colors.black26,
                  fillColor: const Color.fromARGB(255, 247, 247, 247),
                  filled: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.01,
                      width: MediaQuery.of(context).size.width * 0.01,
                      child: Image.asset(
                        "assets/icons/search.png",
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  prefixIconColor: const Color.fromARGB(255, 3, 190, 150),
                  label: const Text("Search doctor, drugs, articles..."),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Popular Articles",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 3,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    Container(
                      height: 20,
                      width: 120,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 2, 173, 131),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: const Center(
                          child: Text(
                        "Covid-19",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 1),
                      )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 20,
                      width: 120,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 2, 173, 131),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: const Center(
                          child: Text(
                        "Diet",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 1),
                      )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 20,
                      width: 120,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 2, 173, 131),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: const Center(
                          child: Text(
                        "Fitness",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 1),
                      )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 20,
                      width: 120,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 2, 173, 131),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: const Center(
                          child: Text(
                        "Medicines",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 1),
                      )),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          //TRENDING ARTICLE START FROM HERE
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Trending Article",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2500,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2500,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          border: Border.all(color: Colors.black12)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1000,
                                width:
                                    MediaQuery.of(context).size.width * 0.3500,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                          "assets/images/article1.png",
                                        ),
                                        filterQuality: FilterQuality.high,
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.01800,
                                width:
                                    MediaQuery.of(context).size.width * 0.1200,
                                color: const Color.fromARGB(255, 233, 231, 231),
                                child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Covid",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 6, 110, 102)),
                                      ),
                                    ]),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Comparing the AstraZeneca and Sinovac COVID-19 Vaccines",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Jun 10, 2021 ",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "5min Read",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color.fromARGB(255, 0, 136, 102),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2500,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          border: Border.all(color: Colors.black12)),
                      child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1000,
                                width:
                                    MediaQuery.of(context).size.width * 0.3500,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                          "assets/images/capsules.png",
                                        ),
                                        filterQuality: FilterQuality.high,
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.01800,
                                width:
                                    MediaQuery.of(context).size.width * 0.1200,
                                color: const Color.fromARGB(255, 233, 231, 231),
                                child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Covid",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 6, 110, 102)),
                                      ),
                                    ]),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Comparing the AstraZeneca and Sinovac COVID-19 Vaccines",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Jun 10, 2021 ",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w300)
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "5min Read",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color.fromARGB(255, 0, 136, 102),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2500,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          border: Border.all(color: Colors.black12)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1000,
                                width:
                                    MediaQuery.of(context).size.width * 0.3500,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                          "assets/images/capsules2.png",
                                        ),
                                        filterQuality: FilterQuality.high,
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.01800,
                                width:
                                    MediaQuery.of(context).size.width * 0.1200,
                                color: const Color.fromARGB(255, 233, 231, 231),
                                child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Covid",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 6, 110, 102)),
                                      ),
                                    ]),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Comparing the AstraZeneca and Sinovac COVID-19 Vaccines",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Jun 10, 2021 ",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "5min Read",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color.fromARGB(255, 0, 136, 102),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          //Container End Here
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  "Related Article",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //Import this from widget
          const Article(
              image: "assets/images/article1.png",
              dateText: "2 min Read",
              duration: "2 min read",
              mainText: "Main text"),
        ]),
      ),
    );
  }
}
