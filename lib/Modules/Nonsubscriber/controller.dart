part of 'package:smart_stress/imports.dart';

class NonsubscriberController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var isLoggedin = false.obs;
  var _isLoading = false.obs;
  var token = "".obs;
  TimeOfDay midnight = TimeOfDay(hour: 00, minute: 00);
  var now = TimeOfDay.now();
  var scansDone = 0.obs;
  var scans = 3;

  Future resetScans() async {
    final SharedPreferences prefs = await _prefs;
    if (now == midnight) {
      prefs.setInt("scansDone", 0);
    }
  }

  Future checkRemainingScans() async {
    final SharedPreferences prefs = await _prefs;
    isLoggedin.value = prefs.getBool("isSubscribed") ?? false;
    scansDone.value = prefs.getInt('scansDone') ?? 0;
    prefs.setString("timeOfFirstScan", now.toString());
    if (isLoggedin.value) {
      Get.to(Webview());
    } else if (scans == scansDone.value) {
      Get.to(Subscription());
      return Get.dialog(ConfirmDialog(
         color: errorColor,
        message: "You're out of free daily checks, Please subscribe",
        onPressed: () => Get.back(),
      ));
    } else {
      scansDone.value = scansDone.value + 1;
      Get.to(Webview());
      prefs.setInt("scansDone", scansDone.value);
    }
    return scansDone.value;
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future getData() async {
    final SharedPreferences prefs = await _prefs;
    isLoggedin.value = prefs.getBool("isSubscribed")!;
    token.value = prefs.getString("token")!;
    print("token here");
    print("${token.value}");
  }

  Future diagnosisMethod(DiagnosisModel modelData, String token) async {
    _isLoading(true);
    ResponseModel response = await postDiagnosis(modelData, token);
    _isLoading(false);
    if (response.code == 200) {
      Get.dialog(ConfirmDialog(
        color:primaryColor,
        message: response.data["message"],
        onPressed: ()=>Get.offAll(Nonsubscriber()),
      ));

      _isLoading(false);
    } else if (response.code == 401) {
      Get.dialog(ConfirmDialog(
        color: errorColor,
        message: response.data["message"],
        onPressed: () => Get.back(),
      ));
    } else if (response.code == 500) {
      Get.dialog(ConfirmDialog(
         color: errorColor,
        message: "${response.data["message"]}" + "Kindly\nlogin to continus",
        onPressed: () => Get.offAll(const Signin()),
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

  var isScanning = false.obs;

  var video_loaded = false.obs;
  var scanning = false.obs;
  var spo2_rate = ''.obs;
  var bs_rate = ''.obs;
  var syst_rate = ''.obs;
  var diast_rate = ''.obs;
  var br_rate = ''.obs;
  var hr_rate = ''.obs;
  var diagnosis = ''.obs;
  var isRelaxed = false.obs; //0
  var isModerate = false.obs; //2
  var isMild = false.obs; //1
  var isStressed = false.obs; //3
  var isOverworked = false.obs; //4
  var isLoading = false.obs;
  var isLoad = false.obs;
  var isScan = false.obs;
  var result = "".obs;
  var isResultReady = false.obs;
  // isDiagnosed() {
  //   if (diagnosis == "Caution") {
  //     printError(spo2_rate.value);
  //     isModerate.value = true;
  //     printSuccess("caution" + "${isModerate.value}");
  //     isRelaxed.value = false;
  //     isLoad.value = false;
  //     isScan.value = false;
  //     return;
  //   } else if (diagnosis == "Healthy") {
  //     isRelaxed.value = true;
  //     printSuccess("healthy" + "${isRelaxed.value}");
  //     isLoad.value = false;
  //     isScan.value = false;
  //     isModerate.value = false;
  //     return;
  //   } else if (diagnosis == "Loading") {
  //     isScan.value = true;
  //     printSuccess("Loading" + "${isScan.value}");
  //     isLoad.value = false;
  //     return;
  //   } else if (diagnosis == "") {
  //     isScan.value = false;
  //     isLoad.value = true;
  //     printSuccess("is Scanning" + "${isLoad.value}");
  //     return;
  //   }
  // }

  void stressLevels() {
    if (diagnosis == "Loading") {
      isRelaxed.value = false;
      isMild.value = false;
      isModerate.value = false;
      isStressed.value = false;
      isOverworked.value = false;
      isScan.value = true;
      isLoad.value = false;
      isResultReady.value = false;
      return;
    } else if (diagnosis == "") {
      isRelaxed.value = false;
      isMild.value = false;
      isModerate.value = false;
      isStressed.value = false;
      isOverworked.value = false;
      isScan.value = false;
      isLoad.value = true;
      isResultReady.value = false;
      return;
    } else if (int.parse(hr_rate.value) <= 100 ||
        (int.parse(syst_rate.value) <= 120 &&
            int.parse(diast_rate.value) <= 80)) {
      isRelaxed.value = true;
      isModerate.value = false;
      isStressed.value = false;
      isOverworked.value = false;
      isLoad.value = false;
      isScan.value = false;
      isResultReady.value = true;
      result.value = "Relaxed";
      return;
    } else if (int.parse(hr_rate.value) >= 100 ||
        (int.parse(syst_rate.value) >= 120 &&
                int.parse(syst_rate.value) <= 129) &&
            int.parse(diast_rate.value) <= 80) {
      isLoad.value = false;
      isScan.value = false;
      isResultReady.value = true;
      isRelaxed.value = false;
      isMild.value = true;
      isModerate.value = false;
      isStressed.value = false;
      isOverworked.value = false;
      result.value = "Mild Stress level";
      return;
    } else if (int.parse(hr_rate.value) >= 100 ||
        (int.parse(syst_rate.value) >= 130 &&
            int.parse(syst_rate.value) <= 139) ||
        (int.parse(diast_rate.value) >= 80 &&
            int.parse(diast_rate.value) <= 89)) {
      isScan.value = false;
      isLoad.value = false;
      isResultReady.value = true;
      isRelaxed.value = false;
      isMild.value = false;
      isModerate.value = true;
      isStressed.value = false;
      isOverworked.value = false;
      result.value = "Moderate Stress level";
      return;
    } else if ((int.parse(syst_rate.value) >= 120 &&
            int.parse(syst_rate.value) >= 139) ||
        (int.parse(diast_rate.value) >= 80 &&
            int.parse(diast_rate.value) <= 89)) {
      isScan.value = false;
      isLoad.value = false;
      isRelaxed.value = false;
      isMild.value = false;
      isResultReady.value = true;
      isModerate.value = false;
      isStressed.value = true;
      isOverworked.value = false;
      result.value = "Stressed";
      return;
    } else if (int.parse(hr_rate.value) >= 70 ||
        (int.parse(syst_rate.value) >= 180 ||
            int.parse(diast_rate.value) >= 120)) {
      isRelaxed.value = false;
      isMild.value = false;
      isResultReady.value = true;
      isModerate.value = false;
      isStressed.value = false;
      isOverworked.value = true;
      isScan.value = false;
      isLoad.value = false;
      result.value = "Overworked";
      return;
    }
  }

  String? resultInfo(String result) {
    if (result == "Relaxed") {
      return "You're looking good and it seems\nthere is nothing stressing you at the\nmoment. Keep it up.";
    } else if (result == "Mild Stress level") {
      return "You seem to be a little stressed\nbut not a big deal. Loosen up!";
    } else if (result == "Moderate") {
      return "Under stress but you should be\nfine. Sometimes stress is good to\ndrive performance.";
    } else if (result == "Stressed") {
      return "Your body is telling you you\n are more stressed. Please take caution.";
    } else if (result == "Overworked") {
      return "Too much stress. If you feel\nvery uncomfortable, please see a doctor immediately.";
    }
  }
}
