part of 'package:smart_stress/imports.dart';

class CalendarView extends StatelessWidget {
  final cont = Get.put(SubscriberController());
  final controller = Get.put(CustomCalendar());
  // get calendar for current month

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryTwoColor,
          centerTitle: true,
          title: Text(
            "Calendar",
            style: theme.textTheme.bodyText1!.copyWith(color: cardLightColor),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showPopupMenu(context, true, false);
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(color: shadePrimary),
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: cardLightColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _datesView(theme, context) // to be added in next step
                  ),
            ),
            Positioned(
              left: 0,
              bottom: 20,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // controller.checkRemainingScans();
                  Get.to(Nonsubscriber());
                },
                child: Image.asset(
                  "assets/images/scan.png",
                  height: 50,
                  width: 50,
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  // dates view
  Widget _datesView(theme, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // header
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // prev month button
            _toggleBtn(false),
            const SizedBox(
              width: 10,
            ),
            // next month button
            _toggleBtn(true),
            // month and year
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: InkWell(
                onTap: () {
                  // explained in later stages
                  cont._currentView.value = CalendarViews.months;
                },
                child: Text(
                  "${cont._monthNames[cont._currentDateTime.value.month - 1]}",
                  style: TextStyle(
                      color: primaryTwoColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(child: _calendarBody(theme, context)),
      ],
    );
  }

// next / prev month buttons
  Widget _toggleBtn(bool next) {
    return InkWell(
      // explained in later stages
      onTap: () {
        if (cont._currentView.value == CalendarViews.dates) {
          return (next) ? _getNextMonth() : _getPrevMonth();
        } else if (cont._currentView.value == CalendarViews.year) {
          if (next) {
            cont.midYear = (cont.midYear == null)
                ? cont._currentDateTime.value.year + 9
                : cont.midYear! + 9;
          } else {
            cont.midYear = (cont.midYear == null)
                ? cont._currentDateTime.value.year - 9
                : cont.midYear! - 9;
          }
        }
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: primaryTwoColor),
        child: Center(
          child: Icon(
            (next) ? Icons.arrow_right : Icons.arrow_left,
            color: cardLightColor,
            size: 30,
          ),
        ),
      ),
    );
  }

// calendar body
  Widget _calendarBody(theme, context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return
//8 colms, 6 rows

        Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: cont._sequentialDates.value.length + 7,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: (itemWidth / itemHeight),
            ),
            itemBuilder: (context, index) {
              cont.dateLength.addAll(cont._sequentialDates.value);
              if (index < 7) return _weekDayTitle(index);
              if (cont._sequentialDates.value[index - 7].date ==
                  cont._selectedDateTime.value) {
                return _selector(
                    cont._sequentialDates.value[index - 7], theme, context);
              }
              return _calendarDates(
                  cont._sequentialDates.value[index - 7], theme, context);
            },
          ),
        ),
        Expanded(
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: cont._sequentialDates.value.length == 42
                  ? 7
                  : cont._sequentialDates.value.length == 28
                      ? 5
                      : cont._sequentialDates.value.length == 35
                          ? 6
                          : 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: (itemWidth / itemHeight),
              ),
              itemBuilder: (context, index) {
                return statWidget(
                  index,
                  cont._sequentialDates.value.length == 42
                      ? 7
                      : cont._sequentialDates.value.length == 28
                          ? 5
                          : 6,
                );
              }),
        )
      ],
    );
  }

  Widget statWidget(
    int index,
    calendarDate,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: greyColor),
      ),
      child: index == 0
          ? Container(
              color: greyColor.withOpacity(0.2),
            )
          : InkWell(
              onTap: () {
                isDay(calendarDate)!
                    ? Get.to(StatsView(), arguments: [cont.results.value])
                    : () {};
              },
              child: Image.asset("assets/images/graphoutlined.png")),
    );
  }

// calendar header
  Widget _weekDayTitle(int index) {
    return Container(
      decoration: BoxDecoration(
        color: cont._weekDays[index] == "SUN"
            ? shadePrimary
            : greyColor.withOpacity(0.2),
        border: Border.all(color: greyColor),
      ),
      child: Center(
        child: Text(
          cont._weekDays[index],
          style: TextStyle(
              color:
                  cont._weekDays[index] == "SUN" ? primaryTwoColor : blackColor,
              fontSize: 10),
        ),
      ),
    );
  }

// calendar element
  Widget _calendarDates(Calendar calendarDate, theme, context) {
    return InkWell(
      onTap: () {
        if (cont._selectedDateTime != calendarDate.date) {
          if (calendarDate.nextMonth) {
            _getNextMonth();
          } else if (calendarDate.prevMonth) {
            _getPrevMonth();
          }
          cont._selectedDateTime.value = calendarDate.date;
          _showMyDialog(theme, calendarDate, context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: greyColor),
            color: (calendarDate.thisMonth)
                ? (calendarDate.date.weekday == DateTime.sunday)
                    ? shadePrimary
                    : cardLightColor
                : (calendarDate.date.weekday == DateTime.sunday)
                    ? shadePrimary
                    : cardLightColor),
        child: Center(child: Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  '${calendarDate.date.day}',
                  style: TextStyle(
                      color: (calendarDate.thisMonth)
                          ? (calendarDate.date.weekday == DateTime.sunday)
                              ? primaryTwoColor
                              : blackColor
                          : (calendarDate.date.weekday == DateTime.sunday)
                              ? primaryTwoColor
                              : blackColor),
                ),
              ),
              cont._isLoading.value == true
                  ? const Text("")
                  : reultMethod(calendarDate)!
            ],
          );
        })),
      ),
    );
  }

// date selector
  Widget _selector(Calendar calendarDate, theme, context) {
    return InkWell(
        onTap: () => _showMyDialog(theme, calendarDate, context),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: greyColor),
          ),
          child: Center(
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      '${calendarDate.date.day}',
                      style: TextStyle(
                          color: primaryTwoColor, fontWeight: FontWeight.w700),
                    ),
                  ),
                  cont._isLoading.value == true
                      ? const SizedBox()
                      : reultMethod(calendarDate)!
                ],
              );
            }),
          ),
        ));
  }

  Widget? reultMethod(calendarDate) {
    var seq = cont._sequentialDates.value.toList();

    var selectedDates = cont.listResults.toSet().toList();

    if (calendarDate.date.month == DateTime.now().month) {
      for (int i = 0; i <= selectedDates.length; i++) {
        /// 2022-05-17
        /// Date Time.
        /// get all dates current month
        /// match dates with results
        /// print matched dates
        /// compare matched dates with inbuilt calender and display results
        ///

        print(calendarDate.date.day);
        //print(selectedDates[i]);
        if (selectedDates[i] == calendarDate.date.day) {
          return const Text("lo");
        } else {
          return const Text("hh");
        }
      }
    }
    return const SizedBox();
  }

  // get next month calendar
  void _getNextMonth() {
    if (cont._currentDateTime.value.month == 12) {
      cont._currentDateTime.value =
          DateTime(cont._currentDateTime.value.year + 1, 1);
    } else {
      cont._currentDateTime.value = DateTime(cont._currentDateTime.value.year,
          cont._currentDateTime.value.month + 1);
    }
    cont._getCalendar();
  }

  bool? isDay(calendarDate) {
    for (int i = 0; i < cont.results.value.length; i++) {
      if (cont.listResults[i]["date"].split(" ").first ==
          calendarDate.date.toString().split(" ").first) {
        return true;
      }
      return false;
    }
  }

// get previous month calendar
  void _getPrevMonth() {
    if (cont._currentDateTime.value.month == 1) {
      cont._currentDateTime.value =
          DateTime(cont._currentDateTime.value.year - 1, 12);
    } else {
      cont._currentDateTime.value = DateTime(cont._currentDateTime.value.year,
          cont._currentDateTime.value.month - 1);
    }
    cont._getCalendar();
  }

  Future<void> _showMyDialog(theme, Calendar calendarDate, context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          title: Container(
              height: 50,
              width: double.infinity,
              color: primaryTwoColor,
              child: ListTile(
                leading: Text('Results',
                    style: theme.textTheme.bodyText1!
                        .copyWith(fontSize: 18.0, color: cardLightColor)),
                trailing: SizedBox(
                    height: 30,
                    width: 30,
                    child: InkWell(
                        onTap: () {
                          isDay(calendarDate)!
                              ? Get.to(StatsView(), arguments: [
                                  {
                                    "date": cont.results[0]['created_at'],
                                    "result": "Relaxed"
                                  }
                                ])
                              : () {};
                        },
                        child: Image.asset("assets/images/pgraph.png"))),
              )),
          content: Container(
            height: 200,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${calendarDate.date.day}/ ${calendarDate.date.month} /${calendarDate.date.year}',
                          style: TextStyle(color: blackColor),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 2,
                        color: greyColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: !cont.added.value
                            ? CircularProgressIndicator(
                                color: primaryTwoColor,
                              )
                            : Text(
                                isDay(calendarDate)! ? 'Relaxed' : "No result",
                                style: TextStyle(color: primaryTwoColor),
                              ),
                      ),
                    ],
                  ),
                  const Divider()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
