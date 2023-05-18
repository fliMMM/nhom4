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
        // color: Colors.red,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
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
            Container(
                    margin: const EdgeInsets.only(top:25),
                    padding: const EdgeInsets.only(left: 15),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, index) => UserLogo(size: 35,imgUrl: "https://t4.ftcdn.net/jpg/00/97/58/97/360_F_97589769_t45CqXyzjz0KXwoBZT9PRaWGHRk5hQqQ.jpg") )
                      )
          ],
        ),
      )
    );
  }
}
