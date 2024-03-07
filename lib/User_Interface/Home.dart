import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:spiny001/Common/Bold_Text.dart';
import 'package:spiny001/Common/Constant.dart';
import 'package:spiny001/Common/Count_Down.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<int> Sectors = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
  List<double> sectorRadians = [];
  double angle = 0;
  int randomSectorindex = -1;
  bool spinning = false;
  int earnedvalue = 0;
  int totalEarning = 0;
  int spins = 0;
  int selectedAmount = 0;
  List<int> lastFiveValues = [];
  TimerService? timerService;
  String countdownText = '';
  math.Random random = math.Random();
  void placeBet(int amount) {
    setState(() {
      selectedAmount = amount;
    });
  }

  late AnimationController controller;
  late Animation<double> animation;
  void startTimer() {
    timerService = TimerService(
      onTick: (seconds) {
        setState(() {
          countdownText = ' $seconds ';
        });
      },
      onComplete: () {
        controller.reset();
        controller.forward();
        Future.delayed(Duration(seconds: 7), () {
          timerService?.restartTimer();
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    generateSectorRadians();
    startTimer();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    Tween<double> tween = Tween<double>(begin: 0, end: 1);
    CurvedAnimation curve = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );
    animation = tween.animate(curve);
    controller.addListener(() {
      if (controller.isCompleted) {
        setState(() {
          recordStats();
          spinning = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    print("build");
    return Scaffold(

      backgroundColor: appColor,
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                "Assets/Images/1.png",
                fit: BoxFit.cover,
              )),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: size.height * 0.65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: BoldText(
                                        name: "Number Got",
                                        fontsize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "Assets/Images/4.png"),
                                            height: 35,
                                            fit: BoxFit.fill,
                                            width: 150,
                                          ),
                                          Positioned(
                                            child: BoldText(
                                                name: "$earnedvalue",
                                                fontsize: 20,
                                                color: Colors.brown),
                                          ),
                                        ]),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: BoldText(
                                        name: "Time",
                                        fontsize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "Assets/Images/4.png"),
                                            height: 35,
                                            fit: BoxFit.fill,
                                            width: 150,
                                          ),
                                          Positioned(
                                            child: Text(
                                              "$countdownText",
                                              style: (TextStyle(
                                                  color: Colors.brown,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                            ),
                                          ),
                                        ]),
                                    Container(
                                      height: 30,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow.withOpacity(0.6),
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.7),
                                            child: Text("10"),
                                          ),
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                Colors.red.withOpacity(0.7),
                                            child: Text("20"),
                                          ),
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                Colors.green.withOpacity(0.7),
                                            child: Text("50"),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.14,
                                    )
                                  ]),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      InkWell(
                                        child: AnimatedBuilder(
                                          animation: animation,
                                          builder: (context, child) {
                                            return Transform.rotate(
                                              angle: controller.value * angle,
                                              child: Container(
                                                height: size.height * 0.59,
                                                width: size.height * 1.01,
                                                child: Image(
                                                  image: AssetImage(
                                                      "Assets/Images/Spin-wheel copy.png"),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        onTap: () {
                                          setState(() {
                                            spinning = true;
                                          });
                                          spin();
                                        },
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        child: Container(
                                          width: 350,
                                          height: size.height * 0.2,
                                          child: Image(
                                            image: AssetImage(
                                                "Assets/Images/money.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                         left:size.height*0.4,
                                        top:size.height*0.012,
                                        child: Transform.rotate(
                                          angle: -25 * (3.1415926535 /
                                                  180),
                                          child: Image(
                                            image: AssetImage(
                                                "Assets/Images/arrow.png"),
                                            height: 30,
                                            fit: BoxFit.fill,
                                            width: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  BoldText(
                                    name: "Total Spin",
                                    fontsize: 20,
                                    color: Colors.white,
                                  ),
                                  Stack(alignment: Alignment.center, children: [
                                    Image(
                                      image: AssetImage("Assets/Images/4.png"),
                                      height: 35,
                                      fit: BoxFit.fill,
                                      width: 150,
                                    ),
                                    Positioned(
                                      child: BoldText(
                                          name: "   $spins",
                                          fontsize: 20,
                                          color: Colors.brown),
                                    ),
                                  ]),
                                  BoldText(
                                    name: "Last 5 Data",
                                    fontsize: 20,
                                    color: Colors.white,
                                  ),
                                  Stack(children: [
                                    Image(
                                      image: AssetImage("Assets/Images/4.png"),
                                      height: 35,
                                      fit: BoxFit.fill,
                                      width: 150,
                                    ),
                                    Positioned(
                                      right: 20,
                                      child: Row(
                                        children: lastFiveValues.map((value) {
                                          return BoldText(
                                            name: " $value,",
                                            fontsize: 20,
                                            color: Colors.brown,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ]),
                                  Container(
                                    height: 35,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow.withOpacity(0.8),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Colors.grey,
                                          child: Text("100"),
                                        ),
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              Colors.red.withOpacity(0.7),
                                          child: Text("200"),
                                        ),
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              Colors.green.withOpacity(0.7),
                                          child: Text("500"),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.14,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 190,
                        left: 0,
                        right: 0,
                        child: Container(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image(
                                image: AssetImage("Assets/Images/Asset 2.png"),
                              ),
                              Image(
                                height: 65,
                                width: 400,
                                image: AssetImage("Assets/Images/Asset 3.png"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(alignment: Alignment.center, children: [
                        Image(
                          image: AssetImage("Assets/Images/3.jpg"),
                          height: 32,
                          fit: BoxFit.fill,
                          width: 130,
                        ),
                        BoldText(
                            name: "Take", fontsize: 28, color: Colors.white),
                      ]),
                      Stack(alignment: Alignment.center, children: [
                        Image(
                          image: AssetImage("Assets/Images/3.jpg"),
                          height: 32,
                          fit: BoxFit.fill,
                          width: 130,
                        ),
                        BoldText(
                            name: "Cancel", fontsize: 20, color: Colors.white),
                      ]),
                      Stack(alignment: Alignment.center, children: [
                        Image(
                          image: AssetImage("Assets/Images/3.jpg"),
                          height: 32,
                          fit: BoxFit.fill,
                          width: 130,
                        ),
                        BoldText(
                            name: "Specific",
                            fontsize: 20,
                            color: Colors.white),
                      ]),
                      Stack(alignment: Alignment.center, children: [
                        Image(
                          image: AssetImage("Assets/Images/3.jpg"),
                          height: 32,
                          fit: BoxFit.fill,
                          width: 130,
                        ),
                        BoldText(
                            name: "Bet Ok", fontsize: 28, color: Colors.white),
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.06,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(onTap: () {}, child: buildContainer("0")),
                        InkWell(onTap: () {}, child: buildContainer("1")),
                        InkWell(onTap: () {}, child: buildContainer("2")),
                        InkWell(onTap: () {}, child: buildContainer("3")),
                        InkWell(onTap: () {}, child: buildContainer("4")),
                        InkWell(onTap: () {}, child: buildContainer("5")),
                        InkWell(onTap: () {}, child: buildContainer("6")),
                        InkWell(onTap: () {}, child: buildContainer("7")),
                        InkWell(onTap: () {}, child: buildContainer("8")),
                        InkWell(onTap: () {}, child: buildContainer("9")),
                      ]),
                  SizedBox(
                    height: size.height * 0.02,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void generateSectorRadians() {
    double sectorRadian = 2 * math.pi / Sectors.length;
    for (int i = 0; i < Sectors.length; i++) {
      sectorRadians.add((i + 1) * sectorRadian);
    }
  }

  void recordStats() {
    if (randomSectorindex >= 0 && randomSectorindex < Sectors.length) {
      earnedvalue = Sectors[Sectors.length - (randomSectorindex + 1)];
      lastFiveValues.add(earnedvalue);

      // Keep only the last five values
      if (lastFiveValues.length > 5) {
        lastFiveValues.removeAt(0);
      }

      spins = spins + 1;
    }
  }

  void spin() {
    randomSectorindex = random.nextInt(Sectors.length);
    double randomRadian = generateRandomRadianToSpinTo(randomSectorindex);
    controller.reset();
    angle = randomRadian;
    controller.forward();
  }

  double generateRandomRadianToSpinTo(int sectorIndex) {
    return (2 * math.pi * Sectors.length) + sectorRadians[sectorIndex];
  }

  buildContainer(String text) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.orangeAccent.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: BoldText(
        name: text,
        fontsize: 18,
        color: Colors.white,
      )),
      height: 45,
      width: 60,
    );
  }
}
