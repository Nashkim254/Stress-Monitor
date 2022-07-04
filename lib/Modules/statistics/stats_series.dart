part of 'package:smart_stress/imports.dart';

class StatsSeries {
  final String month;
  final int result;
  final charts.Color barColor;

  StatsSeries(
    {
      required this.month,
      required this.result,
      required this.barColor
    }
  );
}