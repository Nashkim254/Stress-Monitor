part of 'package:smart_stress/imports.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final controller = Get.put(SignupController());

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: blueShade300.withOpacity(0.3),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size,
              color: blueShade300.withOpacity(0.3),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/docsun.png",
                    height: 50,
                    width: 150,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Form(
                      key: _key,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.length < 0) {
                                return "Value cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: blackColor),
                            controller: controller.fnameController,
                            decoration: InputDecoration(
                              hintText: "First Name",
                              hintStyle: theme.textTheme.bodyText2!.copyWith(
                                color: blueColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.length < 0) {
                                return "Value cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: blackColor),
                            controller: controller.lnameController,
                            decoration: InputDecoration(
                              hintText: "Last Name",
                              hintStyle: theme.textTheme.bodyText2!.copyWith(
                                color: blueColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (value) {
                              String pattern =
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                  r"{0,253}[a-zA-Z0-9])?)*$";
                              RegExp regex = RegExp(pattern);
                              if (value == null ||
                                  value.isEmpty ||
                                  !regex.hasMatch(value))
                                return 'Enter a valid email address';
                              else
                                return null;
                            },
                            style: TextStyle(color: blackColor),
                            controller: controller.emailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: theme.textTheme.bodyText2!.copyWith(
                                color: blueColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            return TextFormField(
                              obscureText: controller.isObscureTwo.value,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password cannot be less than 6 characters";
                                } else if (controller.passController.text !=
                                    controller.confirmPassController.text) {
                                  return "Password do not match";
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(color: blackColor),
                              controller: controller.passController,
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: theme.textTheme.bodyText2!.copyWith(
                                  color: blueColor,
                                  fontSize: 18,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isObscureTwo.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: primaryColor,
                                  ),
                                  onPressed: () {
                                    controller.onClickedOne();
                                  },
                                ),
                              ),
                            );
                          }),
                          SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            return TextFormField(
                              obscureText: controller.isObscure.value,
                              validator: (value) {
                                return controller.validatePassword(value);
                              },
                              style: TextStyle(color: blackColor),
                              controller: controller.confirmPassController,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                hintStyle: theme.textTheme.bodyText2!.copyWith(
                                  color: blueColor,
                                  fontSize: 18,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isObscure.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: primaryColor,
                                  ),
                                  onPressed: () {
                                    controller.onClicked();
                                  },
                                ),
                              ),
                            );
                          }),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Obx(() {
                      return Checkbox(
                          value: controller.isChecked.value,
                          onChanged: (value) {
                            controller.onChanged(value);
                          });
                    }),
                    title: Text(
                      "Please contact me via email",
                      style:
                          theme.textTheme.bodyText2!.copyWith(color: blueColor),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Text.rich(TextSpan(
                          text:
                              'By clicking Sign up, I agree that I have read and accepted\n the',
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Terms of Use",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => openWeb(terms)),
                            TextSpan(text: " and"),
                            TextSpan(
                                text: " Privacy Policy",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = (() => openWeb(policy))),
                          ]))),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return CustomButton(
                      label: controller._isLoading.value
                          ? CircularProgressIndicator(
                              color: blueColor,
                            )
                          : Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: blueColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                      onPress: controller._isLoading.value
                          ? () {}
                          : () {
                              if (_key.currentState!.validate()) {
                                controller.signUpMethod(RegisterModel(
                                    name:
                                        "${controller.fnameController.text} ${controller.lnameController.text}",
                                    email: "${controller.emailController.text}",
                                    password:
                                        "${controller.passController.text}"));
                              }
                            },
                      buttoncolor: cardLightColor,
                      height: 40,
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    label: Text(
                      "Log in",
                      style: TextStyle(
                          color: cardLightColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    onPress: () {
                      Get.to(Signin());
                    },
                    buttoncolor: blueColor,
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
