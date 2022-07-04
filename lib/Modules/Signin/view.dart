part of 'package:smart_stress/imports.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

final controller = Get.put(SigninController());

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
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
                    height: 150,
                    width: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(color: blackColor),
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
                            controller: controller.emailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: theme.textTheme.bodyText2!.copyWith(
                                color: blueColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            return TextFormField(
                              obscureText: controller.isObscure.value,
                              style: TextStyle(color: blackColor),
                              controller: controller.passController,
                              validator: (value) {
                                if (value!.length < 6) {
                                  return "Password cannot be less than 6 characters";
                                } else if (value.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: theme.textTheme.bodyText2!.copyWith(
                                  color: blueColor,
                                  fontSize: 18,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isObscure.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: blueColor,
                                  ),
                                  onPressed: () {
                                    controller.onClicked();
                                  },
                                ),
                              ),
                            );
                          })
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
                      "Remember me",
                      style:
                          theme.textTheme.bodyText2!.copyWith(color: blueColor),
                    ),
                    trailing: TextButton(
                      child: Text(
                        "Forgot password?",
                        style: theme.textTheme.bodyText2!
                            .copyWith(color: blueColor),
                      ),
                      onPressed: () {
                        _showDialog(context, theme);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return CustomButton(
                      label: controller._isLoading.value
                          ? CircularProgressIndicator(
                              color: cardLightColor,
                            )
                          : Text("Log in",
                              style: theme.textTheme.bodyText1!
                                  .copyWith(color: cardLightColor)),
                      onPress: controller._isLoading.value
                          ? () {}
                          : () {
                              if (_formKey.currentState!.validate()) {
                                controller.signinMethod(
                                  SigninModel(
                                      email:
                                          "${controller.emailController.text}",
                                      password:
                                          "${controller.passController.text}"),
                                );
                              }
                            },
                      buttoncolor: blueColor,
                      height: 40,
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    label: Text("Sign Up",
                        style: theme.textTheme.bodyText1!
                            .copyWith(color: blueColor)),
                    onPress: () {
                      Get.to(Signup());
                    },
                    buttoncolor: cardLightColor,
                    height: 40,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, theme) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reset password",
                      style:
                          theme.textTheme.bodyText1!.copyWith(color: blueColor),
                    ),
                    IconButton(
                        onPressed: () => Get.back(), icon: const Icon(Icons.close)),
                  ],
                ),
                TextFormField(
                  controller: controller.emailCont,
                  validator: (value) {
                    return controller.validateEmail(value);
                  },
                  style: TextStyle(color: primaryColor),
                  decoration: InputDecoration(
                    label: Text(
                      "Email",
                      style:
                          theme.textTheme.bodyText1!.copyWith(color: blueColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Obx(() {
                    return CustomButton(
                        label: Text(
                          !controller.isResseting.value
                              ? "Send Reset Link"
                              : "Processing...",
                          style: theme.textTheme.bodyText1!.copyWith(color: cardLightColor),
                        ),
                        onPress: controller.isResseting.value
                            ? () {}
                            : () {
                                controller.resetMethod(ResetModel(
                                    email: controller.emailCont.text));
                                controller.emailCont.clear();
                              },
                        buttoncolor: primaryColor,
                        height: 40);
                  }),
                )
              ],
            ),
          );
        });
  }
}
