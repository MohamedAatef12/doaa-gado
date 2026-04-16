// ignore_for_file: avoid_types_as_parameter_names

import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';

abstract class NoParamUseCase<Type> {
  Future<Either<Failure, Type>> call();
}
