import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/auth/signin.dart';
import 'package:foodapp/product_providers/user_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../config/config.dart';
import '../../widgets/Drawer.dart';


class ProfileScreen extends StatefulWidget {
  final UserProvider userProvider;
  const ProfileScreen({super.key,required this.userProvider});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget listTitle(IconData iconData, String title){
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(iconData),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios),
        )
      ],
    );

  }

  Future<void> googleSignOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await googleSignIn.signOut();
      await auth.signOut();
    } catch (error) {
      print("Error signing out with Google: $error");
    }
  }

  @override
  Widget build(BuildContext context) {

    var userData = widget.userProvider.currentUserData;

    return Scaffold(
      backgroundColor: primaryColor,
      drawer: DrawerScreen(userProvider: widget.userProvider,),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: textColor
        ),
        elevation: 0.0,
        title: Text(
            'My Profile',
        style: TextStyle(
            fontSize: 17,
            color: textColor,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  color: primaryColor,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 80,
                            width: 280,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        userData.userName,
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold
                                    ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(userData.userEmail),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: primaryColor,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: scaffoldBackgroundColor,
                              child: Icon(Icons.edit),
                            ),
                          )
                        ],
                      ),
                      listTitle(Icons.shop_outlined, 'My orders'),
                      listTitle(Icons.location_on_outlined, 'My Delivery Address'),
                      listTitle(Icons.person_outline, 'Refer A friends'),
                      listTitle(Icons.copy, 'Terms and Conditions'),
                      listTitle(Icons.policy_outlined, 'Privacy Policy'),
                      listTitle(Icons.add_chart, 'About'),
                      GestureDetector (
                          onTap: () async{
                            await googleSignOut().then((value) {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                            }).onError((error, stackTrace) {
                              print(error);
                            });
                          },
                          child: listTitle(Icons.exit_to_app_outlined, 'Log out',)),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 50,
                left: 20,
                child: CircleAvatar(
                radius: 50,
                backgroundColor: scaffoldBackgroundColor,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: primaryColor,
                  backgroundImage: NetworkImage(
                      userData.userImage ??
                          'https://essentiala3.pl/public/assets/Logo_V-Label_2.svg.png'),
                ),
                )
            )
          ],
        ),
      ),
    );
  }
}

