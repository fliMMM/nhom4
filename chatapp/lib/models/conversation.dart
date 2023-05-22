import 'package:chatapp/models/auth.dart';
import 'package:chatapp/models/store.dart';
import 'package:chatapp/models/userinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  CollectionReference<Map<String, dynamic>> conversationRef =
      FirebaseFirestore.instance.collection("Conversations");
  var currentUser = Auth().getCurrentUSer();

  Stream<QuerySnapshot> getConversationStream() {
    return conversationRef
        .where("userIds",
            arrayContains: Auth().getCurrentUSer()?.uid.toString())
        .snapshots();
  }

  Future<String> addConversation(UsersInfo peerInfo) async {
    var currentUser = Auth().getCurrentUSer();
    var currentUSerId = currentUser?.uid;
    var peerId = peerInfo.uid;
    String conversationId;

    if (currentUSerId.hashCode < peerId.hashCode) {
      conversationId = "$currentUSerId-$peerId";
    } else {
      conversationId = "$peerId-$currentUSerId";
    }

    var doc = await conversationRef.doc(conversationId).get();
    if (!doc.exists) {
      var conversation = {
        "id": conversationId,
        "last_message": {"senderId": null, "message": ""},
        "userIds": [peerId, currentUSerId],
        "user_$currentUSerId": {
          "displayName": Store.me.displayName,
          "email": Store.me.email,
          "photoUrl": Store.me.photoUrl
        },
        "user_$peerId": {
          "displayName": peerInfo.displayName,
          "email": peerInfo.email,
          "photoUrl": peerInfo.photoUrl
        }
      };
      await conversationRef.doc(conversationId).set(conversation);
      return conversationId;
    }

    return conversationId;
  }
}
