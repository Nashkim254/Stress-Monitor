class SubscribeModel {
  String? user_id;
  String? paid_at;
  String? expires_at;
  String? platform_id;
  String? amount;
  SubscribeModel(
      {required this.user_id,
      required this.paid_at,
      required this.expires_at,
      required this.amount,
      required this.platform_id});

  SubscribeModel.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    paid_at = json['paid_at'];
    expires_at = json['expires_at'];
    amount = json['amount'];
    platform_id = json['platform_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['user_id'] = user_id;
    data['paid_at'] = paid_at;
    data['expires_at'] = expires_at;
    data['amount'] = amount;
    data['platform_id'] = platform_id;
    return data;
  }
}
