import 'package:chatapp/models/auth.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/login_screen.dart';
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
    String searchText="";



    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversation screen"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10,bottom: 10),
              width: MediaQuery.of(context).size.width-50,
              height: 40,
              padding: const EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[300]
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 28,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width-120,
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
              )
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount:fakedata.length,
                  itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatScreen()));
                    },
                    child: Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        margin: const EdgeInsets.only(left: 5,top: 5,bottom: 5,right: 15),
                        child: UserLogo(size: 35,imgUrl: "https://t4.ftcdn.net/jpg/00/97/58/97/360_F_97589769_t45CqXyzjz0KXwoBZT9PRaWGHRk5hQqQ.jpg")
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width-90,
                        height: 70,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Rac ruoi",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
                            Text('hihi',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400))
                          ],
                        ),
                      )
                    ],
                    ),
                  );
                },
                ),
              )
            ),
            


            // TextButton(onPressed: (){
            //   Navigator.push(
            // context,
            // MaterialPageRoute(
            //     builder: (context) => const ChatScreen()));
            // }, child: Text("move"))

          
            
          ],
        ),
      )
    );
  }
}
