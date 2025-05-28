import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/core/constants/app_constants.dart';
import 'app/routes/app_pages.dart';
import 'constants/theme.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'models/grade_data.dart';
import 'models/point_data.dart';
import 'models/attendance_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  await _preloadData();

  runApp(const MyApp());
}

Future<void> _preloadData() async {
  final grades = GradeManager().grades;
  final points = PointManager().points;
  final attendance = AttendanceManager().attendance;

  print('Preloaded data:');
  print(
      'Average grade: ${grades.calculateOverallAverage().toStringAsFixed(1)}');
  print('Total pelanggaran: ${points.totalPelanggaranPoints}');
  print('Total penghargaan: ${points.totalPrestasiPoints}');
  print(
      'Total absensi: ${attendance.totalAlpha + attendance.totalIzin + attendance.totalSakit}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NOTEZ',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            padding: EdgeInsets.zero,
            viewPadding: EdgeInsets.zero,
            viewInsets: EdgeInsets.zero,
          ),
          child: child!,
        );
      },
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
