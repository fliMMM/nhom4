import 'package:chatapp/models/auth.dart';
import 'package:chatapp/screens/Authentication/authentication.dart';
import 'package:chatapp/screens/conversations_screen.dart';
import 'package:chatapp/screens/Authentication/login_screen.dart';
import 'package:chatapp/screens/Authentication/register_screen.dart';
import 'package:flutter/widgets.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().getAuthStateChanges(),
      builder: ((context, snapshot) {
        // print("data: " + snapshot.data.toString());
        if (snapshot.data != null) {
          return const ConversationScreen();
        }
        return const AuthenticationScreen();
      }),
    );
  }
}
