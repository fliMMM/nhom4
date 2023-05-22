import 'dart:convert';

import 'package:chatapp/models/auth.dart';
import 'package:chatapp/models/conversation.dart';
import 'package:chatapp/models/store.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/widgets/adduser.dart';
import 'package:chatapp/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/userinfo.dart';
import '../widgets/logo.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late Stream<QuerySnapshot> conversationStream;
  bool check_search = false;
  late UsersInfo user;
  List<UsersInfo> list = [];
  List<UsersInfo> searchList = [];

  var currentUserId = Auth().getCurrentUSer()?.toString();
  late Stream<QuerySnapshot> userStream;

  @override
  void initState() {
    Store.getSelfInfo();
    super.initState();
    conversationStream = Conversation().getConversationStream();
    userStream = UsersInfo.test().getUserStream();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                  check_search = false;
                  // Scaffold.of(context).openEndDrawer();
                  showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height - 100,
                              child: Column(
                                children: [
                                  const Center(
                                      child: Text(
                                    "Tin nhắn mới",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  )),
                                  TextField(
                                    onTapOutside: (e) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    decoration: const InputDecoration(
                                        labelText: 'Đến:',
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                    onChanged: (val) {
                                      check_search = true;
                                      searchList.clear();
                                      for (var i in list) {
                                        if (i.displayName
                                                .toLowerCase()
                                                .contains(val.toLowerCase()) ||
                                            i.email
                                                .toLowerCase()
                                                .contains(val.toLowerCase())) {
                                          searchList.add(i);
                                        }
                                        if (val == '') {
                                          check_search = false;
                                        }
                                        ;
                                        setState(() {
                                          searchList;
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ListTile(
                                      leading: const Icon(Icons.account_tree),
                                      title: const Text(
                                        'Tạo nhóm mới',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      onTap: () => print('Tạo nhóm')),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  StreamBuilder(
                                      stream: userStream,
                                      builder: (context, snapshot) {
                                        final data = snapshot.data?.docs;
                                        list = data
                                                ?.map((e) => UsersInfo.fromJson(
                                                    e.data() as Map<String,
                                                        dynamic>))
                                                .toList() ??
                                            [];
                                        return ListView.builder(
                                            itemCount: check_search
                                                ? searchList.length
                                                : list.length,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return AddUser(
                                                  user: check_search
                                                      ? searchList[index]
                                                          .toJson()
                                                      : list[index].toJson());
                                            });
                                      })
                                ],
                              ),
                            ),
                          );
                        });
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
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: conversationStream,
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

                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            "Bạn chưa có ai để chat cả :((",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      }

                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              String peerId;
                              var userIds = data["id"].split("-");
                              if (userIds[0] == Auth().getCurrentUSer()?.uid) {
                                peerId = userIds[1];
                              } else {
                                peerId = userIds[0];
                              }
                              var peer = data["user_$peerId"];
                              return Card(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatScreen(
                                                  conversationsId: data["id"],
                                                  user: peer,
                                                )));
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 70,
                                          margin: const EdgeInsets.only(
                                              left: 5,
                                              top: 5,
                                              bottom: 5,
                                              right: 15),
                                          child: UserLogo(
                                              size: 35,
                                              imgUrl: peer["photoUrl"] != ""
                                                  ? peer["photoUrl"]
                                                  : "https://t4.ftcdn.net/jpg/00/97/58/97/360_F_97589769_t45CqXyzjz0KXwoBZT9PRaWGHRk5hQqQ.jpg")),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                100,
                                        height: 70,
                                        padding:
                                            const EdgeInsets.only(right: 100),
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                                peer["displayName"] != ""
                                                    ? peer["displayName"]
                                                    : peer["email"],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(
                                                data["last_message"]
                                                            ["message"] !=
                                                        ""
                                                    ? data["last_message"]
                                                        ["message"]
                                                    : "Hãy viết gì đó...",
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w400))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                            .toList()
                            .cast(),
                      );
                    }),
              ),
            ],
          ),
        ),
        drawer: const MyDrawer(),
      ),
    );
  }
}
