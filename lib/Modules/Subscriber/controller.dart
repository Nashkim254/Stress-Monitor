part of 'package:smart_stress/imports.dart';

enum CalendarViews { dates, months, year }

class SubscriberController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var start_date = "".obs;
  var end_date = "".obs;
  var selected_date = "".obs;
  var _isLoading = true.obs;
  var diagnosis = "".obs;
  var userId = "".obs;
  var token = "".obs;
  var listResults = [].obs;

  var dateLength = [];
  var results = [].obs;
  final Rx<CalendarViews> _currentView = Rx<CalendarViews>(CalendarViews.dates);
  var added = false.obs;
  Rx<DateTime> _currentDateTime = DateTime.now().obs;
  var _selectedDateTime = Rxn<DateTime>();
  RxList<Calendar> _sequentialDates = <Calendar>[].obs;
  int? midYear;
  final List<String> _weekDays = [
    'SUN',
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
  ];
  final List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  @override
  void onInit() {
    getUserId();
    var date = DateTime.now();
    _currentDateTime.value = DateTime(date.year, date.month);
    _selectedDateTime.value = DateTime(date.year, date.month, date.day);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCalendar();
    });
    super.onInit();
  }

  void _getCalendar() {
    _sequentialDates.value = CustomCalendar().getMonthCalendar(
        _currentDateTime.value.month, _currentDateTime.value.year,
        startWeekDay: StartWeekDay.sunday)!;
  }

  Future<String> getUserId() async {
    final SharedPreferences prefs = await _prefs;
    userId.value = prefs.getString("userId")!;
    token.value = prefs.getString("token")!;
    Future.delayed(const Duration(seconds: 3), () {
// Here you can write your code\
      getHistory(
          MetricModel(
              start_date: start_date.value,
              end_date: end_date.value,
              user_key: userId.value),
          token.value);
    });

    return userId.value;
  }

  String? returnDate(String value) {
    if (value.startsWith("0")) {
      var splited = value.split('');
      return splited[1];
    }
    return value;
  }

  Future<void> getHistory(MetricModel model, String token) async {
    _isLoading(true);
    ResponseModel response = await getmetric(model, token);
    if (response.code == 200) {
      if (response.data['result'].isEmpty) {
        diagnosis.value = "No results found";
      } else {
        results.value = response.data['result'];
        print(results.value.toString());
        for (int i = 0; i < results.length; i++) {
          var dates = results[i]['created_at'];
          var day = dates.split(' ');
          var edited = day[0].toString().split("-")[2];
          listResults.add(returnDate(edited.toString()));
        }
        _isLoading(false);
        added(true);
        update();

        diagnosis.value = response.data['result'][0]['diagnosis'];
      }
    } else if (response.code == 422) {
      Get.dialog(ConfirmDialog(
        color: errorColor,
        message: response.data["message"],
        onPressed: () => Get.back(),
      ));
    } else if (response.code == 500) {
      Get.dialog(ConfirmDialog(
        color: errorColor,
        message: response.data["message"],
        onPressed: () => Get.back(),
      ));
    } else {
      Get.dialog(ConfirmDialog(
        color: errorColor,
        message: response.data["message"],
        onPressed: () => Get.back(),
      ));
      _isLoading(false);
    }
    update();
  }
}
