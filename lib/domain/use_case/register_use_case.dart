import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/model/response/RegisterResponseDto.dart';
import 'package:e_commerce/data/repository/auth_repository/repository/auth_repository_Impl.dart';
import 'package:e_commerce/domain/entities/Auth_result_entity.dart';
import 'package:e_commerce/domain/entities/failures.dart';
import 'package:e_commerce/domain/repository/repository/auth_repository_contract.dart';

class RegisterUseCase {
  AuthRepositoryContract repositoryContract;
  RegisterUseCase({required this.repositoryContract});

 Future<Either<Failures,AuthResultEntity>> invoke(String name, String email, String password, String rePassword,
      String phone) {
    return repositoryContract.register(name, email, password, rePassword, phone);
  }
}
RegisterUseCase injectRegisterUseCase(){
  return RegisterUseCase(repositoryContract: injectAuthRepositoryContract());
}