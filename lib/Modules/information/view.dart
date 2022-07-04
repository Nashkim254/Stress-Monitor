part of 'package:smart_stress/imports.dart';

class Informartion extends StatefulWidget {
  const Informartion({Key? key}) : super(key: key);

  @override
  State<Informartion> createState() => _InformartionState();
}

class _InformartionState extends State<Informartion> {
  List<DataModel> data = items;
  int? _activeMeterIndex;
  final controller = Get.put(InfoController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryTwoColor,
        title: Text("Information",
            style: theme.textTheme.bodyText1!
                .copyWith(fontFamily: "Inter-Bold", color: cardLightColor)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showPopupMenu(context, false, true);
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Container(
        height: size,
        width: double.infinity,
        decoration: BoxDecoration(
          color: shadePrimary,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: cardLightColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18.0, left: 15, bottom: 10),
                            child: Text("Stress levels",
                                style: theme.textTheme.bodyText1!.copyWith(
                                    color: primaryTwoColor,
                                    fontSize: 24,
                                    fontFamily: "Inter-Medium")),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, int i) {
                                return ExpansionPanelList(
                                  dividerColor: primaryTwoColor,
                                  elevation: 3,
                                  // Controlling the expansion behavior
                                  expansionCallback: (index, bool status) {
                                    setState(() {
                                      _activeMeterIndex =
                                          _activeMeterIndex == i ? null : i;
                                    });
                                  },
                                  animationDuration:
                                      const Duration(milliseconds: 600),
                                  children: [
                                    ExpansionPanel(
                                      isExpanded: _activeMeterIndex == i,
                                      headerBuilder: (BuildContext context,
                                              bool isExpanded) =>
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                data[i].title!,
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: primaryTwoColor,
                                                        fontSize: 18),
                                              )),
                                      body: Container(
                                        padding: const EdgeInsets.only(
                                            left: 17.0, bottom: 17),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          data[i].description!,
                                          style: theme.textTheme.bodyText1!
                                              .copyWith(
                                                  color: blackColor,
                                                  fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              itemCount: data.length),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                child: Container(
                  height: 330,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: cardLightColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 18),
                        child: Text(
                          "Legal",
                          style: theme.textTheme.bodyText2!.copyWith(
                              fontSize: 24,
                              color: primaryTwoColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          openWeb(terms);
                        },
                        leading: Image.asset(
                          "assets/images/eye.png",
                          height: 30,
                          width: 30,
                        ),
                        title: Text(
                          "Terms and conditions",
                          style: theme.textTheme.bodyText2!
                              .copyWith(fontSize: 18, color: blackColor),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          openWeb(Platform.isIOS ? iosPolicy : policy);
                        },
                        leading: Image.asset(
                          "assets/images/privacy.png",
                          height: 30,
                          width: 30,
                        ),
                        title: Text(
                          "Privacy Policy",
                          style: theme.textTheme.bodyText2!
                              .copyWith(fontSize: 18, color: blackColor),
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          EmailContent email = EmailContent(
                            to: [
                              'support.app@docsunhealth.com',
                            ],
                          );
                          OpenMailAppResult result =
                              await OpenMailApp.composeNewEmailInMailApp(
                                  nativePickerTitle:
                                      'Select email app to compose',
                                  emailContent: email);
                          debugPrint(result.toString());
                          if (!result.didOpen && !result.canOpen) {
                            showNoMailAppsDialog(context, theme);
                          } else if (!result.didOpen && result.canOpen) {
                            showDialog(
                              context: context,
                              builder: (_) => MailAppPickerDialog(
                                mailApps: result.options,
                                emailContent: email,
                              ),
                            );
                          }
                        },
                        leading: Image.asset(
                          "assets/images/feed.png",
                          height: 30,
                          width: 30,
                        ),
                        title: Text(
                          "Help/ Feedback",
                          style: theme.textTheme.bodyText2!
                              .copyWith(fontSize: 18, color: blackColor),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Share.share(
                              "Discover this new way of monitoring your  stress level. Download it at. https://docsunhealth.com/dailystm");
                        },
                        leading: Image.asset(
                          "assets/images/friend.png",
                          height: 30,
                          width: 30,
                        ),
                        title: Text(
                          "Tell a  friend",
                          style: theme.textTheme.bodyText2!
                              .copyWith(fontSize: 18, color: blackColor),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          openWeb(about);
                        },
                        leading: Image.asset(
                          "assets/images/info.png",
                          height: 30,
                          width: 30,
                        ),
                        title: Text(
                          "About",
                          style: theme.textTheme.bodyText2!
                              .copyWith(fontSize: 18, color: blackColor),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 18.0, bottom: 20, left: 20, right: 20),
                child: Text.rich(
                  TextSpan(
                      text: "Disclaimer: ",
                      style: theme.textTheme.bodyText2!
                          .copyWith(fontSize: 20, color: primaryTwoColor),
                      children: [
                        TextSpan(
                          text:
                              "For personal use only not for medical use.\nVersion:    1.0.12",
                          style: theme.textTheme.bodyText2!
                              .copyWith(fontSize: 18, color: blackColor),
                        )
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        color: primaryTwoColor,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Daily+ Stress Monitor",
              style: theme.textTheme.bodyText1!
                  .copyWith(fontSize: 14, color: cardLightColor),
            ),
            Text(
              "\u00a9 Copyright ${DateTime.now().year} | DOCSUN BioMed Ltd.",
              style: theme.textTheme.bodyText1!
                  .copyWith(fontSize: 14, color: cardLightColor),
            ),
            Text(
              "All rights reserved",
              style: theme.textTheme.bodyText1!
                  .copyWith(fontSize: 14, color: cardLightColor),
            )
          ],
        ),
      ),
    );
  }

  void showNoMailAppsDialog(BuildContext context, theme) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Open Mail App",
            style: theme.textTheme.bodyText2!.copyWith(
                fontSize: 16.0, color: blackColor, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "No mail apps installed",
            style: theme.textTheme.bodyText2!.copyWith(
                fontSize: 14.0, color: blackColor, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
