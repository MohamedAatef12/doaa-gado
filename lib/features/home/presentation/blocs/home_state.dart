import 'package:equatable/equatable.dart';
import '../../domain/entities/announcement.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/course.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Announcement> announcements;
  final List<Course> courses;
  final List<Category> categories;
  final int currentTabIndex;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.announcements = const [],
    this.courses = const [],
    this.categories = const [],
    this.currentTabIndex = 0,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<Announcement>? announcements,
    List<Course>? courses,
    List<Category>? categories,
    int? currentTabIndex,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      announcements: announcements ?? this.announcements,
      courses: courses ?? this.courses,
      categories: categories ?? this.categories,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    announcements,
    courses,
    categories,
    currentTabIndex,
    errorMessage,
  ];
}