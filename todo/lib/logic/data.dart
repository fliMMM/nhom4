import 'dart:ffi';

class Data {
  List<Map> todoList = [];

  Data() {
    todoList.add({
      'title': 'nau com',
      'startDate': '20/12/2022',
      'endDate': '22/12/2022',
      'startTime': '20/12/2022',
      'endTime': '10/12/2022',
      'content': 'hehe'
    });
  }

  dynamic getData() {
    return todoList;
  }

  static int getDiffDay(Map item) {
    return int.parse(item['endDate'].split('/')[0]) -
        int.parse(item['startDate'].split('/')[0]);
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

  void handleDelete(item) {
    int index = -1;
    for (int i = 0; i < todoList.length; i++) {
      if (todoList[i]['id'] == item['id']) {
        index = i;
      }
    }

    // print(currItem.toString());
    if (index != -1) {
      todoList.removeAt(index);
    }
  }
}
