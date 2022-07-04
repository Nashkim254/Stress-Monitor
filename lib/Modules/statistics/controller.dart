part of 'package:smart_stress/imports.dart';

class StatsController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final cont = Get.put(SubscriberController());
  var _isLoading = true.obs;
  var diagnosis = "".obs;
  var token = "".obs;
  var results = [];
  var isDay = true.obs;
  final _currentDate = DateTime.now();
  final _dayFormatter = DateFormat('d');
  final _monthFormatter = DateFormat('MMM');
  final dates = <String>[];
  var reversed;
  var todays = <String>[];
  final today = DateFormat('EEEE'); // Sunday
  var data;
  var start_date = "".obs;
  var end_date = "".obs;
  var selected_date = "".obs;
  var userId = "".obs;
  var listResults = [].obs;
  var added = false.obs;

  Future getData() async {
    final SharedPreferences prefs = await _prefs;
    token.value = prefs.getString("token")!;
  }

  @override
  void onInit() {
    getData();
    getPreviousDates();
    getDates();
    reversed = dates.reversed.toList();
    getUserId();
    super.onInit();
  }

  void getPreviousDates() {
    for (int i = 0; i < 5; i++) {
      final date = _currentDate.subtract(Duration(days: i));
      dates.add(
        "${_dayFormatter.format(date)}\n ${_monthFormatter.format(date)} ",
      );
    }
  }

  void getDates() {
    final date = DateTime.parse(cont.results[0]['created_at']);
    todays.add(
      "${today.format(date)}, ${_monthFormatter.format(date)} ${_dayFormatter.format(date)}, ${_currentDate.year} ",
    );
  }

  getUserId() async {
    final SharedPreferences prefs = await _prefs;
    userId.value = prefs.getString("userId")!;
    token.value = prefs.getString("token")!;
    Future.delayed(const Duration(seconds: 3), () {
// Here you can write your code
      getHistory(
          MetricModel(
              start_date: "2022-06-01",
              end_date: "2022-06-31",
              user_key: userId.value),
          token.value);
      added(true);
      _isLoading(false);
    });
  }

  Future<void> getHistory(MetricModel model, String token) async {
    _isLoading(true);
    ResponseModel response = await getmetric(model, token);

    if (response.code == 200) {
      if (response.data['result'].isEmpty) {
        diagnosis.value = "No results found";
      } else {
        results = response.data['result'];
        for (int i = 0; i <= results.length; i++) {
          if (results[i]['diagnosis'] != null) {
            listResults.add({
              "diag": results[i]['diagnosis'],
              "date": results[i]['created_at']
            });
          }
        }
        // diagnosis.value = response.data['result'][0]['diagnosis'];
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
