class Caculator {
  static bool compareNowAndEndDate(item) {
    DateTime currentDay = DateTime.now();

    String itemDay = item['endDate'].split('/')[0];
    String itemMonth = item['endDate'].split('/')[1];
    String itemYear = item['endDate'].split('/')[2];
    String itemHour = item['endTime'].split(':')[0];
    String itemMinute = item['endTime'].split(':')[1];

    if (itemMonth.length == 1) itemMonth = "0$itemMonth";
    if (itemDay.length == 1) itemDay = "0$itemDay";
    if (itemHour.length == 1) itemHour = "0$itemHour";
    if (itemMinute.length == 1) itemMinute = "0$itemMinute";

    String formatDateItem =
        "$itemYear-$itemMonth-$itemDay $itemHour:$itemMinute:00";
    // print(formatDateItem);

    DateTime d1 = DateTime.parse(formatDateItem);
    // print(d1.isBefore(currentDay));

    return !d1.isBefore(currentDay);
  }

  static bool compareStartTimeAndEndTime(item) {
    String endDay = item['endDate'].split('/')[0];
    String endMonth = item['endDate'].split('/')[1];
    String endYear = item['endDate'].split('/')[2];
    String endHour = item['endTime'].split(':')[0];
    String endMinute = item['endTime'].split(':')[1];

    if (endMonth.length == 1) endMonth = "0$endMonth";
    if (endDay.length == 1) endDay = "0$endDay";
    if (endHour.length == 1) endHour = "0$endHour";
    if (endMinute.length == 1) endMinute = "0$endMinute";

    String formatDateEnd = "$endYear-$endMonth-$endDay $endHour:$endMinute:00";
    // print(formatDateItem);

    DateTime end = DateTime.parse(formatDateEnd);
    // print(d1.isBefore(currentDay));

    String startDay = item['startDate'].split('/')[0];
    String startMonth = item['startDate'].split('/')[1];
    String startYear = item['startDate'].split('/')[2];
    String startHour = item['startTime'].split(':')[0];
    String startMinute = item['startTime'].split(':')[1];

    if (startMonth.length == 1) startMonth = "0$startMonth";
    if (startDay.length == 1) startDay = "0$startDay";
    if (startHour.length == 1) startHour = "0$startHour";
    if (startMinute.length == 1) startMinute = "0$startMinute";

    String formatDateStart =
        "$startYear-$startMonth-$startDay $startHour:$startMinute:00";
    // print(formatDateItem);

    DateTime start = DateTime.parse(formatDateStart);

    print(start.isBefore(end));

    return start.isBefore(end);
  }
}
