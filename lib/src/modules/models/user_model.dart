
class UserModel {
  String age;
  String email;
  bool enabled;
  String fullName;
  String photoUrl;
  String rfc;
  String userUID;

  UserModel({
    this.age,
    this.email,
    this.enabled,
    this.fullName,
    this.photoUrl,
    this.rfc,
    this.userUID
  });

  factory UserModel.fromJson(Map user) => UserModel(
    age: user['age'],
    email: user['email'],
    enabled: user['enabled'],
    fullName: user['full_name'],
    photoUrl: user['photoUrl'],
    rfc: user['rfc'],
  );

}