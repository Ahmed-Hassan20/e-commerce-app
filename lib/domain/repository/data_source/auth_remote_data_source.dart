import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/Auth_result_entity.dart';
import 'package:e_commerce/domain/entities/failures.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failures, AuthResultEntity>> register(String name, String email,
      String password, String rePassword, String phone);

  Future<Either<Failures, AuthResultEntity>> login(
      String email, String password);
}
