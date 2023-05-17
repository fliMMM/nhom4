import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("test");

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await collectionReference.get();

    var allData = querySnapshot.docs.map((e) => e.data()).toList();

    print(allData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login screen"),
      ),
      body: Container(
          child: TextButton(
        onPressed: () {
          getData();
        },
        child: const Text("hehe"),
      )),
    );
  }
}
