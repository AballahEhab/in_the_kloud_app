import 'package:flutter/material.dart';
import 'package:in_the_kloud_app/core/app_provider.dart';
import 'package:in_the_kloud_app/core/app/SizeConfig.dart';
import 'package:in_the_kloud_app/features/home/view/home_screen.dart';
import 'package:in_the_kloud_app/features/login/provider/logIn_provider.dart';
import 'package:in_the_kloud_app/resources/Strings.dart';
import 'package:in_the_kloud_app/resources/assets/images.dart';
import 'package:in_the_kloud_app/resources/colors.dart';
import 'package:in_the_kloud_app/resources/constants.dart';
import 'package:in_the_kloud_app/reusable_widgets/app_input_field.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const route = '/sign-in-screen';

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = initSizeConfig(context);

    return ChangeNotifierProvider(
        create: (BuildContext context) => LogInProvider(),
        builder: (BuildContext context, child) {
          setListenerForUserData(context);
          return buildScaffold(context, sizeConfig);
        });
  }

  SizeConfig initSizeConfig(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()
      ..init(
          context: context, numOfHorizontalUnits: 34, numOfVerticalUnits: 74);
    return sizeConfig;
  }

  void setListenerForUserData(BuildContext context) {
    Provider.of<LogInProvider>(context, listen: false).userData.addListener(() {
/*      var value =
          Provider
              .of<LogInProvider>(context, listen: false)
              .userData
              .value;
      if (value != null) {
        Provider
            .of<AppProvider>(context, listen: false)
            .userData = value;
        navigateToHomeScreen(context);
      }*/
    });
  }

  Widget buildScaffold(BuildContext context, SizeConfig sizeConfig) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    buildSignInTitleContainer(sizeConfig, context),
                    buildSignInInputsContainer(sizeConfig, context),
                  ],
                ),
              ),
              buildContinueWithGoogleContainer(sizeConfig, context)
            ],
          ),
        ),
      ),
    );
  }

  Container buildSignInTitleContainer(
      SizeConfig sizeConfig, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AppImages.singInWelcomeVectorArt,
              opacity: Constants.SingInDecorationImageOpacity)),
      padding: EdgeInsets.only(
        left: (sizeConfig.setHorizontalSizeWithUnits(3)),
        right: (sizeConfig.setHorizontalSizeWithUnits(6)),
        top: Constants.$75px,
        bottom: Constants.$50px,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.signInTitle,
              style: Theme.of(context).textTheme.headlineMedium),
          Padding(
            padding: EdgeInsets.only(
              left: (sizeConfig.setHorizontalSizeWithUnits(2)),
              top: Constants.$15px,
            ),
            child: Text(
              AppStrings.signInWelcomeMessage,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          )
        ],
      ),
    );
  }

  Container buildSignInInputsContainer(
      SizeConfig sizeConfig, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Constants.$12px),
      decoration: BoxDecoration(
        color: AppColors.lynxWhite,
        borderRadius: BorderRadius.only(
          topLeft: Constants.SingInBoxRadius,
          topRight: Constants.SingInBoxRadius,
        ),
        border: Border.all(style: BorderStyle.none),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: (sizeConfig.setHorizontalSizeWithUnits(2)),
              vertical: 15,
            ),
            child: AppInputField(
                context: context,
                title: AppStrings.userNameLabelText,
                sizeConfig: sizeConfig,
                trailingIcon: Icons.person,
                enabled: true,
                onTextChange: (text) {
                  Provider.of<LogInProvider>(context, listen: false).userName =
                      text;
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: (sizeConfig.setHorizontalSizeWithUnits(2)),
                vertical: Constants.$15px),
            child: AppInputField(
              context: context,
              title: AppStrings.passwordLabelText,
              sizeConfig: sizeConfig,
              trailingIcon: Icons.lock,
              enabled: true,
              onTextChange: (text) {
                Provider.of<LogInProvider>(context, listen: false).password =
                    text;
              },
              obscureText: true,
            ),
          ),
          Consumer<LogInProvider>(
            builder: (context, loginProvider, child) {
              return Visibility(
                visible: loginProvider.errorMessage != null,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: (sizeConfig.setHorizontalSizeWithUnits(2)),
                      vertical: Constants.$8px),
                  child: Text(loginProvider.errorMessage ?? AppStrings.error,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.Red, fontWeight: FontWeight.bold)),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: sizeConfig.setHorizontalSizeWithUnits(2),
              vertical: Constants.$20px,
            ),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<LogInProvider>(context, listen: false)
                    .login()
                    .then((value) {
                  var value = Provider.of<LogInProvider>(context, listen: false)
                      .userData
                      .value;
                  if (value != null) {
                    Provider.of<AppProvider>(context, listen: false).userData =
                        value;
                    navigateToHomeScreen(context);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: Constants.ElevatedButtonBorderRadius,
                  ),
                  fixedSize: const Size(double.infinity, Constants.$55px),
                  textStyle: Theme.of(context).textTheme.titleLarge),
              child: SizedBox.expand(
                child: Center(
                  child: Consumer<LogInProvider>(
                    builder: (context, loginProvider, child) {
                      return loginProvider.isLoading
                          ? SizedBox(
                              width: Constants.$20px,
                              height: Constants.$20px,
                              child: CircularProgressIndicator(
                                  color: AppColors.lynxWhite))
                          : const Text(AppStrings.signInBtnText);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContinueWithGoogleContainer(
      SizeConfig sizeConfig, BuildContext context) {
    return Container(
      color: AppColors.grey_200,
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: sizeConfig.setHorizontalSizeWithUnits(2),
              right: sizeConfig.setHorizontalSizeWithUnits(2),
              top: Constants.$35px,
              bottom: Constants.$60px,
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: Constants.ElevatedButtonBorderRadius,
                  ),
                  fixedSize:
                      const Size(Constants.match_parent, Constants.$55px),
                  backgroundColor: AppColors.lynxWhite,
                  textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w800),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(Constants.$12px),
                      child: Image(image: AppImages.GoogleLogoPng),
                    ),
                    Text(
                      AppStrings.continueWithGoogleBtnText,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: Constants.$20px, bottom: Constants.$8px),
            child: Text(AppStrings.inTheKloudSiteAddressText,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w800, color: AppColors.grey_400)),
          )
        ],
      ),
    );
  }

  void navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomeScreen.route);
  }
}
