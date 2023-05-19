import 'package:chatapp/models/auth.dart';
import 'package:chatapp/screens/conversations_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/boxchat.dart';
import '../widgets/appbar_chatscreen.dart';

var fakedata = [
  {"senderId": "hieu", "data": "Solo Aatrox khong?"},
  {"senderId": "7PF91FsTfWW0GPCC93Tqh0b1pkj1", "data": "thoi t so lam"},
  {"senderId": "hieu", "data": "tuong the nao"},
  {
    "senderId": "hieu",
    "data": "lan trc solo thua la do t nhuong m aatrox thoi"
  },
  {"senderId": "7PF91FsTfWW0GPCC93Tqh0b1pkj1", "data": "ghe vay sao"},
  {"senderId": "hieu", "data": "la ro, k ghe sao lai solo thang dc"},
  {"senderId": "7PF91FsTfWW0GPCC93Tqh0b1pkj1", "data": "m la nhat roi"},
  {"senderId": "7PF91FsTfWW0GPCC93Tqh0b1pkj1", "data": "khong ai nhu m het"},
  {"senderId": "7PF91FsTfWW0GPCC93Tqh0b1pkj1", "data": "khong ai nhu m het"},
  {"senderId": "7PF91FsTfWW0GPCC93Tqh0b1pkj1", "data": "khong ai nhu m het"},
  {"senderId": "7PF91FsTfWW0GPCC93Tqh0b1pkj1", "data": "khong ai nhu m het"},
  {"senderId": "7PF91FsTfWW0GPCC93Tqh0b1pkj1", "data": "khong ai nhu m het"},
  {"senderId": "7PF91FsTfWW0GPCC93Tqh0b1pkj1", "data": "khong ai nhu m het"},
];

class ChatScreen extends StatefulWidget {
  final String conversationsId;
  const ChatScreen({super.key, required this.conversationsId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController listScrollController = ScrollController();
  final TextEditingController textInputController = TextEditingController();
  int _limit = 20;
  int _limitIncrement = 20;
  List listMessage = [];
  var currentUserId = Auth().getCurrentUSer()?.uid;
  var messageStream;

  @override
  void initState() {
    super.initState();
    listScrollController.addListener(_scroolListener);
    String conversationId = widget.conversationsId;
    messageStream = FirebaseFirestore.instance
        .collection("conversations/$conversationId/messages")
        .snapshots();
  }

  void _scroolListener() {
    if (!listScrollController.hasClients) return;
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange &&
        _limit < listMessage.length) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void handleSend() {
    String message = textInputController.text;

    if (message != "") {
      final data = {
        "senderId": currentUserId,
        "receiverId": "123",
        "messges": message,
        "timestamp": DateTime.now().microsecondsSinceEpoch
      };
      setState(() {
        textInputController.clear();
        listScrollController.animateTo(
            listScrollController.position.maxScrollExtent + 70,
            duration: const Duration(microseconds: 500),
            curve: Curves.easeOut);
        textInputController.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                StreamBuilder<QuerySnapshot>(
                    stream: messageStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.blue),
                        );
                      }

                      return ListView(
                        padding: const EdgeInsets.only(bottom: 60),
                        controller: listScrollController,
                        reverse: true,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;

                              return BoxChat(
                                  isCurrentUserId:
                                      currentUserId == data["senderId"],
                                  message: data["message"]);
                            })
                            .toList()
                            .cast(),
                      );
                    }),
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
                                ),
                              )),
                          CircleAvatar(
                            child: IconButton(
                                icon: const Icon(Icons.arrow_right_sharp),
                                onPressed: () => {
                                      handleSend(),
                                    }),
                          ),
                        ],
                      ),
                    ))
              ],
            )));
  }
}
