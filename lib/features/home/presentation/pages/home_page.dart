import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/assets/images.dart';
import '../../../../core/themes/app_colors.dart';
import '../blocs/home_bloc.dart';
import '../blocs/home_state.dart';
import '../widgets/category_item.dart';
import '../widgets/course_card.dart';
import '../widgets/home_carousel.dart';
import '../widgets/section_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.current;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == HomeStatus.error) {
            return Center(child: Text(state.errorMessage ?? 'حدث خطأ ما'));
          }

          return CustomScrollView(
            slivers: [
              // Gradient Header
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 20.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [colors.brownPrimary, colors.brownLight],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    image: DecorationImage(
                      image: AssetImage(AppAssets.logo),
                      fit: BoxFit.cover,
                      opacity: 0.3, // Low light effect
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'مرحباً بك،',
                            style: TextStyle(
                              color: colors.white.withValues(alpha: 0.8),
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            'محمد عاطف',
                            style: TextStyle(
                              color: colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Aref Ruqaa',
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: colors.white,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Carousel Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: HomeCarousel(announcements: state.announcements),
                ),
              ),

              // Courses Section
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SectionHeader(
                      title: 'أحدث دوراتنا التعليمية',
                      onSeeAll: () {},
                    ),
                    SizedBox(
                      height: 220.h,
                      child: ListView.builder(
                        padding: EdgeInsets.only(right: 16.w),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.courses.length,
                        itemBuilder: (context, index) {
                          return CourseCard(course: state.courses[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Categories Section
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SectionHeader(
                      title: 'المواضيع المختارة',
                      onSeeAll: () {},
                    ),
                    SizedBox(
                      height: 120.h,
                      child: ListView.builder(
                        padding: EdgeInsets.only(right: 16.w),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          return CategoryItem(category: state.categories[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 30.h)),
            ],
          );
        },
      ),
    );
  }
}