part of '../helpers.dart';

//Static Strings
const String appName = "Smart";

//Animation values below
const Duration duration200 = Duration(milliseconds: 200);
const Duration duration400 = Duration(milliseconds: 400);
const Duration duration600 = Duration(milliseconds: 600);
const Duration duration800 = Duration(milliseconds: 800);
const Duration duration1000 = Duration(milliseconds: 1000);
const Duration duration1200 = Duration(milliseconds: 1200);

//Spacing values Below
const double space150 = 150.0;
const double space100 = 100.0;
const double space50 = 50.0;
const double space40 = 40.0;
const double space30 = 30.0;
const double space25 = 25.0;
const double space20 = 20.0;
const double space15 = 15.0;
const double space10 = 10.0;
const double space5 = 5.0;
const double space7 = 7.0;
const double space2 = 2.5;
const double space1 = 1.0;

String globalDeviceId = "";

// Full screen width and height
Future<double> getScreenWidthSize(context) async {
  return MediaQuery.of(context).size.width;
}

// Full screen height
Future<double> getScreenHeightSize(context) async {
  return MediaQuery.of(context).size.height;
}

var countryCode = Get.deviceLocale!.countryCode == "SS" ? '211' : '254';
var code = Get.deviceLocale!.countryCode == "SS" ? '9' : '7';
var codeTwo = Get.deviceLocale!.countryCode == "SS" ? '7' : '1';

/// Valid phone number
String formatPhoneNumber(String number) {
  String phoneNumber = number.replaceAll(" ", "");

  if (phoneNumber.startsWith("+")) phoneNumber = phoneNumber.substring(1);

  if (phoneNumber.startsWith("0"))
    phoneNumber = phoneNumber.replaceFirst("0", "$countryCode");

  if (phoneNumber.startsWith("$code") || phoneNumber.startsWith("$codeTwo"))
    phoneNumber = "$countryCode$phoneNumber";

  return phoneNumber;
}

String? validatorEmpty(String value) {
  if (value.isEmpty) {
    return 'Required field';
  }
  return null;
}

//validate phone number
String? validatePhone(String value) {
  if (value.length < 9 || value.length > 15) {
    return 'Invalid phone number';
  }
  return null;
}

//pn
String? validatePersonalNo(String value) {
  if (value.length < 6 || value.length > 9) {
    return 'Invalid personal number';
  }
  return null;
}

String? validatePassportNo(String value) {
  if (value.length < 6 || value.length > 15) {
    return 'Invalid passport number';
  }
  return null;
}

String initToken() {
  List<int> token = new List<int>.filled(20, 0);
  // List<int> token = new List<int>(20);
  int b = 16;
  for (int a = 0; a < 20; a++) {
    int c = (b ~/ 2);
    token[a] = ((b | ((a + c) >> b)) << 4);
    b++;
  }
  String f = String.fromCharCodes(token);
  return f;
}

String policy = "https://docsunhealth.com/docsun-biomed-ltd-privacy-policy/";
String terms =
    "https://docsunhealth.com/docsun-biomed-ltd-media-services-terms-and-conditions/";
String about = "https://docsunhealth.com/about-us/";
String iosPolicy = "https://docsunhealth.com/ios-stress-app/";
void openWeb(String url) {
  FlutterWebBrowser.openWebPage(
    url: url,
    customTabsOptions: const CustomTabsOptions(
      colorScheme: CustomTabsColorScheme.dark,
      darkColorSchemeParams: CustomTabsColorSchemeParams(
        toolbarColor: Color(0xff00CEA7),
        secondaryToolbarColor: Color(0xff00CEA7),
        navigationBarColor: Color(0xff000000),
      ),
      shareState: CustomTabsShareState.on,
      instantAppsEnabled: true,
      showTitle: true,
      urlBarHidingEnabled: true,
    ),
    safariVCOptions: const SafariViewControllerOptions(
      barCollapsingEnabled: true,
      preferredBarTintColor: Color(0xff00CEA7),
      preferredControlTintColor: Color(0xff000000),
      dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      modalPresentationCapturesStatusBarAppearance: true,
    ),
  );
}

extension BoolParsing on String {
  bool parseBool() {
    if (this.toLowerCase() == 'true') {
      return true;
    } else if (this.toLowerCase() == 'false') {
      return false;
    }

    throw '"$this" can not be parsed to boolean.';
  }
}

TimeOfDay midnight = TimeOfDay(hour: 00, minute: 00);
var now = TimeOfDay.now();
var scansDone = 0.obs;
var scans = 3;

Future resetScans() async {
  final SharedPreferences prefs = await _prefs;
  // var time = prefs.getString("timeOfFirstScan");
  // TimeOfDay _startTime = TimeOfDay(hour:int.parse(time!.split(":")[0]),minute: int.parse(time.split(":")[1]));
  if (now == midnight) {
    prefs.setInt("scansDone", 0);
  } else {
    debugPrint("Not yet midnight");
  }
}
