import 'package:chatapp/models/auth.dart';
import 'package:chatapp/models/store.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/Authentication/login_screen.dart';
import 'package:chatapp/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/logo.dart';
import 'package:cached_network_image/cached_network_image.dart';

final fakedata = [
  {"sender": "hieu", "data": "Solo Aatrox khong?"},
  {"sender": "back", "data": "thoi t so lam"},
  {"sender": "hieu", "data": "tuong the nao"},
  {"sender": "hieu", "data": "lan trc solo thua la do t nhuong m aatrox thoi"},
  {"sender": "back", "data": "ghe vay sao"},
  {"sender": "hieu", "data": "la ro, k ghe sao lai solo thang dc"},
  {"sender": "back", "data": "m la nhat roi"},
];

List _userFilter = fakedata;

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  void initState() {
    super.initState();
    Store.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    void handleUserFilter(String text) {
      // ignore: avoid_print
      List rs = [];
      if (text.isEmpty) {
        rs = fakedata;
      } else {
        rs = fakedata
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
                    isDismissible: true,
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
                child: ListView.builder(
              itemCount: _userFilter.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: GestureDetector(
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
                        Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 70,
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(_userFilter[index]['sender'].toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              Text(_userFilter[index]['data'].toString(),
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                        )
                      ],
                    ),
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
  final image = Auth().getCurrentUSer()?.photoURL;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        children: [
          Center(
              child: Text(
            "Tin nhắn mới",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          )),
          TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Đến:',
                labelStyle: TextStyle(color: Colors.black, fontSize: 15)),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
              leading: Icon(Icons.account_tree),
              title: const Text(
                'Tạo nhóm mới',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () => print('Tạo nhóm')),
          SizedBox(
            height: 10,
          ),
          StreamBuilder(
              stream: Store.firestore.collection('Users').snapshots(),
              builder: (context, snapshot) {
                final list = [];
                final listImage = [];
                if (snapshot.hasData) {
                  final data = snapshot.data?.docs;
                  for (var i in data!) {
                    list.add(i.data()['displayName']);
                    listImage.add(i.data()['photoUrl']);
                  }
                }
                return ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        elevation: 0.1,
                        child: InkWell(
                          onTap: () {},
                          child: ListTile(
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              .055,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .055,
                                      imageUrl: '${listImage[index]}',
                                      errorWidget: (context, url, error) =>
                                          const CircleAvatar(
                                            child: Icon(CupertinoIcons.person),
                                          )),
                                )),
                            title: Text('${list[index]}'),
                          ),
                        ),
                      );
                    });
              })
        ],
      ),
    ),
  );
}
