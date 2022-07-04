part of 'package:smart_stress/imports.dart';

class MidnightService extends GetxService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TimeOfDay midnight = TimeOfDay(hour: 00, minute: 00);
  var now = TimeOfDay.now();
  var scansDone = 0.obs;
  var scans = 3;

Future  resetScans() async {
    final SharedPreferences prefs = await _prefs;
    if (now == midnight) {
      prefs.setInt("scansDone", 0);
    }
    return;
  }
}
