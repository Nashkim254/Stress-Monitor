//SignUp
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_stress/Database/Models/diagnosis_model.dart';
import 'package:smart_stress/Database/Models/register_model.dart';
import 'package:smart_stress/Database/Models/reset_password_model.dart';
import 'package:smart_stress/Database/Models/response_model.dart';
import 'package:smart_stress/Database/Models/signin_model.dart';
import 'package:smart_stress/Database/Models/subscription_model.dart';
import 'package:smart_stress/Shared/Utils/Apis/apis.dart';
import 'package:smart_stress/Shared/Utils/helpers.dart';

FormData convertFormData(body) {
  return FormData.fromMap(body);
}

Future<ResponseModel> signUp(RegisterModel modelData) async {
  Map? data;
  int? code;
  try {
    Response response = await Apis.dio.post(
      Apis.liveBaseUrl + '/user/register',
      data: convertFormData(modelData.toJson()),
    );
    data = response.data;
    code = response.statusCode;
  } on DioError catch (e) {
    // MyException exection = MyException();
    if (e.type == DioErrorType.response) {
      data = e.response!.data;
      code = e.response!.statusCode;
    }
    if (e.type == DioErrorType.connectTimeout) {
      debugPrint('check your connection!');
    }

    if (e.type == DioErrorType.receiveTimeout) {
      debugPrint('check your connection!');
    }

    if (e.type == DioErrorType.other) {}
  }
  return ResponseModel(data: data, code: code!);
}

//signin
Future<ResponseModel> signin(SigninModel modelData) async {
  Map? data;
  int? code;
  try {
    Response response = await Apis.dio.post(
      Apis.liveBaseUrl + '/user/login',
      data: convertFormData(modelData.toJson()),
    );
    data = response.data;
    code = response.statusCode;
  } on DioError catch (e) {
    // MyException exection = MyException();
    if (e.type == DioErrorType.response) {
      data = e.response!.data;
      code = e.response!.statusCode;
    }
    if (e.type == DioErrorType.connectTimeout) {
      debugPrint("Check your connection");
    }

    if (e.type == DioErrorType.receiveTimeout) {
      debugPrint("Check your connection");
    }

    if (e.type == DioErrorType.other) {
      debugPrint("Error");
    }
  }
  return ResponseModel(data: data, code: code!);
}

//metric history
Future<ResponseModel> getmetric(modelData, String token) async {
  Map? data;
  int? code;
  try {
    Response response = await Apis.dio.get(
      Apis.base + '/diagnosis/get-by-date',
      options: Options(headers: {"authorization": "Bearer $token"}),
      queryParameters: modelData.toJson(),
    );
    // queryParameters: {
    //   'start_date': '$start_date',
    //   'end_date': '$end_date'
    // });

    data = response.data;
    code = response.statusCode;
  } on DioError catch (e) {
    // MyException exection = MyException();
    if (e.type == DioErrorType.response) {
      data = e.response!.data;
      code = e.response!.statusCode;
    }
    if (e.type == DioErrorType.connectTimeout) {
      debugPrint('check your connection!');
    }

    if (e.type == DioErrorType.receiveTimeout) {
      debugPrint('check your connection!');
    }

    if (e.type == DioErrorType.other) {}
  }
  return ResponseModel(data: data, code: code!);
}

// /api/portal/auth/reset

//reset password
Future<ResponseModel> reset(ResetModel modelData) async {
  Map? data;
  int? code;
  try {
    Response response = await Apis.dio.post(
      Apis.liveBaseUrl + '/user/reset',
      data: convertFormData(modelData.toJson()),
    );
    data = response.data;
    code = response.statusCode;
  } on DioError catch (e) {
    // MyException exection = MyException();
    if (e.type == DioErrorType.response) {
      data = e.response!.data;
      code = e.response!.statusCode;
    }
    if (e.type == DioErrorType.connectTimeout) {
      debugPrint('check your connection!');
    }

    if (e.type == DioErrorType.receiveTimeout) {
      debugPrint('check your connection!');
    }

    if (e.type == DioErrorType.other) {}
  }
  return ResponseModel(data: data, code: code!);
}

//reset password
Future<ResponseModel> postDiagnosis(
    DiagnosisModel mapData, String token) async {
  Map? data;
  int? code;
  try {
    Response response = await Apis.dio.post(
      Apis.liveBaseUrl + '/user/create-diagnosis',
      options: Options(headers: {"authorization": "Bearer $token"}),
      data: convertFormData(mapData.toJson()),
    );

    data = response.data;
    code = response.statusCode;
  } on DioError catch (e) {
    // MyException exection = MyException();
    if (e.type == DioErrorType.response) {
      data = e.response!.data;
      code = e.response!.statusCode;
    }
    if (e.type == DioErrorType.connectTimeout) {
      debugPrint('check your connection!');
    }

    if (e.type == DioErrorType.receiveTimeout) {
      debugPrint('check your connection!');
    }

    if (e.type == DioErrorType.other) {}
  }
  return ResponseModel(data: data, code: code!);
}

//post subscription
Future<ResponseModel> postSubscription(
    SubscribeModel mapData, String token) async {
  Map? data;
  int? code;
  try {
    Response response = await Apis.dio.post(
        Apis.liveBaseUrl + '/user/subscriptions',
        options: Options(headers: {"authorization": "Bearer $token"}),
        data: convertFormData(mapData.toJson()));
    data = response.data;
    code = response.statusCode;
  } on DioError catch (e) {
    // MyException exection = MyException();
    if (e.type == DioErrorType.response) {
      data = e.response!.data;
      code = e.response!.statusCode;
    }
    if (e.type == DioErrorType.connectTimeout) {
      debugPrint('check your connection!');
    }

    if (e.type == DioErrorType.receiveTimeout) {
      debugPrint('check your connection!');
    }

    if (e.type == DioErrorType.other) {}
  }
  return ResponseModel(data: data, code: code!);
}

//all history
Future<ResponseModel> getAllHistory(String token) async {
  Map? data;
  int? code;
  try {
    Response response = await Apis.dio.get(
      Apis.base + '/diagnosis/all',
      options: Options(headers: {"authorization": "Bearer $token"}),
    );

    data = response.data;
    code = response.statusCode;
  } on DioError catch (e) {
    // MyException exection = MyException();
    if (e.type == DioErrorType.response) {
      data = e.response!.data;
      code = e.response!.statusCode;
    }
    if (e.type == DioErrorType.connectTimeout) {
      debugPrint('check your connection!');
    }

    if (e.type == DioErrorType.receiveTimeout) {
      debugPrint('check your connection!');
    }

    if (e.type == DioErrorType.other) {}
  }
  return ResponseModel(data: data, code: code!);
}

//Get subscription
Future<ResponseModel> getSubscription(String user_id, String token) async {
  Map? data;
  int? code;
  try {
    Response response = await Apis.dio.get(
        Apis.liveBaseUrl + '/user/subscriptions',
        options: Options(headers: {"authorization": "Bearer $token"}),
        queryParameters: {"user_id": "$user_id", "status": "Active"});
    data = response.data;
    code = response.statusCode;
  } on DioError catch (e) {
    // MyException exection = MyException();
    if (e.type == DioErrorType.response) {
      data = e.response!.data;
      code = e.response!.statusCode;
    }
    if (e.type == DioErrorType.connectTimeout) {
      debugPrint('check your connection!');
    }

    if (e.type == DioErrorType.receiveTimeout) {
      debugPrint('check your connection!');
    }

    if (e.type == DioErrorType.other) {}
  }
  return ResponseModel(data: data, code: code!);
}
