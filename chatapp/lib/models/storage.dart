import 'dart:developer';
import 'dart:io';

import 'package:chatapp/models/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static User get user => auth.currentUser!;
  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split('.').last;
    log('Extension: $ext');
    //storage file ref with path
    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });
    var image = await ref.getDownloadURL();
    //updating image
    user.updatePhotoURL(image);
  }
}
