
import 'package:flutter/cupertino.dart';
import 'package:in_the_kloud_app/core/app_provider.dart';
import 'package:in_the_kloud_app/features/login/view/sing_in_screen.dart';
import 'package:provider/provider.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Logout'),
      ),
      content: const Text(
          'All your saved data will be deleted.\n Do your want to logout?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            context.read<AppProvider>().logOut();
            _navigateToLogin(context);
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
  void _navigateToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.route,(Route<dynamic> route) => false);
  }
}
