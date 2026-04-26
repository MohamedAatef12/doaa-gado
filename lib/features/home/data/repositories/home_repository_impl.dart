import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/assets/images.dart';
import '../../domain/entities/announcement.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/course.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/announcement_model.dart';
import '../models/category_model.dart';
import '../models/course_model.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<Either<Failure, List<Announcement>>> getAnnouncements() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const Right([
      AnnouncementModel(
        id: '1',
        title: 'حلقة تحفيظ القرآن الكريم',
        description: 'انضم إلينا في رحلة إيمانية لحفظ كتاب الله',
        imageUrl: AppAssets.slider_test_image,
      ),
      AnnouncementModel(
        id: '2',
        title: 'دورة التجويد الميسر',
        description: 'تعلم أحكام التجويد بطريقة سهلة ومبسطة',
        imageUrl: AppAssets.slider_test_image,
      ),
      AnnouncementModel(
        id: '3',
        title: 'مسابقة التدبر اليومية',
        description: 'شارك معنا وتدبر آيات الله للفوز بجوائز قيمة',
        imageUrl: AppAssets.slider_test_image,
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<Course>>> getNewestCourses() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const Right([
      CourseModel(
        id: '1',
        title: 'تفسير جزء عم',
        imageUrl: AppAssets.card_test_image,
      ),
      CourseModel(
        id: '2',
        title: 'السيرة النبوية للأطفال',
        imageUrl: AppAssets.card_test_image,
      ),
      CourseModel(
        id: '3',
        title: 'أصول الفقه للمبتدئين',
        imageUrl: AppAssets.card_test_image,
      ),
      CourseModel(
        id: '4',
        title: 'الأربعون النووية',
        imageUrl: AppAssets.card_test_image,
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<Category>>> getSelectedCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const Right([
      CategoryModel(
        id: '1',
        title: 'القرآن الكريم',
        iconPath: AppAssets.vector,
      ),
      CategoryModel(
        id: '2',
        title: 'الحديث الشريف',
        iconPath: AppAssets.vector,
      ),
      CategoryModel(
        id: '3',
        title: 'الفقه الإسلامي',
        iconPath: AppAssets.vector,
      ),
      CategoryModel(
        id: '4',
        title: 'اللغة العربية',
        iconPath: AppAssets.vector,
      ),
    ]);
  }
}
