import 'package:camera/camera.dart';

class User {
  final bool success;

  const User({
    required this.success,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      success: json['Success'],
    );
  }
}

String responseGlobal = '';

var responsePrincipal;
var responseDetalle;

String globalToken = '';

late CameraDescription camera;