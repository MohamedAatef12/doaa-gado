import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;

  HomeBloc(this._homeRepository) : super(const HomeState()) {
    on<GetHomeDataEvent>(_onGetHomeData);
    on<ChangeTabEvent>(_onChangeTab);
  }

  Future<void> _onGetHomeData(
    GetHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final announcementsResult = await _homeRepository.getAnnouncements();
    final coursesResult = await _homeRepository.getNewestCourses();
    final categoriesResult = await _homeRepository.getSelectedCategories();

    announcementsResult.fold(
      (failure) => emit(state.copyWith(status: HomeStatus.error, errorMessage: failure.message)),
      (announcements) {
        coursesResult.fold(
          (failure) => emit(state.copyWith(status: HomeStatus.error, errorMessage: failure.message)),
          (courses) {
            categoriesResult.fold(
              (failure) => emit(state.copyWith(status: HomeStatus.error, errorMessage: failure.message)),
              (categories) => emit(state.copyWith(
                status: HomeStatus.success,
                announcements: announcements,
                courses: courses,
                categories: categories,
              )),
            );
          },
        );
      },
    );
  }

  void _onChangeTab(ChangeTabEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentTabIndex: event.index));
  }
}