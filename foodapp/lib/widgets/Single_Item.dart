import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/config/config.dart';
import 'package:provider/provider.dart';

import '../product_providers/review_cart_provider.dart';
import 'count.dart';
class SingleItem extends StatefulWidget {
  final bool isBool;
  final bool wishList;
  final String productImage;
  final String productName;
  final String productId;
  final int productPrice;
  final int productQuantity;
  final Function() onDelete;


   const SingleItem({
    super.key,
    this.isBool=false,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productId,
    required this.onDelete,
    required this.wishList,
    required this.productQuantity,
  });

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  late int count ;
  getCount(){
    setState((){
      count = widget.productQuantity;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getCount();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                    height: 100,
                    child: Center(
                      child: Image.network(widget.productImage),
                    ),
                  )
              ),
              Expanded(
                  child: Container(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: widget.isBool == false
                          ? MainAxisAlignment.spaceAround
                          : MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.productName,
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text('${widget.productPrice}\$',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        widget.isBool == false
                            ? GestureDetector(
                          onTap:(){
                            showModalBottomSheet(
                              context: context,
                              builder: (context){
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: Text('50 Gram'),
                                      onTap: (){
                                        Navigator.of(context);
                                      },
                                    ),
                                    ListTile(
                                      title: Text('500 Gram'),
                                      onTap: (){
                                        Navigator.of(context);
                                      },
                                    ),
                                    ListTile(
                                      title: Text('1 kg'),
                                      onTap: (){
                                        Navigator.of(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 15),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 35,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      '50 Gram',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14
                                      ),
                                    )
                                ),
                                Center(
                                  child: Icon(Icons.arrow_drop_down,size: 20,color: primaryColor,),
                                )
                              ],
                            ),
                          ),
                        ) :Text('50 Gram'),
                      ],
                    ),
                  )
              ),
              Expanded(
                  child: Container(
                    height: 100,
                    padding:widget.isBool== false? EdgeInsets.symmetric(horizontal: 15,vertical: 32) : EdgeInsets.only(left: 15,right: 15),
                    child: widget.isBool == false
                        ? Count(
                               cartId: widget.productId,
                                cartImage: widget.productImage,
                                cartName: widget.productName,
                                cartPrice: widget.productPrice,
                     ):Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          InkWell(
                              onTap: (){
                                widget.onDelete();
                              },
                              child: Icon(Icons.delete,size: 30,color: Colors.black54,)
                          ),
                          SizedBox(height: 5,),
                         widget.wishList == false
                          ?Container(
                            height: 25,
                            width: 70,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      if(count == 1){
                                        Fluttertoast.showToast(
                                            msg: "You reach minimum limit",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }
                                      else{
                                        setState(() {
                                          count--;
                                        });
                                        reviewCartProvider.updateReviewCartData(
                                            cartId: widget.productId,
                                            cartName: widget.productName,
                                            cartImage: widget.productImage,
                                            cartPrice: widget.productPrice,
                                            cartQuantity: count,
                                        );
                                      }
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    '$count',
                                    style: TextStyle(
                                        color: primaryColor
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      if(count < 10){
                                        setState(() {
                                          count++;
                                        });
                                        reviewCartProvider.updateReviewCartData(
                                          cartId: widget.productId,
                                          cartName: widget.productName,
                                          cartImage: widget.productImage,
                                          cartPrice: widget.productPrice,
                                          cartQuantity: count,
                                        );
                                      }
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ):
                             Container(),
                        ],
                      ),
                    ),

                  )
              ),
            ],
          ),
        ),
        widget.isBool==false?Container():Divider(
          height: 1,
          color: Colors.black45,
        ),
      ],
    );
  }
}
