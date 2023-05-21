import 'package:chatapp/models/auth.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/userinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/boxchat.dart';
import '../widgets/appbar_chatscreen.dart';

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
  final int _limitIncrement = 20;
  List listMessage = [];
  var currentUserId = Auth().getCurrentUSer()?.uid;
  var peerInfo;

  @override
  void initState() {
    super.initState();
    listScrollController.addListener(_scroolListener);
    peerInfo = UsersInfo.test().getPeer(widget.conversationsId);
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

  void handleSend(String text) {
    MessageModel().sendMessage(widget.conversationsId, text);

    setState(() {
      textInputController.clear();
      listScrollController.animateTo(
          listScrollController.position.minScrollExtent,
          duration: const Duration(microseconds: 500),
          curve: Curves.easeOut);
      textInputController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: MessBar(
              peerInfo: peerInfo,
            ),
          ),
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[100],
              child: Stack(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: MessageModel()
                          .getMessageStream(widget.conversationsId),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.blue),
                          );
                        }

                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              "Hãy chat gì đó",
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        }

                        return ListView(
                          padding: const EdgeInsets.only(bottom: 60),
                          controller: listScrollController,
                          reverse: true,
                          children: snapshot.data!.docs.reversed
                              .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;

                                return BoxChat(
                                    isCurrentUserId:
                                        currentUserId == data["senderId"],
                                    message: data["text"]);
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
                                        handleSend(textInputController.text),
                                      }),
                            ),
                          ],
                        ),
                      ))
                ],
              ))),
    );
  }
}
