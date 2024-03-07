   import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spiny001/User_Interface/Home.dart';
import 'package:flutter/services.dart';
import 'package:spiny001/User_Interface/Login.dart';
import 'package:spiny001/User_Interface/Main.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
    runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      getPages: [
        GetPage(name: '/main', page: () => MainPage()),
        GetPage(name: '/Home', page: () => Home()),
      ],
    ));
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Login(),
    );
  }
}