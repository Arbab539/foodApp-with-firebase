import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/auth/signin.dart';
import 'package:foodapp/config/config.dart';
import 'package:foodapp/product_providers/checkout_provider.dart';
import 'package:foodapp/product_providers/product_provider.dart';
import 'package:foodapp/product_providers/review_cart_provider.dart';
import 'package:foodapp/product_providers/user_provider.dart';
import 'package:foodapp/product_providers/wish_list_provider.dart';
import 'package:foodapp/screens/home/homescreen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
    ChangeNotifierProvider<ProductProvider>(
    create: (context)=> ProductProvider(),
    ),
    ChangeNotifierProvider<UserProvider>(
    create: (context) => UserProvider(),
    ),
      ChangeNotifierProvider<ReviewCartProvider>(
        create: (context) => ReviewCartProvider(),
      ),
      ChangeNotifierProvider<WishListProvider>(
        create: (context) => WishListProvider(),
    ),
       ChangeNotifierProvider<CheckOutProvider>(
        create: (context) => CheckOutProvider(),
      )

    ],
    child: MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    iconTheme: IconThemeData(
    color: textColor,
    ),
    titleTextStyle: TextStyle(
    color: textColor,
    fontSize: 18,
    )
    )
    ),
    home: StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator(); // Show a loading indicator.
    } else if (snapshot.hasError) {
    return Text("Error: ${snapshot.error}");
    } else if (snapshot.hasData) {
    // User is authenticated, navigate to HomeScreen.
    return HomeScreen();
    } else {
    // User is not authenticated, navigate to SignIn.
    return SignInScreen();
    }
    }
    )


    )
    );
  }
}


