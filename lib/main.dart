import 'package:flutter/material.dart';
import 'package:in_the_kloud_app/core/app_provider.dart';
import 'package:in_the_kloud_app/features/home/view/home_screen.dart';
import 'package:in_the_kloud_app/features/login/view/sing_in_screen.dart';
import 'package:in_the_kloud_app/resources/Strings.dart';
import 'package:in_the_kloud_app/resources/routes.dart';
import 'package:in_the_kloud_app/resources/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (BuildContext context) =>AppProvider(),
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: AppThemes.AppThemeData,
      initialRoute:SignInScreen.route ,
      routes: appRoutes,
    );
  }
}