import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/auth_entities.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login({
    required int code,
    required String mobile,
  });

  Future<Either<Failure, RegisterEntity>> register({
    required String fullName,
    required String mobile,
    required DateTime birthdate,
  });
}
