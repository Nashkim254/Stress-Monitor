part of 'package:smart_stress/imports.dart';

class Webview extends StatefulWidget {
  const Webview({Key? key}) : super(key: key);

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  final _controller = Get.put(NonsubscriberController());
  double progress = 0;

  Future askPermission() async {
    await [
      Permission.camera,
      Permission.microphone,
    ].request();
  }

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));
  final String start_scan = """
 document.getElementById("real_scan").click();
""";
  final String stop_scan = """
  document.getElementById("stop");
""";
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    askPermission();

    return Obx(() {
      return Scaffold(
          backgroundColor: blackColor.withOpacity(0.9),
          appBar: AppBar(
            backgroundColor: primaryTwoColor,
            centerTitle: true,
            title: Text(_controller.isScanning.value
                ? "Checking"
                : _controller.isResultReady.value == true
                    ? "Results"
                    : "Press Start Button to Check"),
            actions: [
              _controller.isResultReady.value == true
                  ? IconButton(
                      onPressed: () {
                        Share.share(_controller.result.value);
                      },
                      icon: Icon(Icons.share))
                  : SizedBox()
            ],
          ),
          body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      'https://docsun-android-ai-library.netlify.app/index3.html'),
                ),
                onWebViewCreated: (controller) {
                  webViewController = controller;
                  controller.addJavaScriptHandler(
                      handlerName: 'dataHandler',
                      callback: (args) async {
                        // printSuccess(args);
                        var data = "${args[0]}".split('-');
                        _controller.isScanning.value = data[1].parseBool();
                        _controller.isLoading.value = data[0].parseBool();
                        _controller.video_loaded.value = data[0].parseBool();
                        _controller.scanning.value = data[1].parseBool();
                        _controller.spo2_rate.value = data[2];
                        _controller.bs_rate.value = data[3];
                        _controller.syst_rate.value = data[4];
                        _controller.diast_rate.value = data[5];
                        _controller.br_rate.value = data[6];
                        _controller.hr_rate.value = data[7];
                        _controller.diagnosis.value = data[8];

                        // it will print:
                        // _controller.isDiagnosed();
                        _controller.stressLevels();
                        if (_controller.isResultReady.value == true) {
                          await webViewController?.callAsyncJavaScript(
                            functionBody: stop_scan,
                          );
                          var mapData = {
                            "spo2_range": _controller.spo2_rate,
                            "blood_pressure_code":
                                "${int.parse(_controller.syst_rate.value) <= 90 || int.parse(_controller.syst_rate.value) >= 180 || int.parse(_controller.diast_rate.value) <= 60 || int.parse(_controller.diast_rate.value) >= 120 ? 'bp_abnormal' : 'bp_normal'}",
                            "blood_pressure_range": _controller.bs_rate,
                            "blood_sugar_code":
                                "${int.parse(_controller.bs_rate.value) <= 4 || int.parse(_controller.bs_rate.value) >= 20 ? 'bs_abnormal' : 'bs_normal'}",
                            "blood_sugar_range":
                                "${int.parse(_controller.syst_rate.value) / int.parse(_controller.diast_rate.value)}",
                            "diagnosis": _controller.diagnosis == 'Healthy'
                                ? 'diag_normal'
                                : 'diag_infected',
                            "eye_coloration": "eyc_normal",
                            "heart_rate":
                                "${int.parse(_controller.hr_rate.value) <= 42 ? 'pr_low' : int.parse(_controller.hr_rate.value) >= 180 ? 'pr_high' : 'pr_normal'}",
                            "heart_rate_range": _controller.hr_rate,
                            "respiration_rate":
                                "${int.parse(_controller.br_rate.value) <= 5 ? 'br_low' : int.parse(_controller.bs_rate.value) >= 50 ? 'br_high' : 'br_normal'}",
                            "respiration_rate_range": _controller.br_rate,
                            "spo2": "spo2_normal",
                            "temperature": "37",
                          };

                          if (_controller.isLoggedin.value) {
                            await _controller.diagnosisMethod(
                                DiagnosisModel(
                                    spo2_range: "${mapData['spo2_range']}",
                                    blood_pressure_code:
                                        "${mapData['blood_pressure_code']}",
                                    blood_pressure_range:
                                        "${mapData['blood_pressure_range']}",
                                    blood_sugar_code:
                                        "${mapData['blood_sugar_code']}",
                                    blood_sugar_range:
                                        "${mapData['blood_sugar_range']}",
                                    diagnosis: "${mapData['diagnosis']}",
                                    eye_coloration:
                                        "${mapData['eye_coloration']}",
                                    heart_rate: "${mapData['heart_rate']}",
                                    heart_rate_range:
                                        "${mapData['heart_rate_range']}",
                                    respiration_rate:
                                        "${mapData['respiration_rate']}",
                                    respiration_rate_range:
                                        "${mapData['respiration_rate_range']}",
                                    spo2: "${mapData['spo2']}",
                                    temperature: "${mapData['temperature']}"),
                                _controller.token.value);
                          }
                        }
                      });
                      //TODO:stop scan
                },
                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                onConsoleMessage: (controller, consoleMessage) {},
                initialOptions: options,
              ),
              Positioned(
                  top: 20,
                  left: 20,
                  right: 20,
                  child: _controller.isLoad.value
                      ? Image.asset("assets/images/loading.png")
                      : _controller.isRelaxed.value
                          ? Image.asset(
                              "assets/images/relaxed.png",
                            )
                          : _controller.isModerate.value
                              ? Image.asset(
                                  "assets/images/moderate.png",
                                )
                              : _controller.isOverworked.value
                                  ? Image.asset(
                                      "assets/images/overworked.png",
                                    )
                                  : _controller.isMild.value
                                      ? Image.asset(
                                          "assets/images/mild.png",
                                        )
                                      : _controller.isStressed.value
                                          ? Image.asset(
                                              "assets/images/stressed.png",
                                            )
                                          : _controller.isScan.value
                                              ? Image.asset(
                                                  "assets/images/loading.png",
                                                )
                                              : Image.asset(
                                                  "assets/images/stresslevels.png",
                                                )),
              _controller.isResultReady.value == true
                  ? Positioned(
                      top: 180,
                      left: 20,
                      right: 20,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                            child: Text(
                          _controller.resultInfo(_controller.result.value)!,
                          style: theme.textTheme.bodyText1!.copyWith(
                            color: cardLightColor,
                            fontSize: 16,
                          ),
                        )),
                      ),
                    )
                  : Positioned(
                      bottom: 80,
                      left: 20,
                      right: 20,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Disclaimer: Daily+ Stress Monitor is\nfor personal monitoring purposes only\nnot for medical use",
                            style: theme.textTheme.bodyText1!.copyWith(
                              color: cardLightColor,
                              fontSize: 16,
                            ),
                          ),
                        )),
                      ),
                    ),
              _controller.video_loaded.value == false
                  ? Positioned(
                      top: MediaQuery.of(context).size.height / 4,
                      left: 0,
                      right: 0,
                      child: Image.asset("assets/images/loading.gif"),
                    )
                  : const SizedBox(),
              _controller.video_loaded.value == true
                  ? Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: GestureDetector(
                        onTap: () async {
                          var result =
                              await webViewController?.callAsyncJavaScript(
                            functionBody: start_scan,
                          );
                          debugPrint(result.toString());
                        },
                        child: Image.asset(
                          "assets/images/scan.png",
                          height: 50,
                          width: 50,
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ));
    });
  }
}
