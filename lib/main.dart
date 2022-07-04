import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_stress/Shared/Utils/helpers.dart';
import 'package:smart_stress/imports.dart';
import 'package:permission_handler/permission_handler.dart';

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     switch (task) {
//       case "renewScansTask":
//         printSuccess("Running resetScans background sync...");

//         try {
//           await resetScans();
//         } on Exception catch (e) {
//           printError(e);
//         }
//         break;
//     }
//     // print("Native called background task: $backgroundTask"); //simpleTask will be emitted here.
//     return Future.value(true);
//   });
// }

Future<void> main() async {
  // Flutter Widgets.
  final settingsController = ThemeSettingsController(SettingsService());
  WidgetsFlutterBinding.ensureInitialized();
// You can request multiple permissions at once.
  await Permission.camera.request();
  await Permission.microphone.request(); //
  // Workmanager().initialize(
  //     callbackDispatcher, // The top level function, aka callbackDispatcher
  //     isInDebugMode:
  //         false // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  //     );

  // Workmanager().registerPeriodicTask("renewScans", "renewScansTask",
  //     frequency: Duration(minutes: 1));
  // await initService();
  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();
  runApp(MyApp(settingsController: settingsController));
}
// Future initService() async {
//   printInfo("Starting services");

//   await Get.putAsync<MidnightService>(
//       () async => await MidnightService().resetScans());

//   printSuccess("All services started");
// }
class MyApp extends StatefulWidget {
  MyApp({
    required this.settingsController,
    Key? key,
  }) : super(key: key);
  final ThemeSettingsController settingsController;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: themeDataLight(context),
      darkTheme: themeDataDark(context),
      themeMode: widget.settingsController.themeMode,
      home: SplashScreenView(),
    );
  }
}
