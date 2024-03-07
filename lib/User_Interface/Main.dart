import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spiny001/User_Interface/Home.dart';
import 'package:get/get.dart';
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Image
            Image.asset(
              'Assets/Images/main.jpg',
              fit: BoxFit.fill,
            ),
            // Overlay Image in the Center
            Positioned(
              child: InkWell(
                child: Image.asset(
                  'Assets/Images/spiny022.jpg',
                  height: 100,
                  width: 100,
                ),
                onTap: () {
                  Get.to(() => Home());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
