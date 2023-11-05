import 'package:e_commerce/domain/entities/Auth_result_entity.dart';

import 'UserDto.dart';
import 'package:e_commerce/data/model/response/Error.dart';

/// message : "success"
/// user : {"name":"Ahmed Abd Al-Muti1","email":"sna189@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1NDExNjc0YjBiODBmYmJjMDY4ODZhOSIsIm5hbWUiOiJBaG1lZCBBYmQgQWwtTXV0aTEiLCJyb2xlIjoidXNlciIsImlhdCI6MTY5ODc2NDQwNSwiZXhwIjoxNzA2NTQwNDA1fQ.lqauM2lD1MR14aU1xzdZYNdmP_5zuJhYU0X6FrVFlZ8"

class RegisterResponseDto {
  RegisterResponseDto({
    this.message,
    this.user,
    this.error,
    this.statusMsg,
    this.token,
  });

  RegisterResponseDto.fromJson(dynamic json) {
    message = json['message'];
    statusMsg = json['statusMsg'];
    user = json['user'] != null ? UserDto.fromJson(json['user']) : null;
    error = json['errors'] != null ? Error.fromJson(json['errors']) : null;
    token = json['token'];
  }
  String? message;

  UserDto? user;
  String? token;
  String? statusMsg;
  Error? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['statusMsg'] = statusMsg;

    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token;
    return map;
  }
  AuthResultEntity toAuthResultEntity(){
    return AuthResultEntity(
      userEntity: user?.toUserEntity(),
      token: token
    );

  }
}
