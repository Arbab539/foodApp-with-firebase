import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/config/config.dart';
import 'package:foodapp/models/product_model.dart';
import 'package:foodapp/product_providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

class Count extends StatefulWidget {
  final String cartId;
  final String cartImage;
  final String cartName;
  final int cartPrice;

   const Count({
    super.key,
    required this.cartId,
    required this.cartImage,
    required this.cartName,
    required this.cartPrice,

  });

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isTrue = false;

  getAddAndQuantity(){
    FirebaseFirestore.instance.collection('reviewCart')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('YourReviewCart').doc(widget.cartId)
        .get()
        .then((value) {

          if(mounted){
            if(value.exists) {
              setState(() {
                count = value.get('cartQuantity');
                isTrue = value.get('isAdd');
              });
            }
          }
    });
  }

  @override
  Widget build(BuildContext context) {

    getAddAndQuantity();
    ReviewCartProvider reviewCartProvider = Provider.of(context);

    return Container(
      height: 30,
      width: 45,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)
      ),
      child:
      isTrue == true ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: (){
                if(count == 1){
                  setState(() {
                    isTrue = false;
                  });
                  reviewCartProvider.reviewCartDataDelete(widget.cartId);
                }
                else  if(count > 1){

                  setState(() {
                    count--;
                  });
                  reviewCartProvider.updateReviewCartData(
                    cartId: widget.cartId,
                    cartName: widget.cartName,
                    cartImage: widget.cartImage,
                    cartPrice: widget.cartPrice,
                    cartQuantity: count,
                  );
                }
              },
              child: Icon(Icons.remove,size: 15,color: primaryColor,)),
          Text(
            '$count',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                count ++;
              });
              reviewCartProvider.updateReviewCartData(
                cartId: widget.cartId,
                cartName: widget.cartName,
                cartImage: widget.cartImage,
                cartPrice: widget.cartPrice,
                cartQuantity: count,
              );
            },
            child: Icon(
              Icons.add,
              size: 15,
              color: primaryColor,
            ),
          )
        ],
      ):
          Center(
            child: InkWell(
              onTap: (){
                setState(() {
                  isTrue = true;
                });
                reviewCartProvider.addReviewCartData(
                    cartId: widget.cartId,
                    cartName: widget.cartName,
                    cartImage: widget.cartImage,
                    cartPrice: widget.cartPrice,
                    cartQuantity: count,
                );
              },
              child: Text(
                'ADD',
                style: TextStyle(
                    color: primaryColor
                ),
              ),
            ),
          )

    );
  }
}
