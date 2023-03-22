import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CreateTask extends StatefulWidget {
  late Function handleTodo;
  dynamic action;
  dynamic preItem;
  CreateTask({super.key, required this.handleTodo, this.action, this.preItem});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  String title = "";
  String content = "";
  String startTime = "${DateTime.now().hour}:${DateTime.now().minute}";
  String endTime = 'Thời gian';
  String startDate =
      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
  String endDate = 'Ngày';

  Future<void> handleDatePicker(BuildContext context, label) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2030));
    if (pickedDate != null) {
      if (label == 'start') {
        setState(() {
          startDate =
              "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          widget.preItem['startDate'] = startDate;
        });
      } else {
        setState(() {
          endDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          widget.preItem['endDate'] = endDate;
        });
      }
    }
  }

  Future<void> handleTimePicker(BuildContext context, label) async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      if (label == 'start') {
        setState(() {
          startTime = pickedTime.format(context);
          widget.preItem['startTime'] = startTime;
        });
      } else {
        setState(() {
          endTime = pickedTime.format(context);
          widget.preItem['endTime'] = endTime;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 224, 141, 116),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  if (widget.action == 'edit') {
                    widget.handleTodo(
                        "",
                        'edit',
                        {
                          'id': widget.preItem['id'],
                          'title':
                              title == "" ? widget.preItem['title'] : title,
                          'content': content == ""
                              ? widget.preItem['content']
                              : content,
                          'startDate': startDate == "Ngày"
                              ? widget.preItem['startDate']
                              : startDate,
                          'endDate': endDate == "Ngày"
                              ? widget.preItem['endDate']
                              : endDate,
                          'startTime': startTime == "Thời gian"
                              ? widget.preItem['startTime']
                              : startTime,
                          'endTime': endTime == "Thời gian"
                              ? widget.preItem['endTime']
                              : endTime,
                          'isFinish': widget.preItem['isFinish']
                        },
                        widget.preItem);

                    return;
                  } else {
                    widget.handleTodo({
                      'id': Uuid().v1(),
                      'title': title,
                      'content': content,
                      'startDate': startDate,
                      'endDate': endDate,
                      'startTime': startTime,
                      'endTime': endTime,
                      'isFinish': false
                    }, 'Add', "", "");
                  }
                },
                child: const Text("Lưu",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            TextFormField(
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              initialValue:
                  widget.action == 'edit' ? widget.preItem['title'] : "",
              decoration: const InputDecoration(labelText: "Tiêu đề"),
            ),
            TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                setState(() {
                  content = value;
                });
              },
              initialValue:
                  widget.action == 'edit' ? widget.preItem['content'] : "",
              decoration: const InputDecoration(labelText: "Nội dung"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bắt đầu",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            handleTimePicker(context, 'start');
                          },
                          child: Text(widget.action == 'edit'
                              ? widget.preItem['startTime']
                              : startTime)),
                      TextButton(
                          onPressed: () {
                            handleDatePicker(context, 'start');
                          },
                          child: Text(widget.action == 'edit'
                              ? widget.preItem['startDate']
                              : startDate)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Kết thúc",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            handleTimePicker(context, 'end');
                          },
                          child: Text(widget.action == 'edit'
                              ? widget.preItem['endTime']
                              : endTime)),
                      TextButton(
                          onPressed: () {
                            handleDatePicker(context, 'end');
                          },
                          child: Text(widget.action == 'edit'
                              ? widget.preItem['endDate']
                              : endDate)),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
