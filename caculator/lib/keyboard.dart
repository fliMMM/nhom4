import 'package:flutter/material.dart';

class MyKeyboard extends StatelessWidget {
  final handleTap;
  final List<Map<dynamic, dynamic>> btnList = [
    {'value': '0'},
    {'value': '.'},
    {'value': 'Ans'},
    {
      'value': '=',
      'textColor': Colors.white,
      'backgroundColor': const Color.fromARGB(255, 98, 195, 209)
    },
    {'value': '1'},
    {'value': '2'},
    {'value': '3'},
    {'value': '/'},
    {'value': '4'},
    {'value': '5'},
    {'value': '6'},
    {'value': "x"},
    {'value': '7'},
    {'value': '8'},
    {'value': '9'},
    {'value': '-'},
    {
      'value': 'C',
    },
    {'value': '%'},
    {'icon': Icons.backspace_outlined, 'title': 'deleteLeft'},
    {
      'value': '+',
    },
  ];

  MyKeyboard({super.key, this.handleTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 105 * 5,
        child: Align(
          alignment: Alignment.centerLeft,
          child: GridView.count(
            reverse: true,
            crossAxisCount: 4,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            children: List.generate(btnList.length, (index) {
              return button(
                  value: btnList[index]['value'],
                  icon: btnList[index]['icon'],
                  title: btnList[index]['title'],
                  onTap: handleTap);
            }),
          ),
        ));
  }
}

Widget button(
    {icon,
    title,
    onTap,
    backgroundColor = Colors.white,
    value,
    Color textColor = const Color.fromARGB(255, 98, 195, 209)}) {
  return ElevatedButton(
    onPressed: () => {onTap(value ?? title)},
    style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
    child: Center(
        child: value != null
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w300),
                ),
              )
            : Icon(
                icon,
                size: 40,
                color: const Color.fromARGB(255, 98, 195, 209),
              )),
  );
}
