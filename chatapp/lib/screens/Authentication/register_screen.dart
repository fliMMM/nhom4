import 'package:chatapp/models/auth.dart';
import 'package:chatapp/utils/validator.dart';
import 'package:chatapp/widgets/MyInput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final Function gotoLoginScreen;
  const RegisterScreen({super.key, required this.gotoLoginScreen});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

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

  Future<void> register() async {
    FocusManager.instance.primaryFocus?.unfocus();
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (email == "" || password == "" || confirmPassword == "") {
      showMyDialog("Chưa nhập email hoặc mật khẩu!!");
      return;
    }
    if (password != confirmPassword) {
      showMyDialog("Kiểm tra lại mật khẩu!!");
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
      await Auth().registerWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = Auth().getCurrentUSer();
      var myUser = {
        "uid": user?.uid,
        "email": user?.email,
        "photoUrl": user?.photoURL,
        "phoneNumber": user?.phoneNumber,
        "displayName": user?.displayName
      };

      FirebaseFirestore.instance.collection("Users").doc(user?.uid).set(myUser);

      if (context.mounted) {}
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showMyDialog('Mật khẩu quá yếu!');
      } else if (e.code == 'email-already-in-use') {
        showMyDialog('Tài khoản đã tồn tại!');
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    } finally {
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
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset("assets/images/iconchat.png"),
                ),
              ),
              SizedBox(
                  height: 340,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyInput(
                          label: "Email",
                          textEditingController: emailController),
                      MyInput(
                          label: "Mật khẩu",
                          textEditingController: passwordController),
                      MyInput(
                          label: "Xác nhận mật khẩu",
                          textEditingController: confirmPasswordController),
                      SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            style: ButtonStyle(
                                backgroundColor: isLoading == true
                                    ? MaterialStateProperty.all(Colors.grey)
                                    : MaterialStateProperty.all(
                                        const Color.fromRGBO(0, 100, 224, 1)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)))),
                            onPressed: isLoading == false ? register : null,
                            child: isLoading == false
                                ? const Text(
                                    "Đăng ký",
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
                      TextButton(
                          onPressed: () {
                            widget.gotoLoginScreen();
                          },
                          child: const Text("Đăng nhập"))
                    ],
                  )),
            ])));
  }
}
