import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failure.dart';
import '../entities/auth_entities.dart';
import '../repositories/auth_repository.dart';

@injectable
class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<Either<Failure, RegisterEntity>> call({
    required String fullName,
    required String mobile,
    required DateTime birthdate,
  }) async {
    return await _repository.register(
      fullName: fullName,
      mobile: mobile,
      birthdate: birthdate,
    );
  }
}
