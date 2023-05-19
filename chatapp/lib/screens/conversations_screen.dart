import 'package:chatapp/models/auth.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/Authentication/login_screen.dart';
import 'package:chatapp/widgets/drawer.dart';
import 'package:flutter/material.dart';
import '../widgets/logo.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    String searchText = "";

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Đoạn chat",
          ),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                size: 30,
              ));
        }),
        actions: <Widget>[
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                // Scaffold.of(context).openEndDrawer();
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return addNewConversation(context: context);
                    });
              },
              icon: const Icon(Icons.add_comment_outlined),
              iconSize: 30,
            );
          })
        ], //Row(
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                width: MediaQuery.of(context).size.width - 50,
                height: 40,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[300]),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 28,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 120,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          // color: Colors.white,
                          fontSize: 20,
                        ),
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
                child: ListView.builder(
              itemCount: fakedata.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatScreen(
                                  conversationsId: "j7xp8BZ9bDM8myoSIpGl",
                                )));
                  },
                  child: Row(
                    children: [
                      Container(
                          height: 70,
                          width: 70,
                          margin: const EdgeInsets.only(
                              left: 5, top: 5, bottom: 5, right: 15),
                          child: const UserLogo(
                              size: 35,
                              imgUrl:
                                  "https://t4.ftcdn.net/jpg/00/97/58/97/360_F_97589769_t45CqXyzjz0KXwoBZT9PRaWGHRk5hQqQ.jpg")),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 90,
                        height: 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text("Rac ruoi",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            Text('hihi',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400))
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            )),
          ],
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}

Widget addNewConversation({required BuildContext context}) {
  return SizedBox(
    width: double.infinity,
    height: MediaQuery.of(context).size.height - 100,
    child: const Center(child: Text("hehe")),
  );
}
