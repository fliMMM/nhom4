import 'dart:ffi';

class Data {
  List<Map> todoList = [];

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

  void handleDelete(id) {
    int index = -1;
    for (int i = 0; i < todoList.length; i++) {
      if (todoList[i]['id'] == id) {
        index = i;
      }
    }

    print(index);

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
}
