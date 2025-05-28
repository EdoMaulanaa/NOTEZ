part of 'app_pages.dart';


abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const LOGIN = _Paths.LOGIN;
  static const HOME = _Paths.HOME;
  static const GRADES = _Paths.GRADES;
  static const POINTS = _Paths.POINTS;
  static const ATTENDANCE = _Paths.ATTENDANCE;
  static const RULES = _Paths.RULES;
  static const PROFILE = _Paths.PROFILE;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/';
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const GRADES = '/grades';
  static const POINTS = '/points';
  static const ATTENDANCE = '/attendance';
  static const RULES = '/rules';
  static const PROFILE = '/profile';
}
