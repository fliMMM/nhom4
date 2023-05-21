import 'package:chatapp/models/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  var messageRef = FirebaseFirestore.instance.collection("messages");

  Stream<QuerySnapshot> getMessageStream(String conversationId) {
    return messageRef
        .orderBy("timestamp")
        .where("id", isEqualTo: conversationId)
        .snapshots();
  }

  Future<void> sendMessage(String conversationId, String text) async {
    if (text != "") {
      var userIds = conversationId.split("-");
      String? currentUserId = Auth().getCurrentUSer()?.uid.toString();

      final data = {
        "id": conversationId,
        "senderId": currentUserId,
        "receiverId": userIds[0] == currentUserId ? userIds[1] : userIds[0],
        "text": text,
        "timestamp": DateTime.now().microsecondsSinceEpoch
      };
      await messageRef.add(data).then((value) {
        print("send message success: $value");
        FirebaseFirestore.instance
            .collection("Conversations")
            .doc(conversationId)
            .update({
          "last_message": {
            "senderId": Auth().getCurrentUSer()?.uid,
            "message": text,
          }
        });
      });
    }
  }
}
