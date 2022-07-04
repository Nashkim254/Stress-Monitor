part of 'package:smart_stress/imports.dart';

class SplashScreenController extends GetxController {
  bool isLoading = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TimeOfDay midnight = TimeOfDay(hour: 00, minute: 00);
  var now = TimeOfDay.now();
  var scansDone = 0.obs;
  var scans = 3;
  var _isLoading = true.obs;
  var token = "".obs;
  Future resetScans() async {
    final SharedPreferences prefs = await _prefs;
    if (now == midnight) {
      prefs.setInt("scansDone", 0);
    }
  }

  var today = DateTime.now();
  final splashDelay = 3;
  bool visitor = false;
  bool loggedIn = false;
  var userId = "".obs;
  void setLoader() {
    isLoading = true;
    update();
  }

  void onInit() {
    getUserId();
    resetScans();

    super.onInit();
  }

  Future<String> getUserId() async {
    final SharedPreferences prefs = await _prefs;
    userId.value = prefs.getString("userId")!;
    token.value = prefs.getString("token")!;
    Future.delayed(const Duration(seconds: 3), () {
// Here you can write your code

      subscriptionMethod(userId.value, token.value);
    });

    return userId.value;
  }

  Future subscriptionMethod(String user_id, String token) async {
    final SharedPreferences prefs = await _prefs;
    _isLoading(true);
    ResponseModel response = await getSubscription(user_id, token);
    _isLoading(false);
    if (response.code == 200) {
      // showToastSuccess("${response.data['message']}");
      response.data["result"]["data"];
      _isLoading(false);
      if (response.data["result"]["data"] == null) {
        prefs.setBool("isSubscribed", false);
      } else {
        prefs.setBool("isSubscribed", true);
      }
      //  Get.off(CalendarView());
    } else if (response.code == 401) {
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

  String splashLogo(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? "assets/images/new_logo.png"
        : "assets/images/new_logo.png";
  }

  Future _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, goToApp);
  }

  Future<void> goToApp() async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.getBool("visitor") ?? false) {
      visitor = prefs.getBool("visitor") ?? true;
      prefs.setBool("visitor", true);
    } else {
      loggedIn = prefs.getBool("loggedIn") ?? true;
      ;
      prefs.setBool("loggedIn", true);
      visitor = true;
    }

    if (visitor) {
      Get.off(() => Nonsubscriber(),
          curve: Curves.fastOutSlowIn,
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 1500));
    } else {
      if (loggedIn) {
        Get.offAll(() => Nonsubscriber(),
            curve: Curves.fastOutSlowIn,
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 1500));
      } else {
        Get.off(() => CalendarView(),
            curve: Curves.fastOutSlowIn,
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 1500));
      }
    }
  }
}
