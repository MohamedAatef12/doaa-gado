import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failure.dart';
import '../entities/auth_entities.dart';
import '../repositories/auth_repository.dart';

@injectable
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, LoginEntity>> call({
    required int code,
    required String mobile,
  }) async {
    return await _repository.login(code: code, mobile: mobile);
  }
}
