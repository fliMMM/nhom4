class Caculator {
  static bool quaHan(item) {
    int currentDay = DateTime.now().day;

    int itemDay = int.parse(item['endDate'].split('/')[0]);

    return itemDay > currentDay;
  }
}
