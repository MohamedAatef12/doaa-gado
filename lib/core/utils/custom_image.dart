import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../themes/app_colors.dart';
import '../assets/images.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool isAsset;

  const CustomImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.isAsset = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.current;

    if (isAsset) {
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(colors),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => _buildPlaceholderWidget(colors),
      errorWidget: (context, url, error) => _buildErrorWidget(colors),
    );
  }

  Widget _buildPlaceholderWidget(AppColors colors) {
    return Shimmer.fromColors(
      baseColor: colors.gray,
      highlightColor: colors.white,
      child: Container(
        width: width,
        height: height,
        color: colors.white,
      ),
    );
  }

  Widget _buildErrorWidget(AppColors colors) {
    return Container(
      width: width,
      height: height,
      color: colors.gray,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.logo,
              width: 40.w,
              height: 40.h,
              color: colors.brownPrimary.withValues(alpha: 0.3),
            ),
            SizedBox(height: 4.h),
            Icon(
              Icons.image_not_supported_outlined,
              color: colors.brownPrimary.withValues(alpha: 0.3),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
