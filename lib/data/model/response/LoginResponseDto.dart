import 'package:e_commerce/data/model/response/UserDto.dart';
import 'package:e_commerce/domain/entities/Auth_result_entity.dart';

/// message : "success"
/// user : {"name":"Rana","email":"rana15@route.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1NDE0OGFkODNiMGVlYmVkY2UzN2I0NCIsIm5hbWUiOiJSYW5hIiwicm9sZSI6InVzZXIiLCJpYXQiOjE2OTkyMDgwODcsImV4cCI6MTcwNjk4NDA4N30.bWkdGAD55tREwTNFxd1TbI3kXj79Ppo79FocANAnHI8"

class LoginResponseDto {
  LoginResponseDto({
      this.message, 
      this.user,
    this.statusMsg,
      this.token,});

  LoginResponseDto.fromJson(dynamic json) {
    message = json['message'];
    statusMsg = json['statusMsg'];
    user = json['user'] != null ? UserDto.fromJson(json['user']) : null;
    token = json['token'];
  }
  String? message;
  UserDto? user;
  String? token;
  String? statusMsg;


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

