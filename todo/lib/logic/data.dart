import 'dart:ffi';

import 'package:todo/logic/caculate.dart';

class Data {
  List<Map> todoList = [];

  dynamic getData() {
    sortByFinish();
    return todoList;
  }

  static String getDiffDay(Map item) {
    int diffDay = int.parse(item['endDate'].split('/')[0]) -
        int.parse(item['startDate'].split('/')[0]);
    if (diffDay > 0) return "Còn $diffDay ngày";

    int diffHour = int.parse(item['endTime'].split(':')[0]) -
        int.parse(item['startTime'].split(':')[0]);
    if (diffDay == 0 && diffHour > 0) return "Còn $diffHour giờ";

    int diffMinute = int.parse(item['endTime'].split(':')[1]) -
        int.parse(item['startTime'].split(':')[1]);

    if (diffHour == 0 && diffMinute > 0) return "Còn $diffMinute phút";

    return "Hết hạn";
  }

  void handleAdd(Map item) {
    todoList.add(item);
  }

  void handleEdit(preItem, currItem) {
    int preIndex = -1;
    for (int i = 0; i < todoList.length; i++) {
      if (todoList[i]['id'] == preItem['id']) {
        preIndex = i;
      }
    }

    // print(currItem.toString());
    if (preIndex != -1) {
      todoList[preIndex] = currItem;
    }
  }

  void handleDelete(id) {
    int index = -1;
    for (int i = 0; i < todoList.length; i++) {
      if (todoList[i]['id'] == id) {
        index = i;
      }
    }

    // print(currItem.toString());
    if (index != -1) {
      todoList.removeAt(index);
    }
  }

  void finish(id) {
    for (int i = 0; i < todoList.length; i++) {
      if (todoList[i]['id'] == id) {
        todoList[i]['isFinish'] = !todoList[i]['isFinish'];
      }
    }
  }

  static bool validData(item) {
    if (item['title'] == "") return false;
    if (item['content'] == "") return false;
    if (item['startTime'] == "") return false;
    if (item['startDate'] == "") return false;
    if (item['endTime'] == "") return false;
    if (item['endDate'] == "") return false;

    if (Caculator.compareNowAndEndDate(item) == false) return false;
    if (Caculator.compareStartTimeAndEndTime(item) == false) return false;
    return true;
  }

  void sortByFinish() {
    todoList.sort((a, b) {
      if (a['isFinish']) {
        return 1;
      }

      return -1;
    });
  }
}
