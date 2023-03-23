import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:giuaki/logic/Calendar.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  int currentMonth = DateTime.now().month;
  int currentYear = DateTime.now().year;
  dynamic daysInMonth;

  @override
  void initState() {
    super.initState();
    daysInMonth = MyCalendar.getDaysInMonth(currentYear, currentMonth);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: Text("hehe"),
      decoration: BoxDecoration(color: Color.fromARGB(255, 212, 223, 235)),
    );
  }
}
