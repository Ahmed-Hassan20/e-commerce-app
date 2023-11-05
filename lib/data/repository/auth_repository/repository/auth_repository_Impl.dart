import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/model/response/RegisterResponseDto.dart';
import 'package:e_commerce/data/repository/auth_repository/data_source/auth_remote_data_source_Impl.dart';
import 'package:e_commerce/domain/entities/Auth_result_entity.dart';
import 'package:e_commerce/domain/entities/failures.dart';
import 'package:e_commerce/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:e_commerce/domain/repository/repository/auth_repository_contract.dart';


class AuthRepositoryImpl implements AuthRepositoryContract{
AuthRemoteDataSource remoteDataSource;
AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failures,AuthResultEntity>> register(String name, String email, String password, String rePassword, String phone) {
return remoteDataSource.register(name, email, password, rePassword, phone);
  }

  @override
  Future<Either<Failures, AuthResultEntity>> login(String email, String password) {
return remoteDataSource.login(email, password);
  }


}
AuthRepositoryContract injectAuthRepositoryContract(){
return AuthRepositoryImpl(remoteDataSource: injectAuthRemoteDataSource());}