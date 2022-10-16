import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_the_kloud_app/core/app_provider.dart';
import 'package:in_the_kloud_app/core/app/SizeConfig.dart';
import 'package:in_the_kloud_app/features/home/provider/products_provider.dart';
import 'package:in_the_kloud_app/features/home/view/cart_tab.dart';
import 'package:in_the_kloud_app/features/login/models/user_data_model.dart';
import 'package:in_the_kloud_app/features/login/view/sing_in_screen.dart';
import 'package:in_the_kloud_app/features/profile/view/profile_screen.dart';
import 'package:in_the_kloud_app/resources/colors.dart';
import 'package:in_the_kloud_app/reusable_widgets/log_out_dialog.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'home_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const route = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  SizeConfig initSizeConfig(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()
      ..initWithRatio(context: context, designWidth: 600);
    return sizeConfig;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsProvider>()
        ..getAllCategories()
        ..getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = initSizeConfig(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lynxWhite,
          centerTitle: true,
          title: const Text(
            'Home',
            style: TextStyle(color: AppColors.LightGrey),
          ),
          iconTheme:
              Theme.of(context).iconTheme.copyWith(color: AppColors.LightGrey),
          actions: [
            const Icon(
              Icons.arrow_forward_ios_rounded,
            )
          ],
          elevation: 0,
        ),
        extendBody: true,
        drawer: _AppDrawer(sizeConfig: sizeConfig),
        body: const TabBarView(children: [HomeTab(), CartTab()]),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.bottomNavigationBarGrad,
                    AppColors.White
                  ])),
          margin: EdgeInsets.only(
            top: sizeConfig.toDynamicUnit(17.6),
            bottom: sizeConfig.toDynamicUnit(27.2),
            left: sizeConfig.toDynamicUnit(155),
            right: sizeConfig.toDynamicUnit(155),
          ),
          child: TabBar(
            unselectedLabelColor: AppColors.IconsNotSelected,
            labelColor: AppColors.Green,
            indicator: const BoxDecoration(),
            tabs: [
              Tab(
                icon: const Icon(Icons.home_outlined),
                text: 'home',
                iconMargin: const EdgeInsets.all(0),
                height: sizeConfig.toDynamicUnit(73.5),
              ),
              Tab(
                icon: IconWithNotificationCounter(sizeConfig: sizeConfig),
                text: 'cart',
                iconMargin: const EdgeInsets.all(0),
                height: sizeConfig.toDynamicUnit(73.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconWithNotificationCounter extends StatelessWidget {
  const IconWithNotificationCounter({
    Key? key,
    required this.sizeConfig,
  }) : super(key: key);

  final SizeConfig sizeConfig;

  @override
  Widget build(BuildContext context) {
    int notificationCount = context.select<AppProvider, int>(
        (provider) => provider.getNumOfCartProducts());
    return Stack(
      children: [
        Positioned(
          child: Container(
            width: sizeConfig.toDynamicUnit(50),
            height: sizeConfig.toDynamicUnit(45),
            child: const Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Visibility(
            visible: notificationCount > 0,
            child: Container(
              width: sizeConfig.toDynamicUnit(25.6),
              height: sizeConfig.toDynamicUnit(25.6),
              decoration: BoxDecoration(
                  color: AppColors.NotificationLabel,
                  borderRadius: BorderRadius.all(
                      Radius.circular(sizeConfig.toDynamicUnit(25.6)))),
              child: Center(
                  child: Text('$notificationCount',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.White))),
            ),
          ),
        )
      ],
    );
  }
}

class _AppDrawer extends StatelessWidget {
  final SizeConfig sizeConfig;

  const _AppDrawer({required this.sizeConfig, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDataModel userData = context
        .select<AppProvider, UserDataModel>((provider) => provider.userData!);
    return Padding(
      padding: EdgeInsets.only(
          top: sizeConfig.toDynamicUnit(29),
          bottom: sizeConfig.toDynamicUnit(114)),
      child: Drawer(
        width: sizeConfig.toDynamicUnit(380),
        elevation: 500,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(sizeConfig.toDynamicUnit(46)))),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: sizeConfig.toDynamicUnit(24)),
                height: sizeConfig.toDynamicUnit(140),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.Red,
                  border: Border.all(
                      color: AppColors.lynxWhite,
                      width: sizeConfig.toDynamicUnit(5),
                      style: BorderStyle.solid),
                  image: DecorationImage(image: NetworkImage(userData.image!)),
                )),
            Center(child: Padding(
              padding:  EdgeInsets.only(top:sizeConfig.toDynamicUnit(8),bottom:sizeConfig.toDynamicUnit(39)),
              child: Text(userData.getFullName(),style:Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.LightGrey
              )),
            )),
            const Divider(),
            Expanded(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () {
                      _navigateToProfile(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext context) => LogOutDialog(),
                      );
                    },
                  ),
                ],
              ),
            ),
             Text('www.inthekloud.com')
          ],
        ), // Populate the Drawer in the next step.
      ),
    );
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.pushNamed(context, ProfileScreen.route);
  }
}
