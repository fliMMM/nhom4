import 'package:flutter/material.dart';
import 'widgets/boxchat.dart';



void handleSend(e){
  // ignore: avoid_print
  print(e.toString());
}


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  
  ScrollController listScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    String? text;
    return Scaffold(
      appBar: AppBar(
        
        title: const Text("Chat screen"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[400],
        child: Stack(
          children: [
            ListView.builder(
              shrinkWrap: true,
              controller: listScrollController,
              itemCount:20,
              padding: const EdgeInsets.only(bottom: 50,top:10),
              itemBuilder: (BuildContext context, int index) {
                  return BoxChat(isUser: index%3==0, data: "hieu 123 hieu 123 hieu 123 hieu 123 hieu 123 hieu 123 hieu 123 hieu 123 hieu 123 hieu 123 hieu 123 hieu 123${index.toString()}");
                },
          
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width-40,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        minLines: 1,
                        decoration: const InputDecoration(
                          hintText: "Type a message...",
                          contentPadding: EdgeInsets.all(10)
                        ),

                        onChanged: (e)=>{text=e.toString()},
                      ),
                    )
                  ),
                  CircleAvatar(
                    child: IconButton(
                      icon:const Icon(Icons.arrow_right_sharp

                      ),
                      onPressed: ()=>{
                        handleSend(text),
                        listScrollController.animateTo(
                          listScrollController.position.maxScrollExtent,
                          duration: const Duration(microseconds: 500),
                          curve: Curves.easeOut
                          )
                        }
                    ),
                  ),
                ],
              )
            )
          ],
        )
      )
    );
  }
}
