part of 'package:smart_stress/imports.dart';

class DataModel {
  String? title;
  String? description;
  DataModel({required this.title, required this.description});
}


List<DataModel> items = [
  DataModel(
      title: "Relaxed",
      description:
          "You're looking good and it seems\nthere is nothing stressing you at the\nmoment. Keep it up."),
  DataModel(
      title: "Mild",
      description:
          "You seem to be a little stressed\nbut not a big deal. Loosen up!"),
  DataModel(
      title: "Moderate",
      description:
          "Under stress but you should be\nfine. Sometimes stress is good to\ndrive performance."),
  DataModel(
      title: "Stressed",
      description:
          "Your body is telling you you\n are more stressed. Please take caution."),
  DataModel(
      title: "Overworked",
      description:
          "Too much stress. If you feel\nvery uncomfortable, please see a doctor immediately.")
];
