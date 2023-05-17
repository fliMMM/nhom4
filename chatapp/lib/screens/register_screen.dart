import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/utils/validator.dart';
import 'package:chatapp/widgets/MyInput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
    String confirmPassword = confirmPasswordController.text;

    if (email == "" || password == "" || confirmPassword == "") {
      showMyDialog("Chưa nhập email hoặc mật khẩu!!", context);
      return;
    }
    if (password != confirmPassword) {
      showMyDialog("Kiểm tra lại mật khẩu!!", context);
      return;
    }

    if (validator.emailValidator(email) == false) {
      showMyDialog("Email chưa đúng định dạng!!", context);
      return;
    }

    print("email: " + email);
    print("password: " + password);
    print("confim password: " + confirmPassword);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
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
                  child: Image.asset("assets/images/message-icon.png"),
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
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(0, 100, 224, 1)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)))),
                            child: const Text(
                              "Đăng ký",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              login(context);
                            }),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text("Đăng nhập"))
                    ],
                  )),
            ])));
  }
}
