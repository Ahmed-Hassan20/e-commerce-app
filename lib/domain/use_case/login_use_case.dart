import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/repository/auth_repository/repository/auth_repository_Impl.dart';
import 'package:e_commerce/domain/entities/Auth_result_entity.dart';
import 'package:e_commerce/domain/entities/failures.dart';
import 'package:e_commerce/domain/repository/repository/auth_repository_contract.dart';

class LoginUseCase {
  AuthRepositoryContract repositoryContract;
  LoginUseCase({required this.repositoryContract});

 Future<Either<Failures,AuthResultEntity>> invoke(String email, String password) {
    return repositoryContract.login( email, password);
  }
}
LoginUseCase injectLoginUseCase(){
  return LoginUseCase(repositoryContract: injectAuthRepositoryContract());
}