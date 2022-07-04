part of 'package:smart_stress/imports.dart';

class Nonsubscriber extends StatefulWidget {
  @override
  _NonsubscriberState createState() => _NonsubscriberState();
}

class _NonsubscriberState extends State<Nonsubscriber> {
  // Widget? dialog;
  final controller = Get.put(NonsubscriberController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryTwoColor,
        centerTitle: true,
        title: Text(
          "Press Next Button to Check",
          style: theme.textTheme.bodyText1!
              .copyWith(color: cardLightColor, fontFamily: "Inter-Bold"),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showPopupMenu(context, true, true);
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: blackColor.withOpacity(0.9),
          ),
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16),
                    child: Text(
                        "• Stabilize your phone and measure under\n   ambient lighting.",
                        style: theme.textTheme.bodyText1!.copyWith(
                            color: cardLightColor,
                            fontSize: 15,
                            fontFamily: "Inter-Regular")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16),
                    child: Text(
                        "• Remove facial accessories and keep whole\n   face visible to the selfie camera.",
                        style: theme.textTheme.bodyText1!.copyWith(
                            color: cardLightColor,
                            fontSize: 15,
                            fontFamily: "Inter-Regular")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16),
                    child: Text(
                        "• Position face until the green frame  is\n   steadily shown and please stay still.",
                        style: theme.textTheme.bodyText1!.copyWith(
                            color: cardLightColor,
                            fontSize: 15,
                            fontFamily: "Inter-Regular")),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 30,
            child: GestureDetector(
                onTap: () async {
                  controller.checkRemainingScans();
                },
                child: Image.asset(
                  "assets/images/next.png",
                  height: 100,
                  width: 100,
                )),
          )
        ],
      ),
    );
  }
}
