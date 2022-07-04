part of 'package:smart_stress/imports.dart';

class StatsView extends StatelessWidget {
  StatsView({Key? key}) : super(key: key);
  final controller = Get.put(StatsController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    List<StatsSeries> data = List.generate(
      Get.arguments.length,
      (index) => StatsSeries(
          barColor: charts.ColorUtil.fromDartColor(primaryTwoColor),
          month: "${Get.arguments[index]['date'].split(" ")[1]}",
          result: 5),
    );

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: primaryTwoColor,
          centerTitle: true,
          title: Text(controller.isDay.value
              ? "Daily Statistics"
              : "Weekly Statistics"),
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
            Container(color: shadePrimary),
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryTwoColor, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.isDay.toggle();
                        },
                        child: Container(
                          color:
                              controller.isDay.value ? primaryTwoColor : null,
                          child: Center(
                            child: Text(
                              "Day",
                              style: theme.textTheme.bodyText1!.copyWith(
                                  color: controller.isDay.value
                                      ? cardLightColor
                                      : primaryTwoColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.isDay.toggle();
                        },
                        child: Container(
                          color: controller.isDay.value == false
                              ? primaryTwoColor
                              : null,
                          child: Center(
                            child: Text(
                              "Week",
                              style: theme.textTheme.bodyText1!.copyWith(
                                  color: controller.isDay.value == false
                                      ? cardLightColor
                                      : primaryTwoColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: 20,
              right: 20,
              child: !controller.added.value &&
                      controller._isLoading.value == true && data == null
                  ? Center(
                      child: CircularProgressIndicator(
                      color: primaryTwoColor,
                    ))
                  : StatsChart(data: data),
            ),
            Positioned(
              left: 0,
              bottom: 20,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // controller.checkRemainingScans();
                  Get.to(Nonsubscriber());
                },
                child: Image.asset(
                  "assets/images/scan.png",
                  height: 80,
                  width: 80,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
