import 'package:flutter/material.dart';
import 'package:spiny001/Common/Constant.dart';
class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return
      Drawer(
        backgroundColor:appColor,
        child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildMenuItems(context),
        ],
      ),
    );
  }
  Widget buildMenuItems(BuildContext context) =>
      Container(
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(16)
        ),
        padding: EdgeInsets.only(left: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             ListTile(
              leading: Icon(
                Icons.home, color: Colors.black,
              ),
              title: Text(
                "Home",
              ),
              onTap: () {
                //Get.back();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.list,
              ),
            title: Text(
             "Listing",
             ),
              onTap: () {
                // Get.to(() => Listing());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.chat,
              ),
              title: Text(
                 "Customer Questions",
              ),
              onTap: () {
                // debugPrint(userName);

                // Get.to(());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.payments,
              ),
              title: Text(
                "Payments",
                //   fontsize: 13,
              ),
              onTap: () {
                //Get.to(() => PaymentsScreen());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_bag,
              ),
              title: Text(
                "Sell More",
              ),
              onTap: () {
                // Get.to(() => Sell_More());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.tv,
              ),
              title: Text(
                "Advertising",
              ),
              onTap: () {
                //  Get.to(());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.mail_outline_outlined,
              ),
              title: Text(
                "My Tickets",
              ),
              onTap: () {
                // Get.to(() => Ticket());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.chat_outlined,
              ),
              title: Text(
                "Send FeedBack",
              ),
              onTap: () {
                // Get.to(() => FeedBack());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
              ),
              title: Text(
                "Log Out",
                //fontsize: 13,
              ),
              onTap: () {
                // logOut();
                // debugPrint('$auth.currentUser');
              },
            ),
          ],
        ),
      );
}