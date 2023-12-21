import 'package:flutter/material.dart';
import 'package:foodapp/config/config.dart';
import 'package:foodapp/product_providers/product_provider.dart';
import 'package:foodapp/product_providers/user_provider.dart';
import 'package:foodapp/screens/search/Search_screen.dart';
import 'package:foodapp/widgets/Drawer.dart';
import 'package:foodapp/widgets/SingleProduct.dart';
import 'package:provider/provider.dart';

import '../review_card_screen/review_card_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductProvider productProvider;

  @override
  void initState() {
    // TODO: implement initState
    productProvider = Provider.of(context,listen: false);
    productProvider.fetchHerbsProductData();
    productProvider.fetchFreshProductData();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {

    productProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();

    return Scaffold(
      drawer: DrawerScreen(userProvider: userProvider,),
      appBar: AppBar(
        title: Text('Home',style: TextStyle(fontSize: 18),),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: appBarIconBackgroundColor,
              ),
              IconButton(
                icon: Icon(Icons.search, size: 17, color: Colors.black),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(search: productProvider.getAllProductSearch,)));
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0.0,right: 10),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewCardScreen()));

              },
              child: CircleAvatar(
                radius: 12,
                backgroundColor: appBarIconBackgroundColor,
                child: Icon(Icons.shop,size: 17,color: Colors.black,),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('https://thumbs.dreamstime.com/z/food-background-fresh-vegetables-dark-54304897.jpg?w=992'),
                    ),
                        color: Colors.red
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 120.0),
                                  child: Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(50),
                                        bottomLeft: Radius.circular(50),
                                      )
                                    ),
                                    child: Center(
                                      child: Text(
                                        'vegi',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            BoxShadow(
                                              color: Colors.green,
                                              blurRadius: 5,
                                              offset: Offset(3, 3),
                                            )
                                          ]
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                    '30% off',
                                  style: TextStyle(
                                    color: Colors.green[100],
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 23.0),
                                  child: Text(
                                    'on all vegetables products',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          )
                      ),
                      Expanded(
                          child: Container()
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Herbs Seasonings',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(
                           search: productProvider.getHerbsProductData,)));
                       },
                        child: Text(
                          'view all',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: productProvider.getHerbsProductData.map((herbsProductData){
                      return SingleProduct(
                              productId: herbsProductData.productId,
                              productImage: herbsProductData.productImage,
                              productName: herbsProductData.productName,
                              productPrice: herbsProductData.productPrice,
                              productQuantity: 12,

                               );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fresh Fruits',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(
                            search: productProvider.getFreshProductDataList,)));
                        },
                        child: Text(
                          'view all',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: productProvider.getFreshProductDataList.map((freshfruit){
                      return  SingleProduct(
                        productImage: freshfruit.productImage,
                        productName: freshfruit.productName,
                        productPrice: freshfruit.productPrice,
                        productId: freshfruit.productId,
                        productQuantity: 12,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


