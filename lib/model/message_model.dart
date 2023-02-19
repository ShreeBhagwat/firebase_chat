class MessageModel {
  final String? message;
  final String? email;
  final String? time;

  MessageModel({
    this.message,
    this.email,
    this.time,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      email: json['email'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'email': email,
      'time': time,
    };
  }
}
