import 'package:chatapp/models/auth.dart';
import 'package:chatapp/models/conversation.dart';
import 'package:chatapp/models/store.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/widgets/cardadduser.dart';
import 'package:chatapp/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/userinfo.dart';
import '../widgets/logo.dart';

List _userFilter = [];

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late Stream<QuerySnapshot> conversationStream;
  bool check_search = false;
  List<UsersInfo> list = [];
  List<UsersInfo> searchList = [];
  var currentUserId = Auth().getCurrentUSer()?.toString();
  late Stream<QuerySnapshot> userStream;

  @override
  void initState() {
    super.initState();
    Store.getSelfInfo();
    conversationStream = Conversation().getConversationStream();
    userStream = Store.firestore.collection('Users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    void handleUserFilter(String text) {
      // ignore: avoid_print
      List rs = [];
      if (text.isEmpty) {
        rs = [];
      } else {
        rs = []
            .where((user) => user["sender"]
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase()))
            .toList();
      }
      setState(() {
        _userFilter = rs;
        // ignore: avoid_print
        print(_userFilter);
      });
    }

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
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                        labelText: 'Đến:',
                                        labelStyle: TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                    onChanged: (val) {
                                      print(val);
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
                                        switch (snapshot.connectionState) {
                                          // if data is loading
                                          case ConnectionState.waiting:
                                          case ConnectionState.none:
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          // if some or all data is loaded then show it
                                          case ConnectionState.active:
                                          case ConnectionState.done:
                                            final data = snapshot.data?.docs;
                                            list = data
                                                    ?.map((e) =>
                                                        UsersInfo.fromJson(
                                                            e.data() as Map<
                                                                String,
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
                                                          : list[index]);
                                                });
                                        }
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
              Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  width: MediaQuery.of(context).size.width - 50,
                  height: 40,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[200]),
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
                          // ignore: avoid_print
                          onChanged: (value) => handleUserFilter(value),
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

                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;

                              var peerId = data["userIds"][0] == currentUserId
                                  ? data["userIds"][1]
                                  : data["userIds"][0];
                              var peer = data["user_$peerId"];

                              return Card(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatScreen(
                                                  conversationsId: data["id"],
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
                                              imgUrl: peer["photoUrl"])),
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
                                            Text(peer["displayName"],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(data["last_message"],
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

void _showBottomSheet() {}
