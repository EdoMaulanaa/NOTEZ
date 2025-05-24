import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double? elevation;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;

  const AppCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.elevation,
    this.onTap,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.all(AppDimensions.marginSmall),
      elevation: elevation ?? 2,
      color: color ?? AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(AppDimensions.borderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(AppDimensions.borderRadius),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppDimensions.paddingMedium),
          child: child,
        ),
      ),
    );
  }
} 