class AuthModel {
  final String uid;
  final String email;
  final String password;
  final String imgUrl;

  AuthModel({
    required this.uid,
    required this.email,
    required this.password,
    required this.imgUrl,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
        uid: json['uid'],
        email: json['email'],
        password: json['password'],
        imgUrl: json['imgUrl']);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'imgUrl': imgUrl,
    };
  }
}
