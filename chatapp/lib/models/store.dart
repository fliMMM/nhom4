import 'dart:developer';

import 'package:chatapp/models/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/userinfo.dart';

class Store {
  static late UsersInfo me;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => auth.currentUser!;

  static Future<void> getSelfInfo() async {
    //get data user
    await firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((user) async {
      if (user.exists) {
        me = UsersInfo.fromJson(user.data()!);
        log('My data: ${user.data()} ');
      }
    });
  }

  //update user
  static Future<void> updateUserInfo() async {
    await firestore
        .collection('Users')
        .doc(user.uid)
        .update({'displayName': me.displayName, 'phoneNumber': me.phoneNumber});
  }
}
