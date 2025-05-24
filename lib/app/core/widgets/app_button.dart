import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool isPrimary;
  final bool isFullWidth;
  final bool isLoading;
  final IconData? icon;

  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.isFullWidth = true,
    this.isLoading = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : Colors.white,
          foregroundColor: isPrimary ? Colors.white : AppColors.primary,
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingMedium,
            horizontal: AppDimensions.paddingLarge,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            side: isPrimary
                ? BorderSide.none
                : const BorderSide(color: AppColors.primary),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: AppDimensions.iconSize),
                    SizedBox(width: AppDimensions.paddingSmall),
                  ],
                  Text(
                    text,
                    style: AppTextStyle.body1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isPrimary ? Colors.white : AppColors.primary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
} 