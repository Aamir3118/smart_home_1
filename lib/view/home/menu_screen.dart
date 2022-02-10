import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_home/models/users.dart';
import 'package:smart_home/services/auth.dart';
import 'package:smart_home/services/database.dart';
import 'package:smart_home/view/home/menu_item.dart';

class MenuItems {
  static const home = MenuItem('Home', Icons.home);
  static const profile = MenuItem('Profile', Icons.person);
  static const devices = MenuItem('Devices', Icons.devices);
  static const notifications = MenuItem('Notifications', Icons.notifications);
  static const settings = MenuItem('Settings', Icons.settings);

  static const all = <MenuItem>[
    home,
    profile,
    devices,
    notifications,
    settings,
  ];
}

class MenuScreen extends StatefulWidget {
  const MenuScreen(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    final id = Provider.of<AuthBase>(context, listen: false).user!.uid;

    return Scaffold(
      //backgroundColor: Colors.blue,
      body: SafeArea(
          child: Theme(
        data: ThemeData.dark(),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                0.3,
                0.5,
                1
              ],
                  colors: [
                Colors.blue.shade900,
                Colors.blue.shade400,
                Colors.teal.shade100
              ])),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                      child: CircleAvatar(
                        radius: 30,
                        //child: Image.file(_pickedImage!),
                        backgroundColor: Colors.white,
                      ),
                      padding: EdgeInsets.only(top: 20, left: 20)),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.only(left: 18),
                    child: showUserName(db),
                    //child: Text(
                    // "user",
                    //style: TextStyle(fontSize: 18),
                    //),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ...MenuItems.all.map(buildMenuItem).toList(),
                  //Spacer(flex: 2),
                ]),
          ),
        ),
      )),
    );
  }

  Widget showUserName(Database db) {
    final id = Provider.of<AuthBase>(context, listen: false).user!.uid;
    return Row(
      children: <Widget>[
        StreamBuilder<Users?>(
          stream: db.getUser(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              return Expanded(
                child: Text(
                  snapshot.data!.name,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("");
            } else {
              return const Text("");
            }
          },
        ),
      ],
    );
  }

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
        //selectedTileColor: Colors.grey,
        child: ListTile(
          selectedColor: Colors.white,
          iconColor: Colors.white54,
          textColor: Colors.white54,
          // selectedTileColor: Colors.black26,
          selected: widget.currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(item.icon),
          title: Text(item.title),
          onTap: () => widget.onSelectedItem(item),
        ),
      );
}
