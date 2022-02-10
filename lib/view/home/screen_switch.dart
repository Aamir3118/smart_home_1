import 'package:flutter/material.dart';
import 'package:smart_home/profile.dart';
import 'package:smart_home/view/home/bottom_navbar/home_bottom_bar.dart';
import 'package:smart_home/view/home/home_page/home_page.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:smart_home/view/home/menu_item.dart';
import 'package:smart_home/view/home/menu_screen.dart';
import 'package:smart_home/view/home/notification/notification.dart';
import 'package:smart_home/view/home/select_device/select_device.dart';
import 'package:smart_home/view/home/settings/settings.dart';

class Screen_Switchh extends StatefulWidget {
  const Screen_Switchh({Key? key}) : super(key: key);

  @override
  _Sceen_SwitchhState createState() => _Sceen_SwitchhState();
}

class _Sceen_SwitchhState extends State<Screen_Switchh> {
  MenuItem currentItem = MenuItems.home;
  ZoomDrawerController controller = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      borderRadius: 20, slideWidth: 250.5,

      duration: Duration(milliseconds: 500),
      angle: -15.0, mainScreenTapClose: true,
      //controller: controller,
      //slideWidth: MediaQuery.of(context).size.width * 0.65,
      boxShadow: [BoxShadow(color: Colors.white)],
      backgroundColor: Colors.white24,
      style: DrawerStyle.Style1,
      showShadow: true,
      mainScreen: getScreen(),

      menuScreen: Builder(
        builder: (context) => MenuScreen(
            currentItem: currentItem,
            onSelectedItem: (item) {
              setState(() => currentItem = item);
              ZoomDrawer.of(context)!.close();
            }),
      ),
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.home:
        return MainScreen();
      case MenuItems.profile:
        return Profile();
      case MenuItems.devices:
        return SelectDevice();
      case MenuItems.notifications:
        return Notifications();
      case MenuItems.settings:
        return Settings();
      default:
        return MainScreen();
    }
  }
}
