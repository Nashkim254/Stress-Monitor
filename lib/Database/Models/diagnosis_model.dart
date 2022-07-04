class DiagnosisModel {
  String? spo2_range;
  String? spo2;
  String? blood_sugar_range;
  String? blood_sugar_code;
  String? blood_pressure_range;
  String? blood_pressure_code;
  String? respiration_rate_range;
  String? respiration_rate;
  String? heart_rate_range;
  String? heart_rate;
  String? eye_coloration;
  String? temperature;
  String? diagnosis;
  DiagnosisModel(
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

  DiagnosisModel.fromJson(Map<String, dynamic> json) {
    spo2_range = json['spo2_range'];
    spo2 = json['spo2'];
    blood_sugar_range = json['blood_sugar_range'];
    blood_sugar_code = json['blood_sugar_code'];
    blood_pressure_code = json['blood_pressure_code'];
    blood_pressure_range = json['blood_pressure_range'];
    diagnosis = json['diagnosis'];
    eye_coloration = json['eye_coloration'];
    heart_rate = json['heart_rate'];
    heart_rate_range = json['heart_rate_range'];
    respiration_rate = json['respiration_rate'];
    respiration_rate_range = json['respiration_rate_range'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['pin'] = pin;
    data['spo2_range'] = spo2_range;
    data['spo2'] = spo2;
    data['blood_sugar_range'] = blood_sugar_range;
    data['blood_sugar_code'] = blood_sugar_code;
    data['blood_pressure_code'] = blood_pressure_code;
    data['blood_pressure_range'] = blood_pressure_range;
    data['diagnosis'] = diagnosis;
    data['eye_coloration'] = eye_coloration;
    data['heart_rate'] = heart_rate;
    data['heart_rate_range'] = heart_rate_range;
    data['respiration_rate'] = respiration_rate;
     data['respiration_rate_range'] = respiration_rate_range;
    data['temperature'] = temperature;
    return data;
  }
}
