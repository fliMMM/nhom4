import 'package:flutter/cupertino.dart';
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
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(1, (index) {
          print(daysInMonth);
          return Container();
        }),
      ),
    );
  }
}
