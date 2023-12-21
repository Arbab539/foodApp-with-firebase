import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/config/config.dart';
import 'package:foodapp/product_providers/wish_list_provider.dart';
import 'package:foodapp/screens/review_card_screen/review_card_screen.dart';
import 'package:foodapp/widgets/count.dart';
import 'package:provider/provider.dart';


enum SignInCharacter{fill,outLine}

class ProductOverView extends StatefulWidget {
  final String productName;
  final String productImage;
  final String productId;
  final int productPrice;

  const ProductOverView({
    super.key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productId,
  });



  @override
  State<ProductOverView> createState() => _ProductOverViewState();
}

class _ProductOverViewState extends State<ProductOverView> {

  SignInCharacter _signInCharacter = SignInCharacter.fill;

  Widget bottomNavigationBar({
    required Function() onTap,
    required Color color,
    required Color iconColor,
    required Color backgroundColor,
    required String title,
    required IconData iconData,
}){
    return Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(20),
            color: backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  size: 20,
                  color: iconColor,
                ),
                SizedBox(width: 5,),
                Text(
                  title,
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        )
    );
  }

  bool wishList = false;

  getWishList(){
    FirebaseFirestore.instance
        .collection('wishList')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('YourWishList').doc(widget.productId)
        .get()
        .then((value) {
         if(mounted){
           if(value.exists){
           setState(() {
             wishList = value.get('wishList');
           });
         }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    getWishList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Product OverView'),
      ),
      bottomNavigationBar: Row(
        children: [
          bottomNavigationBar(
              color: Colors.white70,
              iconColor: Colors.grey,
              backgroundColor: textColor,
              title: 'Add To WishList',
              iconData: wishList==false?Icons.favorite_outline:Icons.favorite,
              onTap: () {
                setState(() {
                  wishList = !wishList;
                });
                if(wishList == true){
                  wishListProvider.addWishListData(
                      wishListId: widget.productId,
                      wishListName: widget.productName,
                      wishListImage: widget.productImage,
                      wishListPrice: widget.productPrice,
                      wishListQuantity: 2,
                  );
                }
                else{
                  wishListProvider.deleteWishList(widget.productId);
                }
              }
          ),
          bottomNavigationBar(
              color: Colors.white70,
              iconColor: textColor,
              backgroundColor: primaryColor,
              title: 'Go To Cart',
              iconData: Icons.share_outlined,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewCardScreen()));
              }
          ),
        ],
      ),
      body: ListView(
        children: [
          Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                       ListTile(
                        title: Text(widget.productName),
                        subtitle: Text('${widget.productPrice}\$'),
                      ),
                    Container(
                      height: 250,
                      padding: EdgeInsets.all(40),
                      child: Image.network(widget.productImage),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Available Options',
                        textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                      ),
                    ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child:
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 3,
                      backgroundColor: Colors.green[700],
                    ),
                    Radio(
                        activeColor: Colors.green[700],
                        value: SignInCharacter.fill,
                        groupValue: _signInCharacter,
                        onChanged: (value){
                          setState(() {
                            _signInCharacter = value!;
                          });
                        }
                    )
                  ],
                ),
                Text('\$${widget.productPrice}'),
                Count(
                    cartId: widget.productId,
                    cartImage: widget.productImage,
                    cartName: widget.productName,
                    cartPrice: widget.productPrice,
                ),
              ],
            ),
    ),
    ],

                ),
              ),
          ),
          
          
          Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About this Product',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'A product description is the marketing copy that explains what a product is'
                          ' and why it’s worth purchasing. The purpose of a product description is to supply customers'
                          ' with important information about the features and benefits of the product so they’re compelled to buy ',
                 style: TextStyle(
                   fontSize: 17,
                   color: textColor,
                 ),
                    )
                  ],
                ),
              ),
          ),
        ],
      )
    );
  }
}
