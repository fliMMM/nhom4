import 'package:chatapp/models/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersInfo {
  CollectionReference<Map<String, dynamic>> userRef =
      FirebaseFirestore.instance.collection("Users");
  late String displayName;
  late String email;
  late String phoneNumber;
  late String photoUrl;
  late String uid;

  UsersInfo({
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoUrl,
    required this.uid,
  });

  UsersInfo.test();
  UsersInfo.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'] ?? '';
    email = json['email'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    photoUrl = json['photoUrl'] ?? '';
    uid = json['uid'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['photoUrl'] = photoUrl;
    data['uid'] = uid;
    return data;
  }

  Future<Map<String, dynamic>?> getPeer(String conversationId) async {
    var userIds = conversationId.split("-");
    var peerId =
        userIds[0] == Auth().getCurrentUSer()?.uid ? userIds[1] : userIds[0];

    DocumentSnapshot<Map<String, dynamic>> peerInfo =
        await userRef.doc(peerId).get();

    return peerInfo.data();
  }
}
