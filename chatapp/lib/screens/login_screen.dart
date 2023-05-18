import 'package:chatapp/models/auth.dart';
import 'package:chatapp/screens/register_screen.dart';
import 'package:chatapp/utils/validator.dart';
import 'package:chatapp/widgets/MyInput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final validator = Validator();

  void showMyDialog(String text) {
    showDialog(
        context: context,
        builder: (content) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            content: SizedBox(height: 50, child: Text(text)),
          );
        });
  }

  Future<void> login(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    String email = emailController.text;
    String password = passwordController.text;

    if (email == "" || password == "") {
      showMyDialog("Chưa nhập email hoặc mật khẩu!!");
      return;
    }

    if (validator.emailValidator(email) == false) {
      showMyDialog("Email chưa đúng định dạng!!");
      return;
    }

    try {
      await Auth().signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showMyDialog('Tài khoản chưa tồn tại!');
      } else if (e.code == 'wrong-password') {
        showMyDialog('Sai email hoặc mật khẩu!!');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding:
                const EdgeInsets.only(top: 70, left: 20, bottom: 20, right: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset("assets/images/message-icon.png"),
                  ),
                  SizedBox(
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyInput(
                            label: "Email",
                            textEditingController: emailController,
                          ),
                          MyInput(
                              label: "Mật khẩu",
                              textEditingController: passwordController),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromRGBO(0, 100, 224, 1)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)))),
                                child: const Text(
                                  "Đăng nhập",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  login(context);
                                }),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () {
                                  print("Quên mật khẩu");
                                },
                                child: const Text("Quên mật khẩu?")),
                          ),
                        ],
                      )),
                  SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: OutlinedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                          child: const Text("Tạo tài khoản mới"),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          }))
                ])));
  }
}
