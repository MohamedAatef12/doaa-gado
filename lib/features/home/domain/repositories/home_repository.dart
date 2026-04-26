import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/announcement.dart';
import '../entities/category.dart';
import '../entities/course.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Announcement>>> getAnnouncements();
  Future<Either<Failure, List<Course>>> getNewestCourses();
  Future<Either<Failure, List<Category>>> getSelectedCategories();
}

