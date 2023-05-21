import 'package:chatapp/models/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  CollectionReference<Map<String, dynamic>> conversationRef =
      FirebaseFirestore.instance.collection("Conversations");

  Stream<QuerySnapshot> getConversationStream() {
    return conversationRef
        .where("userIds",
            arrayContains: Auth().getCurrentUSer()?.uid.toString())
        .snapshots();
  }
}
