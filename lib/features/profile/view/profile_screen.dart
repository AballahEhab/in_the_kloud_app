import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_the_kloud_app/core/app_provider.dart';
import 'package:in_the_kloud_app/core/app/SizeConfig.dart';
import 'package:in_the_kloud_app/features/profile/models/detailed_user_data.dart';
import 'package:in_the_kloud_app/features/profile/provider/user_profile_provider.dart';
import 'package:in_the_kloud_app/resources/Strings.dart';
import 'package:in_the_kloud_app/resources/assets/images.dart';
import 'package:in_the_kloud_app/resources/colors.dart';
import 'package:in_the_kloud_app/resources/constants.dart';
import 'package:in_the_kloud_app/reusable_widgets/app_input_field.dart';
import 'package:in_the_kloud_app/reusable_widgets/log_out_dialog.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const route = '/profile-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SizeConfig initSizeConfig(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()
      ..initWithRatio(context: context, designWidth: 600);
    return sizeConfig;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProfileProvider>().getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = initSizeConfig(context);

    bool isLoading = context
        .select<UserProfileProvider, bool>((provider) => provider.userDataLoading);

    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ))
            : Container(
                margin: EdgeInsets.only(bottom: sizeConfig.toDynamicUnit(134)),
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AppImages.ProfileBackGroundBlock,
                        repeat: ImageRepeat.repeat),
                    borderRadius: BorderRadiusDirectional.vertical(
                        bottom: Radius.circular(sizeConfig.toDynamicUnit(40)))),
                child: UserProfile(sizeConfig: sizeConfig),
              ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  final SizeConfig sizeConfig;

  const UserProfile({required this.sizeConfig, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tuple2<DetailedUserData, bool> tuple =
        context.select<UserProfileProvider, Tuple2<DetailedUserData, bool>>(
            (provider) => Tuple2(provider.userData, provider.editModeEnabled));
    DetailedUserData userData = tuple.item1;
    bool isEditModeEnabled = tuple.item2;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: sizeConfig.toDynamicUnit(25)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: sizeConfig.toDynamicUnit(293),
                  width: sizeConfig.toDynamicUnit(544),
                  margin: EdgeInsets.only(
                      top: sizeConfig.toDynamicUnit(70),
                      right: sizeConfig.toDynamicUnit(14.5)),
                  padding: EdgeInsets.only(top: sizeConfig.toDynamicUnit(70)),
                  decoration: BoxDecoration(
                    color: AppColors.White,
                    borderRadius:
                        BorderRadius.circular(sizeConfig.toDynamicUnit(47)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(sizeConfig.toDynamicUnit(5)),
                        child: Text(userData.getFullName()),
                      ),
                      Padding(
                        padding: EdgeInsets.all(sizeConfig.toDynamicUnit(5)),
                        child: Text('${userData.age!}y, ${userData.gender}'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(sizeConfig.toDynamicUnit(5)),
                        child: Text(userData.birthDate.toString()),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: sizeConfig.toDynamicUnit(10),
                                right: sizeConfig.toDynamicUnit(18)),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.logout),
                              onPressed: () {
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      LogOutDialog(),
                                );
                              },
                              label: const Text('Logout'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: sizeConfig.toDynamicUnit(10),
                                left: sizeConfig.toDynamicUnit(18)),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.location_on),
                              onPressed: () {},
                              label: const Text('Location'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  height: sizeConfig.toDynamicUnit(140),
                  width: sizeConfig.toDynamicUnit(140),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          height: sizeConfig.toDynamicUnit(140),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.CircleAvatarBackGround,
                            border: Border.all(
                                color: AppColors.lynxWhite,
                                width: sizeConfig.toDynamicUnit(5),
                                style: BorderStyle.solid),
                            image: DecorationImage(
                                image: NetworkImage(userData.image!)),
                          )),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        height: sizeConfig.toDynamicUnit(35.2),
                        width: sizeConfig.toDynamicUnit(35.2),
                        child: InkWell(
                          onTap: () {
                            // context.read<UserProfileProvider>().enableEditing();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt_outlined,
                                  size: 15),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !isEditModeEnabled,
                  child: Positioned(
                    top: sizeConfig.toDynamicUnit(46),
                    right: 0,
                    height: sizeConfig.toDynamicUnit(63),
                    width: sizeConfig.toDynamicUnit(63),
                    child: InkWell(
                      onTap: () {
                        context.read<UserProfileProvider>().enableEditing();
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: (sizeConfig.toDynamicUnit(33.2)),
                  left: (sizeConfig.toDynamicUnit(37.2)),
                  bottom: (sizeConfig.toDynamicUnit(22.5)),
                ),
                child: AppInputField(
                  context: context,
                  title: 'first name',
                  sizeConfig: sizeConfig,
                  trailingIcon: Icons.person,
                  initialText: userData.firstName,
                  onTextChange: (text) {
                    context.read<UserProfileProvider>().firstName = text;
                  },
                  enabled: isEditModeEnabled,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: (sizeConfig.toDynamicUnit(33.2)),
                  left: (sizeConfig.toDynamicUnit(37.2)),
                  bottom: (sizeConfig.toDynamicUnit(22.5)),
                ),
                child: AppInputField(
                  context: context,
                  title: 'mid name',
                  sizeConfig: sizeConfig,
                  trailingIcon: Icons.person,
                  initialText: userData.lastName,
                  onTextChange: (text) {
                    context.read<UserProfileProvider>().midName = text;
                  },
                  enabled: isEditModeEnabled,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: (sizeConfig.toDynamicUnit(33.2)),
                  left: (sizeConfig.toDynamicUnit(37.2)),
                  bottom: (sizeConfig.toDynamicUnit(22.5)),
                ),
                child: AppInputField(
                  context: context,
                  title: 'address',
                  sizeConfig: sizeConfig,
                  trailingIcon: Icons.perm_contact_calendar_sharp,
                  initialText: userData.address?.address!,
                  onTextChange: (text) {
                    context.read<UserProfileProvider>().address = text;
                  },
                  enabled: isEditModeEnabled,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: (sizeConfig.toDynamicUnit(33.2)),
                  left: (sizeConfig.toDynamicUnit(37.2)),
                  bottom: (sizeConfig.toDynamicUnit(22.5)),
                ),
                child: AppInputField(
                  context: context,
                  title: 'phone',
                  sizeConfig: sizeConfig,
                  trailingIcon: Icons.phone,
                  initialText: userData.phone,
                  onTextChange: (text) {
                    context.read<UserProfileProvider>().phone = text;
                  },
                  enabled: isEditModeEnabled,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: (sizeConfig.toDynamicUnit(33.2)),
                  left: (sizeConfig.toDynamicUnit(37.2)),
                  bottom: (sizeConfig.toDynamicUnit(22.5)),
                ),
                child: AppInputField(
                    context: context,
                    title: 'Gender',
                    sizeConfig: sizeConfig,
                    child: _GenderInputRadioGroup(
                      sizeConfig: sizeConfig,
                      enabled: isEditModeEnabled,
                    )),
              ),
              SaveOrCancelPanel(
                  isEditModeEnabled: isEditModeEnabled, sizeConfig: sizeConfig)
            ],
          )
        ],
      ),
    );
  }
}

class SaveOrCancelPanel extends StatelessWidget {
  const SaveOrCancelPanel({
    Key? key,
    required this.isEditModeEnabled,
    required this.sizeConfig,
  }) : super(key: key);

  final bool isEditModeEnabled;
  final SizeConfig sizeConfig;

  @override
  Widget build(BuildContext context) {

    bool isSaveDataLoading = context.select<UserProfileProvider, bool>(
        (provider) => provider.saveDataLoading);

    return Visibility(
      visible: isEditModeEnabled,
      child: isSaveDataLoading
          ? Center(
              child: CircularProgressIndicator(color: AppColors.lynxWhite),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: sizeConfig.toDynamicUnit(10),
                      right: sizeConfig.toDynamicUnit(18)),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.cancel_outlined),
                    onPressed: () {
                      context.read<UserProfileProvider>().disableEditing();
                    },
                    label: const Text('Cancel'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: sizeConfig.toDynamicUnit(10),
                      left: sizeConfig.toDynamicUnit(18)),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check),
                    onPressed: () {context.read<UserProfileProvider>().updateUserData();},
                    label: const Text('Save'),
                  ),
                ),
              ],
            ),
    );
  }
}

class _GenderInputRadioGroup extends StatelessWidget {
  final SizeConfig sizeConfig;

  final bool enabled;

  const _GenderInputRadioGroup(
      {required this.sizeConfig, required this.enabled, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedGenderIndex = context.select<UserProfileProvider, int>(
        (provider) => provider.selectedGenderIndex!);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Radio<String>(
          value: AppStrings.genders[0],
          groupValue: AppStrings.genders[selectedGenderIndex],
          onChanged: enabled
              ? (v) {
                  if (enabled) {
                    print(
                        ' AppStrings.genders[selectedGenderIndex] ${AppStrings.genders[selectedGenderIndex]}');

                    print('value is $v');
                    print(
                        'AppStrings.genders.indexOf(v!) ${AppStrings.genders.indexOf(v!)}');
                    context.read<UserProfileProvider>().selectedGenderIndex =
                        AppStrings.genders.indexOf(v!);
                    print(
                        'index ${context.read<UserProfileProvider>().selectedGenderIndex}');
                    print(
                        ' AppStrings.genders[selectedGenderIndex] ${AppStrings.genders[selectedGenderIndex]}');
                  }
                }
              : null,
        ),
        const Text('Male'),
        SizedBox(
          width: sizeConfig.toDynamicUnit(85.5),
        ),
        Radio<String>(
            value: AppStrings.genders[1],
            groupValue: AppStrings.genders[selectedGenderIndex],
            onChanged: enabled
                ? (v) {
                    if (enabled) {
                      context.read<UserProfileProvider>().selectedGenderIndex =
                          1;
                    }
                  }
                : null),
        const Text('female'),
      ],
    );
  }
}
