import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:nearmate/controller/conversationcontroller.dart';
import 'package:nearmate/controller/signupcontroller.dart';
import 'package:nearmate/screens/authenticationScreens/authhandler.dart';
import 'package:nearmate/screens/authenticationScreens/loginscreen.dart';
import 'package:nearmate/screens/authenticationScreens/signupscren.dart';
import 'package:nearmate/screens/chatscrens/conversationscreen.dart';
import 'controller/logincontroller.dart';
import 'screens/wizardsScreens/firstwizard.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily:
              GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w700)
                  .fontFamily,
          textTheme: TextTheme(
            headline1: headline1(),
            headline2: headline2(),
          ),
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0.0,
              centerTitle: true,
              textTheme: TextTheme(
                headline6: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              titleTextStyle: TextStyle(color: Colors.black),
              toolbarTextStyle: TextStyle(color: Colors.black)),
          primaryColor: Color(0xFF10AC22)),
      initialRoute: "/root",
      getPages: [
        GetPage(
            name: "/login",
            page: () => LoginScreen(),
            binding:
                BindingsBuilder(() => Get.lazyPut(() => LoginController()))),
        GetPage(
            name: "/signup",
            page: () => SignupScreen(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => SignupController());
            })),
        GetPage(
            name: "/conversationscreen",
            page: () => ConversationScreen(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => ConversationController());
            })),
        GetPage(
            name: "/root",
            page: () => AuthHandler(),
            binding: BindingsBuilder(() => Get.lazyPut<AuthHandleController>(
                () => AuthHandleController()))),
      ],
    );
  }

  TextStyle headline1() {
    return TextStyle(
        fontSize: 54,
        fontWeight: FontWeight.bold,
        color: Color(0xFF10AC22),
        fontFamily: 'assets/fonts/Uni Sans Heavy.otf',
        shadows: [
          BoxShadow(
              color: Colors.black.withOpacity(0.0),
              offset: Offset(10, 10),
              blurRadius: 10,
              spreadRadius: 1)
        ],
        decoration: TextDecoration.none);
  }

  TextStyle headline2() {
    return TextStyle(
        fontSize: 40,
        color: Colors.black,
        fontFamily: GoogleFonts.architectsDaughter().fontFamily);
  }
}
