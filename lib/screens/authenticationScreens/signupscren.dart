import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearmate/controller/signupcontroller.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _controller = Get.find<SignupController>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var cnfpasswordcontroller = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                Text("Welcome!", style: Get.theme.textTheme.headline2),
                Text(
                  "create your new account",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      controller: namecontroller,
                      validator: (val) {
                        if (!GetUtils.isUsername(val)) {
                          return "pleas enter a valid Name";
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Name",
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
                      controller: emailcontroller,
                      validator: (val) {
                        if (!GetUtils.isEmail(val)) {
                          return "pleas enter a valid Email";
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
                      controller: passwordcontroller,
                      validator: (val) {
                        if (!GetUtils.isLengthGreaterOrEqual(val, 6)) {
                          return "pleas enter a valid password";
                        } else
                          return null;
                      },
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
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      controller: cnfpasswordcontroller,
                      validator: (val) {
                        if (passwordcontroller.text !=
                            cnfpasswordcontroller.text) {
                          return "password does not match";
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Confirm Password",
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
                      signup();
                    },
                    child: Wrap(
                      children: [
                        Text(
                          "SignUp",
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signup() {
    if (formKey.currentState.validate()) {
      _controller.signup(
          emailcontroller.text, passwordcontroller.text, namecontroller.text);
    }
  }
}
