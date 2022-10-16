import 'package:flutter/material.dart';
import 'package:in_the_kloud_app/core/app/SizeConfig.dart';
import 'package:in_the_kloud_app/resources/Strings.dart';
import 'package:in_the_kloud_app/resources/colors.dart';
import 'package:in_the_kloud_app/resources/constants.dart';

class AppInputField extends StatelessWidget {
   AppInputField({
    Key? key,
    required this.context,
    required this.sizeConfig,
    this.trailingIcon,
    required this.title,
    this.onTextChange,
    this.initialText,
    this.child,
    this.obscureText = false,
    this.enabled = false,
  }) : super(key: key);

  final BuildContext context;
  final SizeConfig sizeConfig;
  final IconData? trailingIcon;
  final String title;
  final Function? onTextChange;
  final bool obscureText;
  final Widget? child;
  final String? initialText;
  final bool enabled;

  late final TextEditingController editTextController;

  @override
  Widget build(BuildContext context) {
    editTextController = TextEditingController(text: initialText);
    return Stack(
      children: [
        Container(
          height: 55,
          margin: const EdgeInsets.only(top: Constants.$15px),
          decoration: BoxDecoration(
              color: AppColors.lynxWhite,
              borderRadius: BorderRadius.all(Constants.SingInBoxRadius),
              boxShadow: Constants.SingInBoxShadow),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constants.$12px, vertical: Constants.$12px),
            child: child ??
                TextField(
                  enabled: enabled,
                  controller: editTextController,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: enabled? AppColors.Green:AppColors.LightGrey
                  ),
                  decoration: InputDecoration(
                    icon: Icon(
                      size: Constants.AppCustomTextFieldTrailingIconSize,
                      trailingIcon,
                      color: enabled? AppColors.Green:AppColors.LightGrey,
                    ),
                  ),

                  obscureText: obscureText,
                  obscuringCharacter: AppStrings.obscuringTextFieldCharacter,
                  onChanged: (text) => onTextChange!(text),
                ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
              margin: EdgeInsets.only(
                  left: sizeConfig.setHorizontalSizeWithUnits(1)),
              padding: EdgeInsets.symmetric(
                  horizontal: sizeConfig.setHorizontalSizeWithUnits(2.5),
                  vertical: Constants.$5px),
              decoration: BoxDecoration(
                  color: AppColors.lynxWhite,
                  borderRadius: BorderRadius.all(Constants.SingInBoxRadius),
                  boxShadow: Constants.SingInBoxShadow),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: enabled? AppColors.Green:AppColors.LightGrey,
                ),
              )),
        ),
      ],
    );
  }
}
