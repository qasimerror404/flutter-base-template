import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../utils/extensions/context_extensions.dart';

/// Shimmer loading widget
class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.shimmerBaseDark : AppColors.shimmerBase,
      highlightColor:
          isDark ? AppColors.shimmerHighlightDark : AppColors.shimmerHighlight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.radiusSM),
        ),
      ),
    );
  }
}

/// Shimmer loading for list items
class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.p16,
        vertical: AppSizes.p8,
      ),
      child: Row(
        children: [
          const ShimmerWidget(
            width: AppSizes.avatarMD,
            height: AppSizes.avatarMD,
            borderRadius: BorderRadius.all(
              Radius.circular(AppSizes.radiusFull),
            ),
          ),
          const SizedBox(width: AppSizes.p12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget(
                  width: context.screenWidth * 0.6,
                  height: 16,
                ),
                const SizedBox(height: AppSizes.p8),
                ShimmerWidget(
                  width: context.screenWidth * 0.4,
                  height: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Shimmer loading for grid items
class ShimmerGridItem extends StatelessWidget {
  const ShimmerGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.p12),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: ShimmerWidget(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          const SizedBox(height: AppSizes.p12),
          ShimmerWidget(
            width: context.screenWidth * 0.3,
            height: 16,
          ),
          const SizedBox(height: AppSizes.p8),
          ShimmerWidget(
            width: context.screenWidth * 0.2,
            height: 14,
          ),
        ],
      ),
    );
  }
}

/// Shimmer loading list
class ShimmerList extends StatelessWidget {
  final int itemCount;

  const ShimmerList({
    super.key,
    this.itemCount = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => const ShimmerListTile(),
    );
  }
}

/// Shimmer loading grid
class ShimmerGrid extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;

  const ShimmerGrid({
    super.key,
    this.itemCount = 6,
    this.crossAxisCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppSizes.p12,
        mainAxisSpacing: AppSizes.p12,
        childAspectRatio: 0.75,
      ),
      itemCount: itemCount,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(AppSizes.p16),
      itemBuilder: (context, index) => const ShimmerGridItem(),
    );
  }
}

