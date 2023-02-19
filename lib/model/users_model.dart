class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? createOn;
  final String? isOnline;

  UserModel({this.id, this.name, this.email, this.createOn, this.isOnline});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      createOn: json['createOn'],
      isOnline: json['isOnline'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'createOn': createOn,
      'isOnline': isOnline,
    };
  }
}
