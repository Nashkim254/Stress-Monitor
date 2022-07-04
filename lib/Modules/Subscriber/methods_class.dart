part of 'package:smart_stress/imports.dart';

enum StartWeekDay { sunday, monday }

class CustomCalendar extends GetxController{
  final cont = Get.put(SubscriberController());
late  int totalDays;
// number of days in month
  //[JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC]
  final List<int> _monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
// check for leap year
  bool _isLeapYear(int year) {
    if (year % 4 == 0) {
      if (year % 100 == 0) {
        if (year % 400 == 0) return true;
        return false;
      }
      return true;
    }
    return false;
  }

  RxList<Calendar> calendar = <Calendar>[].obs;
  /// get the month calendarx
  /// month is between from 1-12 (1 for January and 12 for December)
  List<Calendar>? getMonthCalendar(int month, int year,
      {StartWeekDay startWeekDay = StartWeekDay.sunday}) {
    // validate
    if (year == null || month == null || month < 1 || month > 12)
      throw ArgumentError('Invalid year or month');
    // get no. of days in the month
    // month-1 because _monthDays starts from index 0
    // and month starts from 1
    totalDays = _monthDays[month - 1];
    // if this is a leap year and the month is february,
    // increment the total days by 1
    if (_isLeapYear(year) && month == DateTime.february) totalDays++;
    // get days for this month
    for (int i = 0; i < totalDays; i++) {
      calendar.value.add(
        Calendar(
          // i+1 because day starts from 1 in DateTime class
          date: DateTime(year, month, i + 1),
          thisMonth: true,
        ),
      );
    }
    // used for previous and next month's calendar days
    int otherYear;
    int otherMonth;
    int leftDays;
// fill the unfilled starting weekdays of this month
// with the previous month days
    if ((startWeekDay == StartWeekDay.sunday &&
            calendar.value.first.date.weekday != DateTime.sunday) ||
        (startWeekDay == StartWeekDay.monday &&
            calendar.value.first.date.weekday != DateTime.monday)) {
      // if this month is january,
      // then previous month would be decemeber of previous year
      if (month == DateTime.january) {
        otherMonth = DateTime.december;
        otherYear = year - 1;
      } else {
        otherMonth = month - 1;
        otherYear = year;
      }
      // month-1 because _monthDays starts from index 0
      // and month starts from 1
      cont.start_date.value = calendar.value.first.date.toString().split(" ").first;
      cont.end_date.value = calendar.value.last.date.toString().split(" ").first;
      totalDays = _monthDays[otherMonth - 1];
      if (_isLeapYear(otherYear) && otherMonth == DateTime.february)
        totalDays++;
      leftDays = totalDays -
          calendar.value.first.date.weekday +
          ((startWeekDay == StartWeekDay.sunday) ? 0 : 1);

      for (int i = totalDays; i > leftDays; i--) {
        // add days to the start of the list to maintain the sequence
        calendar.value.insert(
          0,
          Calendar(
            date: DateTime(otherYear, otherMonth, i),
            prevMonth: true,
          ),
        );
      }
    }
    // fill the unfilled ending weekdays of this month
// with the next month days
    if ((startWeekDay == StartWeekDay.sunday &&
            calendar.value.last.date.weekday != DateTime.saturday) ||
        (startWeekDay == StartWeekDay.monday &&
            calendar.value.last.date.weekday != DateTime.sunday)) {
      // if this month is december,
      // then next month would be january of next year
      if (month == DateTime.december) {
        otherMonth = DateTime.january;
        otherYear = year + 1;
      } else {
        otherMonth = month + 1;
        otherYear = year;
      }
      // month-1 because _monthDays starts from index 0
      // and month starts from 1
      totalDays = _monthDays[otherMonth - 1];
      if (_isLeapYear(otherYear) && otherMonth == DateTime.february)
        totalDays++;
      leftDays = 7 -
          calendar.last.date.weekday -
          ((startWeekDay == StartWeekDay.sunday) ? 1 : 0);
      if (leftDays == -1) leftDays = 6;
      for (int i = 0; i < leftDays; i++) {
        calendar.add(
          Calendar(
            date: DateTime(otherYear, otherMonth, i + 1),
            nextMonth: true,
          ),
        );
      }
    }
    return calendar;
  }
}
