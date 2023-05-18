import 'package:chatapp/screens/conversations_screen.dart';
import 'package:chatapp/screens/register_screen.dart';
import 'package:chatapp/utils/validator.dart';
import 'package:chatapp/widgets/MyInput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("test");

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await collectionReference.get();

    var allData = querySnapshot.docs.map((e) => e.data()).toList();

    print(allData);
  }

  void showMyDialog(String text, BuildContext context) {
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

  Future<void> login(BuildContext comtext) async {
    FocusManager.instance.primaryFocus?.unfocus();
    String email = emailController.text;
    String password = passwordController.text;

    if (email == "" || password == "") {
      showMyDialog("Chưa nhập email hoặc mật khẩu!!", context);
      return;
    }

    if (validator.emailValidator(email) == false) {
      showMyDialog("Email chưa đúng định dạng!!", context);
      return;
    }

    print("email: " + email);
    print("password: " + password);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const ConversationScreen()));
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          }))
                ])));
  }
}
