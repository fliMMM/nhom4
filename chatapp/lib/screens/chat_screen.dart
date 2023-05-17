import 'package:chatapp/models/message.dart';
import 'package:flutter/material.dart';
import 'widgets/boxchat.dart';

class SingleChat{
  final String time;
  final String sender;
  final String message;
  SingleChat({required this.time,required this.sender,required this.message});
  factory SingleChat.fromJson(Map<String,dynamic> json){
    return SingleChat(
      time:json['time'].toString(),
      sender:json['sender'].toString(),
      message:json['message'].toString()
    );
  }
}

class Data {
  final String stuff;
  final List<SingleChat> messageData;
  Data({required this.stuff,required this.messageData});
  factory Data.fromJson(Map<String,dynamic> parsedJson) {
    return Data(
      stuff: parsedJson['stuff'].toString(),
      messageData: parsedJson["data"]
    );
  }
}



class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text("Chat screen"),
      ),
      body: ListView(
        reverse: true,
        children: const <Widget>[
          BoxChat(isUser:true,data: "hehe"),
          BoxChat(isUser:false,data: "huhu asd jka skj dga askdj gas kjhd ga skd as kjd hak sjg ak djs g adk"),
          BoxChat(isUser:true,data: "hhihi"),
          BoxChat(isUser:true,data: "hehe"),
          BoxChat(isUser:false,data: "huhu asd jka skj dga askdj gas kjhd ga skd as kjd hak sjg ak djs g adk"),
          BoxChat(isUser:true,data: "hhihi"),
          BoxChat(isUser:true,data: "hehe"),
          BoxChat(isUser:false,data: "huhu asd jka skj dga askdj gas kjhd ga skd as kjd hak sjg ak djs g adk"),
          BoxChat(isUser:true,data: "hhihi"),
          BoxChat(isUser:true,data: "hehe"),
          BoxChat(isUser:false,data: "huhu asd jka skj dga askdj gas kjhd ga skd as kjd hak sjg ak djs g adk"),
          BoxChat(isUser:true,data: "hhihi"),
          BoxChat(isUser:true,data: "hehe"),
          BoxChat(isUser:false,data: "huhu asd jka skj dga askdj gas kjhd ga skd as kjd hak sjg ak djs g adk"),
          BoxChat(isUser:true,data: "hhihi"),
          BoxChat(isUser:true,data: "hhihi"),
          BoxChat(isUser:true,data: "hhihi"),
        ],
      )
    );
  }
}
