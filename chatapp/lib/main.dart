import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/conversations_screen.dart';
import 'package:chatapp/screens/Authentication/login_screen.dart';
import 'package:chatapp/screens/profile_screen.dart';
import 'package:chatapp/screens/Authentication/register_screen.dart';
import 'package:chatapp/widget_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WidgetTree(),
    );
  }
}
