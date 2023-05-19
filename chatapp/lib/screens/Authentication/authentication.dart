import 'package:chatapp/screens/Authentication/login_screen.dart';
import 'package:chatapp/screens/Authentication/register_screen.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool isLoginScreen = true;

  void gotoScreen() {
    setState(() {
      isLoginScreen = !isLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoginScreen == true
          ? LoginScreen(
              gotoRegisterScreen: gotoScreen,
            )
          : RegisterScreen(
              gotoLoginScreen: gotoScreen,
            ),
    );
  }
}
