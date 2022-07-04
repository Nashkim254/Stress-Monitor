part of 'package:smart_stress/imports.dart';

class SigninController extends GetxController {
  var _isLoading = false.obs;
  var isResseting = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var isChecked = false.obs;
  var isObscure = true.obs;
  var isSubscribed = false.obs;
  String userId = '';
  String platformId = "";
  String email = "";
  String uploadLimit = "";

  Future<void> signinMethod(SigninModel signUpRequestModel) async {
    final SharedPreferences prefs = await _prefs;
    _isLoading(true);
    ResponseModel response = await signin(signUpRequestModel);
    _isLoading(false);
    if (response.code == 201) {
      response.data['result']['subscription'] != null
          ? prefs.setBool("isSubscribed", isSubscribed(true))
          : prefs.setBool("isSubscribed", isSubscribed(false));
      prefs.setString("token", response.data['result']['accessToken']);
      prefs.setString("userId", "${response.data['result']['id']}");
      prefs.setString("platformId", "${response.data['result']['platformId']}");
      prefs.setString(
          "uploadLimit", "${response.data['result']['uploadLimit']}");
      prefs.setString("email", response.data['result']['email']);
      print(response.data['result']['accessToken']);
      _isLoading(false);
      emailController.clear();
      passController.clear();
      if (response.data['result']['subscription'] == null) {
        Get.dialog(ConfirmDialog(
           color: errorColor,
          message: "Kindly subscribe to check and access other features",
          onPressed: () => Get.back(),
        ));
        Get.off(Subscription());
      } else {
        Get.off(CalendarView());
      }
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

  void onClicked() {
    if (isObscure.value) {
      isObscure.value = false;
    } else {
      isObscure.value = true;
    }
  }

  void onChanged(value) {
    if (isChecked.value) {
      isChecked.value = false;
    } else {
      isChecked.value = true;
    }
  }

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return null;
  }

  String? validatePass(String? value) {
    if (value!.length < 6) {
      return "Password cannot be less than 6 characters";
    } else if (value.isEmpty) {
      return "Password cannot be empty";
    }
    return null;
  }

  BuildContext? context = Get.context;
  Future<void> resetMethod(ResetModel signUpRequestModel) async {
    isResseting(true);
    ResponseModel response = await reset(signUpRequestModel);
    isResseting(false);
    if (response.code == 201) {
      isResseting(false);
      Navigator.pop(context!);
    } else if (response.code == 422) {
      Navigator.pop(context!);
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
      isResseting(false);
    }
    update();
  }
}
