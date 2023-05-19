import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId = "";
  String receiverId = "";
  String messges = "";
  int timestamp;

  Message(
      {required this.messges,
      required this.receiverId,
      required this.senderId,
      required this.timestamp});
}
