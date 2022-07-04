
import 'package:smart_stress/Database/Services/logs.dart';
import 'package:dio/dio.dart';


class Apis {

  //App production
  static bool appProduction = false;

  //staging server url
  static String stagingBaseUrl = "https://diagnostic-api-test.bostonresearch.ai/api";

  //live server url
  static String liveBaseUrl = "https://diagnostic-api-test.bostonresearch.ai/api/wellness";

  static String baseUrl = "";
  static String base = "https://diagnostic-api-test.bostonresearch.ai/api/v2";
  static String liveServer = "https://api.docsun.health/api/";

  static int connectTimeout = 80*1000;
  static int receiveTimeout = 80*1000;

  static String sentryDns = "";

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: Apis.baseUrl,
      connectTimeout: Apis.connectTimeout,
      receiveTimeout: Apis.receiveTimeout,
    ),
  )..interceptors.add(Logs());

}
