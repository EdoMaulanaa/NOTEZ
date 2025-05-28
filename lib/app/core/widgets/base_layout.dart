import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_constants.dart';

class BaseLayout extends StatelessWidget {
  final String title;
  final Widget body;
  final int currentIndex;
  final bool showBackButton;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;

  const BaseLayout({
    super.key,
    required this.title,
    required this.body,
    this.currentIndex = 0,
    this.showBackButton = false,
    this.actions,
    this.floatingActionButton,
    this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.back(),
              )
            : null,
        actions: actions,
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.offAllNamed(AppRoutes.home);
              break;
            case 1:
              Get.offAllNamed(AppRoutes.grades);
              break;
            case 2:
              Get.offAllNamed(AppRoutes.points);
              break;
            case 3:
              Get.offAllNamed(AppRoutes.profile);
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: AppStrings.grades,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: AppStrings.points,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppStrings.profile,
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
      bottomSheet: bottomSheet,
      backgroundColor: AppColors.background,
    );
  }
} 