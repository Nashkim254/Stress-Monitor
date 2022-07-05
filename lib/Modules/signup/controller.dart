part of 'package:smart_stress/imports.dart';

class SignupController extends GetxController {
  var _isLoading = false.obs;
  var isChecked = false.obs;
  var isObscure = true.obs;
  var isObscureTwo = true.obs;
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  TextEditingController confirmPassController = TextEditingController();
  Future<void> signUpMethod(RegisterModel signUpRequestModel) async {
    _isLoading(true);
    ResponseModel response = await signUp(signUpRequestModel);
    _isLoading(false);
    if (response.code == 201) {
      _isLoading(false);
      fnameController.clear();
      lnameController.clear();
      emailController.clear();
      passController.clear();
      Get.off(() => Subscription());
    } else if (response.code == 422) {
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

  void onClickedOne() {
    if (isObscureTwo.value) {
      isObscureTwo.value = false;
    } else {
      isObscureTwo.value = true;
    }
  }

  void onChanged(value) {
    if (isChecked.value) {
      isChecked.value = false;
    } else {
      isChecked.value = true;
    }
  }

  String? validate(String value) {
    if (value.length < 0) {
      return "Value cannot be empty";
    } else {
      return null;
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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be less than 6 characters";
    } else if (passController.text != confirmPassController.text) {
      return "Password do not match";
    } else {
      return null;
    }
  }
}
