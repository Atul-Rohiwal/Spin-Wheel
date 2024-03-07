import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:spiny001/Common/Bold_Text.dart';
import 'package:spiny001/User_Interface/Main.dart';
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children:[ Container(
        height: double.infinity,
          width: double.infinity,
          child: Image(
            image: AssetImage("Assets/Images/Login01.jpeg"),
            fit: BoxFit.cover,
          ),
      ),
     Positioned(
       bottom: 100,
   right: size.height *0.25,
       child: TextButton(onPressed: (){
         Get.to(() =>MainPage());
       }, child: Stack(
         alignment: Alignment.center,
         children:[ Image.asset("Assets/Images/button.png",
         height: 55,
           width: 100,
           ),
           BoldText(name: "Login", fontsize: 20,color: Colors.white,)
           ]
       )),
     )

      ]
    );
  }
}
