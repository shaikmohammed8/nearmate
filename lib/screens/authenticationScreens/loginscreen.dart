import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';
import 'package:nearmate/controller/logincontroller.dart';
import 'package:nearmate/utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var _ctroller = Get.find<LoginController>();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        width: double.infinity,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DecoratedIcon(
                  Icons.near_me,
                  color: Get.theme.primaryColor,
                  size: 80,
                  shadows: [
                    BoxShadow(
                        blurRadius: 6,
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(6, 12))
                  ],
                ),
                Text("Welcome Back!", style: Get.theme.textTheme.headline2),
                Text(
                  "Log into your account",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      controller: emailcontroller,
                      validator: (val) {
                        if (!GetUtils.isLengthGreaterOrEqual(val, 6)) {
                          return "please enter valid email";
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "Email",
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey),
                          fillColor: Colors.grey[300],
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordcontroller,
                      validator: (val) {
                        if (!GetUtils.isLengthGreaterOrEqual(val, 6)) {
                          return "please enter correct password";
                        } else
                          return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Password",
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey),
                          fillColor: Colors.grey[300],
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: Wrap(
                      children: [
                        Text(
                          "login",
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.fast_forward_rounded)
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 10,
                        primary: Get.theme.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Divider(
                      color: Colors.black45,
                      thickness: 1,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.grey[50],
                        child: Text('Or'))
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/download.png"),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/download (1).png"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState.validate()) {
      _ctroller.login(emailcontroller.text, passwordcontroller.text);
    }
  }
}
