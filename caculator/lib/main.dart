import 'package:caculator/keyboard.dart';
import 'package:caculator/result.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

void main() {
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
      home: const MyHomePage(title: 'My Caculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var opperator = ['+', "-", "x", '/'];
  var userInput = "0";
  var answer = "0";
  var preValue = "0";
  var preInput = "";

  void handleAnswer() {
    if (userInput == "") return;

    String userInputTemp = userInput.replaceAll('x', '*');
    userInputTemp = handleRemoveUselessOpperator(userInputTemp);

    try {
      var finalREsult = userInputTemp.interpret();
      setState(() {
        answer = finalREsult.toString();
      });
    } catch (_) {
      setState(() {
        answer = 0.toString();
      });
    }
  }

  String handleRemoveUselessOpperator(String text) {
    while (opperator.contains(text.substring(text.length - 1, text.length))) {
      text = text.substring(0, text.length - 1);
    }

    while (opperator.contains(text.substring(0, 1))) {
      text = text.substring(1, text.length);
    }
    return text;
  }

  String getlastCharacter(String text) {
    return text.substring(text.length - 1, text.length);
  }

  void handleChangeInput(value) {
    if (userInput.length > 14) return;
    if (userInput.isEmpty &&
        (value == 'x' ||
            value == '+' ||
            value == '/' ||
            value == '-' ||
            value == '%' ||
            value == '0')) return;
    setState(() {
      userInput += value;
    });
  }

  void handleTap(value) {
    switch (value) {
      case 'C':
        setState(() {
          userInput = "";
          answer = "0";
        });
        break;
      case 'deleteLeft':
        if (userInput.isNotEmpty) {
          setState(() {
            userInput = userInput.substring(0, userInput.length - 1);
            answer = "0";
          });
        }
        break;
      case '=':
        handleAnswer();
        setState(() {
          preValue = answer;
        });
        break;
      case 'Ans':
        setState(() {
          answer = preValue;
          userInput = answer;
        });
        break;
      default:
        handleChangeInput(value);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: MyResult(userInput: userInput, answer: answer)),
              MyKeyboard(
                handleTap: (String text) {
                  handleTap(text);
                },
              )
            ],
          ),
        ));
  }
}
