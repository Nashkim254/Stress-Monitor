part of 'package:smart_stress/imports.dart';

class StatsChart extends StatelessWidget {
  final List<StatsSeries> data;
  final cont = Get.put(StatsController());
  StatsChart({required this.data});
  @override
  Widget build(BuildContext context) {
    final highestValue =
        data.reduce((curr, next) => curr.result > next.result ? curr : next);
    final smallestValue =
        data.reduce((curr, next) => curr.result < next.result ? curr : next);

    List<charts.Series<StatsSeries, String>> series = [
      charts.Series(
          id: "results",
          data: data,
          domainFn: (StatsSeries series, _) => series.month,
          measureFn: (StatsSeries series, _) => series.result,
          colorFn: (StatsSeries series, _) {
            {
              if (series.result == highestValue.result) {
                return charts.Color.fromHex(code: '#FF0000');
              }
              if (series.result == smallestValue.result) {
                return charts.Color.fromHex(code: '#26BF63');
              }
              return charts.Color.fromHex(code: '#F5D6F4');
            }
          })
    ];
    final yStaticLabels = <charts.TickSpec<int>>[
      // Possible to define style of labels directly inside
      charts.TickSpec(
        0,
        style: charts.TextStyleSpec(
          fontFamily: "Inter",
          // color: charts.ColorUtil.fromDartColor(Colors.greenAccent),
        ),
      ),
      charts.TickSpec(
        1,
        style: charts.TextStyleSpec(
          fontFamily: 'Inter',
          // color: charts.ColorUtil.fromDartColor(Colors.lightGreen),
        ),
      ),
      charts.TickSpec(
        2,
        style: charts.TextStyleSpec(
          fontFamily: 'Inter',
          // color: charts.ColorUtil.fromDartColor(Colors.yellow),
        ),
      ),
      charts.TickSpec(
        3,
        style: charts.TextStyleSpec(
          fontFamily: 'Inter',
          // color: charts.ColorUtil.fromDartColor(primaryTwoColor),
        ),
      ),
      charts.TickSpec(
        4,
        style: charts.TextStyleSpec(
          fontFamily: 'Inter',
          // color: charts.ColorUtil.fromDartColor(primaryTwoColor),
        ),
      ),
      charts.TickSpec(
        5,
        style: charts.TextStyleSpec(
          fontFamily: 'Inter',
          // color: charts.ColorUtil.fromDartColor(primaryTwoColor),
        ),
      ),
    ];
    return SizedBox(
      height: 500,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryTwoColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${cont.todays[0]}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18, color: cardLightColor),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 400,
              child: charts.BarChart(
                series,
                animate: true,
                domainAxis: charts.OrdinalAxisSpec(
                  renderSpec: charts.SmallTickRendererSpec(
                    labelStyle: charts.TextStyleSpec(
                      lineHeight: 3,
                      fontSize: 8,
                      color: charts.Color.fromHex(code: '#000000'),
                    ),
                    lineStyle: const charts.LineStyleSpec(
                      color: charts.Color.transparent,
                    ),
                  ),
                ),
                primaryMeasureAxis: charts.NumericAxisSpec(
                  tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
                    (num? value) {
                      switch (value) {
                        case 0:
                          return "";
                        case 1:
                          return "Overworked";
                        case 2:
                          return "Stressed";
                        case 3:
                          return "Moderate";
                        case 4:
                          return "Mild";
                        case 5:
                          return "Relaxed";
                        default:
                          return "Relaxed";
                      }
                    },
                  ),
                  tickProviderSpec:
                      charts.StaticNumericTickProviderSpec(yStaticLabels),
                  renderSpec: charts.GridlineRendererSpec(
                    labelStyle: charts.TextStyleSpec(
                      fontSize: 12,
                      color: charts.Color.fromHex(code: '#000000'),
                    ),
                    labelAnchor: charts.TickLabelAnchor.after,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
