import 'package:flutter/material.dart';

class MyResult extends StatefulWidget {
  String userInput = "";
  String answer = "";
  MyResult({super.key, required this.answer, required this.userInput});

  @override
  State<MyResult> createState() => _MyResultState();
}

class _MyResultState extends State<MyResult> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: myText(
                    title: widget.userInput,
                    textColor: Colors.black,
                    fontsize: 70)),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: myText(title: widget.answer, fw: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

Widget myText(
    {title = "1+1",
    Color textColor = const Color.fromARGB(255, 98, 195, 209),
    double fontsize = 40,
    FontWeight fw = FontWeight.w300}) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      title,
      style: TextStyle(color: textColor, fontSize: fontsize, fontWeight: fw),
    ),
  );
}
