import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flyy_test_task/constants/constants.dart';
import 'package:flyy_test_task/styles/dimensions.dart';
import 'package:flyy_test_task/styles/palette.dart';
import 'package:flyy_test_task/styles/styles.dart';
import 'package:flyy_test_task/styles/widgets/placeholders.dart';
import 'package:flyy_test_task/ui/home/home_screen.dart';
import 'package:flyy_test_task/ui/main/notifier/main_notifier.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final read = ref.read(mainProvider);
    final watch = ref.watch(mainProvider);

    var appBar = AppBar(
      titleSpacing: AppDimension.mediumPadding,
      title: Text(
        AppConstant.appName,
        style: AppStyle.appbarTitle.apply(color: AppColor.white),
      ),
      actions: [
        CupertinoButton(
          onPressed: () => read.onCamera(),
          minSize: 0,
          padding: const EdgeInsets.all(AppDimension.mediumPadding),
          child: const Icon(
            Icons.camera_alt,
            size: AppDimension.defaultIconSize,
            color: AppColor.white,
          ),
        ),
      ],
    );

    var body = AnimatedSwitcher(
      // key: ValueKey<int>(watch.currentIndex),
      duration: const Duration(milliseconds: AppConstant.defaultAnimationDuration),
      reverseDuration: const Duration(milliseconds: AppConstant.defaultAnimationDuration),
      switchInCurve: Curves.ease,
      switchOutCurve: Curves.ease,
      child: [
        const HomeScreen(),
        const EmptyTabPlaceHolder(icon: Icons.sms, label: AppConstant.navTwo),
        const EmptyTabPlaceHolder(icon: Icons.notifications, label: AppConstant.navThree),
        const EmptyTabPlaceHolder(icon: Icons.person, label: AppConstant.navFour),
      ][watch.currentIndex],
    );

    var bottomNavigationBar = BottomNavigationBar(
      currentIndex: watch.currentIndex,
      elevation: AppDimension.defaultElevation,
      onTap: (i) => read.onNavigation(i),
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedItemColor: AppColor.primary,
      unselectedItemColor: AppColor.darkGrey,
      selectedLabelStyle: AppStyle.menuLabelStyle,
      unselectedLabelStyle: AppStyle.menuLabelStyle,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: AppConstant.navOne),
        BottomNavigationBarItem(icon: Icon(Icons.sms), label: AppConstant.navTwo),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: AppConstant.navThree),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: AppConstant.navFour),
      ],
    );

    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      appBar: appBar,
      body: body,
    );
  }
}
