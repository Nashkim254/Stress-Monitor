class TestModel {
  //String? pin;
  String? invoice_number;
  String? msisdn;

  TestModel({
    //required this.pin,
    required this.invoice_number,
    required this.msisdn,
  });

  TestModel.fromJson(Map<String, dynamic> json) {
    //pin = json['pin'];
    invoice_number = json['invoice_number'];
    msisdn = json['msisdn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['pin'] = pin;
    data['invoice_number'] = invoice_number;
    data['msisdn'] = msisdn;
    return data;
  }
}