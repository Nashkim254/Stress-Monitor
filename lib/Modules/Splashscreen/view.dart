part of 'package:smart_stress/imports.dart';

class SplashScreenView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenView();
  }
}

class _SplashScreenView extends State<SplashScreenView> {
  final controller = Get.put(SplashScreenController());

  @override
  void initState() {
    super.initState();
    controller._loadWidget();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xff000000).withOpacity(0.2)));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: shadePrimary),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: SizedBox(
                height: 150,
                width: 150,
                child: Image.asset('assets/images/splash.png')),
            ),
          ],
        )),
      ),
    );
  }
}
