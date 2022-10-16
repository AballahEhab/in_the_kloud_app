import 'package:flutter/material.dart';
import 'package:in_the_kloud_app/core/app_provider.dart';
import 'package:in_the_kloud_app/features/home/provider/products_provider.dart';
import 'package:in_the_kloud_app/features/home/view/home_screen.dart';
import 'package:in_the_kloud_app/features/login/view/sing_in_screen.dart';
import 'package:in_the_kloud_app/features/product_details/provider/product_details_provider.dart';
import 'package:in_the_kloud_app/features/product_details/view/product_details_screen.dart';
import 'package:in_the_kloud_app/features/profile/provider/user_profile_provider.dart';
import 'package:in_the_kloud_app/features/profile/view/profile_screen.dart';
import 'package:provider/provider.dart';

final Map<String, WidgetBuilder> appRoutes = <String, WidgetBuilder>{
  SignInScreen.route: (context) => const SignInScreen(),
  HomeScreen.route: (context) => ChangeNotifierProvider(
        create: (BuildContext buildContext) => ProductsProvider(
          (context.read<AppProvider>()
              .userData
              ?.token)!,
        ),
        child: const HomeScreen(),
      ),
  ProductDetailsScreen.route: (context) => ChangeNotifierProvider(
        create: (BuildContext buildContext) => ProductDetailsProvider(),
        child: const ProductDetailsScreen(),
      ),
  ProfileScreen.route: (context) => ChangeNotifierProvider(
    create: (BuildContext buildContext) {
      var appProvider = context.read<AppProvider>();
      return UserProfileProvider(
          (appProvider.userData?.token)!, (appProvider.userData?.id)!);
    },
    // lazy: false,
    child: const ProfileScreen(),
  ),

};
