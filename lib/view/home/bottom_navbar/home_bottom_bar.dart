import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:smart_home/view/home/select_device/select_device.dart';
import 'package:smart_home/view/home/bottom_navbar/bottom_bar_item.dart';
import 'package:smart_home/view/home/home_page/home_page.dart';
import 'package:smart_home/view/home/settings/settings.dart';
import 'package:smart_home/widgets/widgets.dart';
import 'package:double_back_to_close/double_back_to_close.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DoubleBack(child: HomeBottomBar()),
      //DoubleBack(child: MyBottomNavigationBar()),
    );
  }
}

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({Key? key}) : super(key: key);
  @override
  _HomeBottomBarState createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  final List<Widget> pages = [const HomePage(), const Settings()];
  int myindex = 0;
  void onChangedTab(int index) {
    setState(() {
      //this.index = index;
      myindex = index;
    });
  }

  // final String title = "Add";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        leading: IconButton(
            onPressed: () => ZoomDrawer.of(context)!.toggle(),
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            )),
      ),
      backgroundColor: const Color(0xFFecf5fb),

      extendBody: true,
      body: pages[myindex],
      bottomNavigationBar: SingleChildScrollView(
        child: BottomNavigationBar(
            currentIndex: myindex,
            onTap: onChangedTab,
            backgroundColor: const Color(0xFFecf5fb),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              )
            ]),
      ),*/
      extendBody: true,
      body: pages[myindex],
      bottomNavigationBar: TabBarMaterialWidget(
        backgroundColor: kBackgroundColor,
        selectedColor: fontColor,
        color: Colors.grey,
        index: myindex,
        onChangedTab: onChangedTab,
      ),

      // body: pages[index],
      // bottomNavigationBar:  FABBottomAppBar(
      //   centerItemText: 'A',
      //   color: Colors.grey,
      //   selectedColor: Colors.red,
      //   notchedShape: CircularNotchedRectangle(),
      //   onTabSelected: _selectedTab,
      //   items: [
      //     FABBottomAppBarItem(iconData: Icons.menu, text: 'This'),
      //     FABBottomAppBarItem(iconData: Icons.layers, text: 'Is'),
      //     FABBottomAppBarItem(iconData: Icons.dashboard, text: 'Bottom'),
      //     FABBottomAppBarItem(iconData: Icons.info, text: 'Bar'),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SelectDevice())),
        child: const Icon(
          Icons.add,
          color: fontColor,
        ),
        tooltip: "Add Switches",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /* floatingActionButton: RawMaterialButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SelectDevice()));
        },
        elevation: 2.0,
        fillColor: Colors.white,
        child: const Icon(
          Icons.add,
          size: 35.0,
          color: Colors.blue,
        ),
        padding: const EdgeInsets.all(15.0),
        shape: const CircleBorder(
            side: BorderSide(style: BorderStyle.solid, color: Colors.blue)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      */ /* floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SelectDevice())),
        child: const Icon(
          Icons.add,
          color: fontColor,
        ),
        tooltip: "Add Switches",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    */
    );
  }
}
