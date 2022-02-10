import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_home/widgets/borders.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  // focusNode: model.nameFocusNode,
                  //validator: validateName2,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color.fromRGBO(55, 59, 94, 1),
                    ),
                    hintText: "Current Password",
                    enabledBorder: enabledBorder,
                    focusedBorder: focusBorder,
                    errorBorder: errorBorder,
                    focusedErrorBorder: errorBorder,
                  ),
                ),
                TextFormField(
                  // focusNode: model.nameFocusNode,
                  //validator: validateName2,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "New Password",
                    enabledBorder: enabledBorder,
                    focusedBorder: focusBorder,
                    errorBorder: errorBorder,
                    focusedErrorBorder: errorBorder,
                  ),
                ),
                TextFormField(
                  // focusNode: model.nameFocusNode,
                  //validator: validateName2,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "New Password,again",
                    enabledBorder: enabledBorder,
                    focusedBorder: focusBorder,
                    errorBorder: errorBorder,
                    focusedErrorBorder: errorBorder,
                  ),
                ),
                Center(
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
                              "Confirm",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
