import 'package:chatapp/models/auth.dart';
import 'package:chatapp/screens/Authentication/register_screen.dart';
import 'package:chatapp/utils/validator.dart';
import 'package:chatapp/widgets/MyInput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function gotoRegisterScreen;
  const LoginScreen({super.key, required this.gotoRegisterScreen});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final validator = Validator();
  bool isLoading = false;

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

  Future<void> login() async {
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

    setState(() {
      isLoading = true;
    });

    try {
      await Auth().signInWithEmailAndPassword(email: email, password: password);
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showMyDialog('Tài khoản chưa tồn tại!');
      } else if (e.code == 'wrong-password') {
        showMyDialog('Sai email hoặc mật khẩu!!');
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
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
                                    backgroundColor: isLoading == true
                                        ? MaterialStateProperty.all(Colors.grey)
                                        : MaterialStateProperty.all(
                                            const Color.fromRGBO(
                                                0, 100, 224, 1)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)))),
                                onPressed: isLoading == false ? login : null,
                                child: isLoading == false
                                    ? const Text(
                                        "Đăng nhập",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                              )),
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
                            widget.gotoRegisterScreen();
                          }))
                ])));
  }
}
