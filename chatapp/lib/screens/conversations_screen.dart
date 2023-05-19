import 'package:chatapp/models/auth.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversation screen"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProfileScreen()));
              },
              icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          TextButton(
            child: const Text("sign out"),
            onPressed: () {
              Auth().signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
