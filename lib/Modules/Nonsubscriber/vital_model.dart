class Vitals {
  String spo2_range;
  String spo2;
  String blood_sugar_range;
  String blood_sugar_code;
  String blood_pressure_range;
  String blood_pressure_code;
  String respiration_rate_range;
  String respiration_rate;
  String heart_rate_range;//
  String heart_rate;//
  String eye_coloration;//
  String temperature;//
  String diagnosis;//
  Vitals(
      {required this.spo2_range,
      required this.blood_pressure_code,
      required this.blood_pressure_range,
      required this.blood_sugar_code,
      required this.blood_sugar_range,
      required this.diagnosis,
      required this.eye_coloration,
      required this.heart_rate,
      required this.heart_rate_range,
      required this.respiration_rate,
      required this.respiration_rate_range,
      required this.spo2,
      required this.temperature});
}
