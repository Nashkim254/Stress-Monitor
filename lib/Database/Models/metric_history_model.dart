class MetricModel {
  String? start_date;
  String? end_date;
  String? user_key;

  MetricModel({
    required this.start_date,
    required this.end_date,
    required this.user_key
  });

  MetricModel.fromJson(Map<String, dynamic> json) {
    start_date = json['start_date'];
    end_date = json['end_date'];
    user_key = json['user_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['start_date'] = start_date;
    data['end_date'] = end_date;
    data['user_key'] = user_key;
    return data;
  }
}
