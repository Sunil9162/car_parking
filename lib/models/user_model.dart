class UserModel {
  final String uid;
  final String number;
  final String password;
  final String name;

  UserModel({
    required this.uid,
    required this.number,
    required this.password,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      number: json['number'],
      password: json['password'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'number': number,
      'password': password,
      'name': name,
    };
  }
}
