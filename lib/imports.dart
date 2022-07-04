//System Imports
import 'dart:async';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_stress/Database/Models/calendar_model.dart';
import 'package:smart_stress/Database/Models/diagnosis_model.dart';
import 'package:smart_stress/Database/Models/metric_history_model.dart';
import 'package:smart_stress/Database/Models/register_model.dart';
import 'package:smart_stress/Database/Models/reset_password_model.dart';
import 'package:smart_stress/Database/Models/response_model.dart';
import 'package:smart_stress/Database/Models/signin_model.dart';
import 'package:smart_stress/Database/Models/subscription_model.dart';
import 'package:smart_stress/Database/Services/requests.dart';
import 'package:intl/intl.dart';
import 'package:smart_stress/Shared/Utils/helpers.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
/// MODEL CLASSES

//App Configs Import

//Settings
part 'package:smart_stress/Shared/settings/settings_controller.dart';
part 'package:smart_stress/Shared/settings/settings_service.dart';
//Accounts
part 'package:smart_stress/Modules/Subscriber/controller.dart';


//splashScreen
part 'package:smart_stress/Modules/Splashscreen/controller.dart';
part 'package:smart_stress/Modules/Splashscreen/view.dart';
//subscription
part 'package:smart_stress/Modules/Subscription/controller.dart';
part 'package:smart_stress/Modules/Subscription/view.dart';
part 'package:smart_stress/Modules/Subscription/consumable_store.dart';
//sign up
part 'package:smart_stress/Modules/signup/controller.dart';
part 'package:smart_stress/Modules/signup/view.dart';

//sign in
part 'package:smart_stress/Modules/Signin/controller.dart';
part 'package:smart_stress/Modules/Signin/view.dart';

//non sub
part 'package:smart_stress/Modules/Nonsubscriber/controller.dart';
part 'package:smart_stress/Modules/Nonsubscriber/view.dart';
part 'package:smart_stress/Modules/Nonsubscriber/webview.dart';
part 'package:smart_stress/Modules/Nonsubscriber/midnightreset.dart';
//info
part 'package:smart_stress/Modules/information/controller.dart';
part 'package:smart_stress/Modules/information/view.dart';
part 'package:smart_stress/Modules/information/data_model.dart';

//stats
part 'package:smart_stress/Modules/statistics/controller.dart';
part 'package:smart_stress/Modules/statistics/view.dart';



part 'package:smart_stress/Modules/statistics/bar_chart.dart';
part 'package:smart_stress/Modules/statistics/stats_series.dart';
part 'package:smart_stress/Modules/Subscriber/calendar_view.dart';
part 'package:smart_stress/Modules/Subscriber/methods_class.dart';