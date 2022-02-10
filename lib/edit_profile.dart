import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_home/services/auth.dart';
import 'package:smart_home/services/database.dart';
import 'package:smart_home/view/home/menu_widget.dart';

import 'models/users.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? _pickedImage;

  final picker = ImagePicker();
  void _fromGallery() async {
    //final picker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      if (pickedImageFile != null) {
        _pickedImage = pickedImageFile;
      }
    });
  }

  void _fromCamera() async {
    //final picker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      if (pickedImageFile != null) {
        _pickedImage = pickedImageFile;
      }
    });
  }

  void _remove() async {
    //final picker = ImagePicker();
    // ignore: deprecated_member_use
    setState(() {
      _pickedImage = null;
    });
  }

  ImageProvider img = const AssetImage("assets/images/forget_pass.jpg");

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);

    return Scaffold(
        backgroundColor: const Color(0xFFecf5fb),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Edit Profile",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green.shade700,
          elevation: 0,

          // title: Text('Profile', style: TextStyle(color: Colors.black)),
        ),
        //title: Text("Profile"),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            // scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 150,
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: CustomShape(),
                        child: Container(
                          height: 150,
                          color: Colors.green.shade700,
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.purple, width: 5),
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: _pickedImage == null
                                            ? img
                                            : FileImage(_pickedImage!),
                                        fit: BoxFit.cover)),
                              ),
                            ),

                            /*Container(
                              padding: EdgeInsets.all(10.0),
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.purple, width: 5),
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: _pickedImage == null
                                          ? img
                                          : FileImage(_pickedImage!),
                                      fit: BoxFit.fill)),
                            ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Wrap(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    _fromCamera();
                                  },
                                  //_fromCamera,
                                  leading: Icon(Icons.camera),
                                  title: Text('Take a photo'),
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    _fromGallery();
                                  },
                                  leading: Icon(Icons.image),
                                  title: Text('Choose from gallery'),
                                ),
                                ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    _remove();
                                  },
                                  leading: Icon(Icons.delete_rounded),
                                  title: Text('Remove photo'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text("change profile photo",
                          style: TextStyle(
                              color: Colors.blue.shade300,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Text(
                        "Username",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                showUserName(db),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 14),
                      child: Text(
                        "E-mail",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                showEmail(db),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      borderOnForeground: false,
                      color: Colors.purple.shade900,
                      elevation: 5,
                      child: SizedBox(
                        height: 7.h,
                        width: 50.w,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const <Widget>[
                              Text(
                                "Save Profile ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.2,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget showUserName(
    Database db,
  ) {
    final id = Provider.of<AuthBase>(context, listen: false).user!.uid;
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14),
      child: Row(
        children: <Widget>[
          StreamBuilder<Users?>(
            stream: db.getUser(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return Expanded(
                  child: TextField(
                    //textAlign: TextAlign.center,
                    //decoration: InputDecoration(border: InputBorder.none),
                    enabled: true,
                    controller: TextEditingController(
                      text: snapshot.data!.name,
                    ),
                  ),
                  /*Text(
                      snapshot.data!.name,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),*/
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("");
              } else {
                return const Text("");
              }
            },
          ),
        ],
      ),
    );
  }

  Widget showEmail(
    Database db,
  ) {
    final id = Provider.of<AuthBase>(context, listen: false).user!.uid;
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14),
      child: Row(
        children: <Widget>[
          StreamBuilder<Users?>(
            stream: db.getUser(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return Expanded(
                  child: TextField(
                    //textAlign: TextAlign.center,
                    //decoration: InputDecoration(border: InputBorder.none),
                    enabled: true,
                    controller:
                        TextEditingController(text: snapshot.data!.email),
                  ),
                  /*Text(
                      snapshot.data!.name,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),*/
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("");
              } else {
                return const Text("");
              }
            },
          ),
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
