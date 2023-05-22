import 'package:chatapp/models/auth.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/userinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/boxchat.dart';
import '../widgets/appbar_chatscreen.dart';

class ChatScreen extends StatefulWidget {
  final user;
  final String conversationsId;
  const ChatScreen(
      {super.key, required this.conversationsId, required this.user});

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
  late Stream<QuerySnapshot> messageStream;

  @override
  void initState() {
    super.initState();
    listScrollController.addListener(_scroolListener);
    messageStream = MessageModel().getMessageStream(widget.conversationsId);
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
            title: InkWell(
              child: MessBar(
                peerInfo: widget.user,
              ),
            ),
          ),
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[100],
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: messageStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.blue),
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
                              controller: listScrollController,
                              reverse: true,
                              children: snapshot.data!.docs.reversed
                                  .map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;

                                    return BoxChat(
                                        isCurrentUserId:
                                            currentUserId == data["senderId"],
                                        message: data["text"]);
                                  })
                                  .toList()
                                  .cast(),
                            );
                          })),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 50,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 7),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              controller: textInputController,
                              decoration: const InputDecoration(
                                  hintText: "Viết gì đó...",
                                  contentPadding: EdgeInsets.all(10),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        width: 0.5, color: Colors.grey),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    borderSide: BorderSide(
                                        width: 0.5, color: Colors.grey),
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: CircleAvatar(
                            child: Transform.rotate(
                              angle: -45,
                              child: IconButton(
                                  icon: const Icon(Icons.send),
                                  iconSize: 25,
                                  onPressed: () => {
                                        handleSend(textInputController.text),
                                      }),
                            ),
                          ),
                        ),
                      ])
                ],
              ))),
    );
  }
}
