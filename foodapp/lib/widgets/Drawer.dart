import 'package:flutter/material.dart';
import 'package:foodapp/config/config.dart';
import 'package:foodapp/screens/home/homescreen.dart';
import 'package:foodapp/screens/profile_screen/profile_screen.dart';
import 'package:foodapp/screens/wish_list_screen/wish_list.dart';

import '../product_providers/user_provider.dart';
import '../screens/review_card_screen/review_card_screen.dart';

class DrawerScreen extends StatefulWidget {
  final UserProvider userProvider;
  const DrawerScreen({super.key,required this.userProvider});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  Widget listTile({
    required IconData icon,
    required String title,
    required Function() onTap
  }){
    return ListTile(
      leading: Icon(
          icon,
      size: 32,
      ),
      title: Text(
        title,
      style: TextStyle(color: Colors.black45),
      ),
      onTap: onTap,
    );

  }

  @override
  Widget build(BuildContext context) {

    var userData = widget.userProvider.currentUserData;

    return Drawer(
      child: Container(
        color: primaryColor,
        child: ListView(
          children: [
            DrawerHeader(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 43,
                        backgroundColor: Colors.white54,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.red,
                          backgroundImage: NetworkImage(
                            userData.userImage
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(userData.userName),
                          Text(
                              userData.userEmail,
                              overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
            ),

            listTile(
                icon: Icons.home_outlined,
                title: 'Home',
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                },
            ),
            listTile(
              icon: Icons.shop_outlined,
              title: 'Review Cart',
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewCardScreen()));
              },
            ),
            listTile(
              icon: Icons.person_outline,
              title: 'My Profile',
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder:
                        (context)=>ProfileScreen(userProvider: widget.userProvider,)));
              },
            ),
            listTile(
              icon: Icons.notifications_none_outlined,
              title: 'Notification',
              onTap: (){},
            ),
            listTile(
              icon: Icons.star_outline,
              title: 'Rating & Review',
              onTap: (){},
            ),
            listTile(
              icon: Icons.favorite_border,
              title: 'Wishlist',
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WishListScreen()));
              },
            ),
            listTile(
              icon: Icons.copy,
              title: 'Raise & Categories',
              onTap: (){},
            ),
            listTile(
              icon: Icons.format_quote_outlined,
              title: 'FAQs',
              onTap: (){},
            ),
            Container(
              height: 250,
              margin: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact Support'),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Call us:'),
                      SizedBox(width: 5,),
                      Text('+923250787728'),
                    ],
                  ),
                  SizedBox(height: 7,),
                  Row(
                    children: [
                      Text('Mail us:'),
                      SizedBox(width: 5,),
                      Text('arbabprince@gmail.com'),
                    ],
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
