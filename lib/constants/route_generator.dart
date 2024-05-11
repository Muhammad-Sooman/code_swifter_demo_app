import 'package:code_swifter_demo_app/constants/app_routes.dart';
import 'package:code_swifter_demo_app/screens/login_screen.dart';
import 'package:code_swifter_demo_app/screens/profile_screen.dart';
import 'package:code_swifter_demo_app/screens/signup_screen.dart';
import 'package:code_swifter_demo_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.welcomeScreen:
      return GetPageRoute(
        settings: settings,
        page: () => const WelcomeScreen(),
      );
    case AppRoutes.signupScreen:
      return GetPageRoute(
        settings: settings,
        page: () => const SignupScreen(),
      );
    case AppRoutes.loginScreen:
      return GetPageRoute(
        settings: settings,
        page: () => const LoginScreen(),
      );
    case AppRoutes.profileScreen:
      return GetPageRoute(
        settings: settings,
        page: () => const ProfileScreen(),
      );

    default:
      return _errorRoute(settings);
  }
}

Route<dynamic> _errorRoute(settings) {
  return GetPageRoute(
    settings: settings,
    page: () {
      return const Scaffold(
        body: Center(
          child: Text('Page Not Found'),
        ),
      );
    },
  );
}
