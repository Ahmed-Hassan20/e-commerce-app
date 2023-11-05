import 'package:e_commerce/data/model/response/RegisterResponseDto.dart';
import 'package:e_commerce/domain/entities/Auth_result_entity.dart';

abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{
  String? loadingMessage;
  RegisterLoadingState({this.loadingMessage});
}

class RegisterErrorState extends RegisterStates{
  String? errorMessage;
  RegisterErrorState({this.errorMessage});
}

class RegisterSuccessState extends RegisterStates{
  AuthResultEntity response ;
  RegisterSuccessState({required this.response});
}