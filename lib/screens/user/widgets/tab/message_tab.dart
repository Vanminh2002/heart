import 'package:flutter/material.dart';
import 'package:heart/screens/user/view/chat_screen.dart';
import 'package:heart/screens/user/widgets/message_all_widget.dart';
import 'package:page_transition/page_transition.dart';

class MessageTab extends StatefulWidget {
  const MessageTab({super.key});

  @override
  State<MessageTab> createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Shedule",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/icons/bell.png"),
                  )),
            ),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: ChatScreen()));
          },
          child: MessageAllWidget(
            image: "assets/icons/male-doctor.png",
            Maintext: "Dr. Marcus Horizon",
            subtext: "I don,t have any fever, but headchace...",
            time: "10.24",
            message_count: "2",
          ),
        ),
        MessageAllWidget(
          image: "assets/icons/docto3.png",
          Maintext: "Dr. Alysa Hana",
          subtext: "Hello, How can i help you?",
          time: "10.24",
          message_count: "1",
        ),
        MessageAllWidget(
          image: "assets/icons/doctor2.png",
          Maintext: "Dr. Maria Elena",
          subtext: "Do you have fever?",
          time: "10.24",
          message_count: "3",
        ),
      ]),
    );
  }
}
