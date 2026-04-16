class OtpModel {
  final int? statusCode;
  final String? message;

  OtpModel({
    this.statusCode,
    this.message,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
    };
  }
}