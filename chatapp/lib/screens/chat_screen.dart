import 'package:flutter/material.dart';
import '../widgets/boxchat.dart';
import '../widgets/appbar_chatscreen.dart';

var fakedata = [
  {"sender": "hieu", "data": "Solo Aatrox khong?"},
  {"sender": "back", "data": "thoi t so lam"},
  {"sender": "hieu", "data": "tuong the nao"},
  {"sender": "hieu", "data": "lan trc solo thua la do t nhuong m aatrox thoi"},
  {"sender": "back", "data": "ghe vay sao"},
  {"sender": "hieu", "data": "la ro, k ghe sao lai solo thang dc"},
  {"sender": "back", "data": "m la nhat roi"},
  {"sender": "back", "data": "khong ai nhu m het"},
  {"sender": "back", "data": "khong ai nhu m het"},
  {"sender": "back", "data": "khong ai nhu m het"},
  {"sender": "back", "data": "khong ai nhu m het"},
  {"sender": "back", "data": "khong ai nhu m het"},
  {"sender": "back", "data": "khong ai nhu m het"},
];

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController listScrollController = ScrollController();
  TextEditingController textInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String text = "";
    void handleSend(e) {
      if (e != "") {
        setState(() {
          fakedata.add({"sender": "hieu", "data": e.toString()});
          textInputController.clear();
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent + 70,
              duration: const Duration(microseconds: 500),
              curve: Curves.easeOut);
          text = "";
        });
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const MessBar(),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[100],
            child: Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.only(bottom: 50, top: 10),
                  shrinkWrap: true,
                  controller: listScrollController,
                  itemCount: fakedata.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BoxChat(
                        isUser: fakedata[index]['sender'] == "hieu",
                        data: fakedata[index]['data'].toString());
                  },
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.grey[100],
                      child: Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width - 40,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextFormField(
                                  controller: textInputController,
                                  decoration: const InputDecoration(
                                      hintText: "Type a message...",
                                      contentPadding: EdgeInsets.all(10)),
                                  onChanged: (e) => {text = e.toString()},
                                ),
                              )),
                          CircleAvatar(
                            child: IconButton(
                                icon: const Icon(Icons.arrow_right_sharp),
                                onPressed: () => {
                                      handleSend(text),
                                    }),
                          ),
                        ],
                      ),
                    ))
              ],
            )));
  }
}
