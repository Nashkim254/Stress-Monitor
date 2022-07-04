class RegisterModel {
  //String? pin;
  String? name;
  String? email;
  String? password;

  RegisterModel({
    //required this.pin,
    required this.name,
    required this.email,
    required this.password
  });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    //pin = json['pin'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['pin'] = pin;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}