import 'package:flutter/material.dart';
import 'package:foodapp/config/config.dart';
import 'package:foodapp/models/product_model.dart';
import 'package:foodapp/screens/product_overview/product_overview.dart';
import 'package:foodapp/widgets/count.dart';


class SingleProduct extends StatefulWidget {
  final String productImage;
  final String productName;
  final String productId;
  final int productPrice;
  final int productQuantity;


  const SingleProduct({
    required this.productId,
    required this.productImage,
    required this.productName,
    super.key,
    required this.productPrice,
    required this.productQuantity,

  });

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {

  // ignore: prefer_typing_uninitialized_variables
  var unitData;
  var firstValue;

  @override
  Widget build(BuildContext context) {



    return Container(
      height: 250,
      width: 160,
      margin: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: ContainerBackGroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductOverView(
                  productName: widget.productName,
                  productImage: widget.productImage,
                  productPrice: widget.productPrice,
                  productId: widget.productId,
                )
                )
                );
              },
              child: Container(
                height: 150,
                width: double.infinity,
                child: Image.network(widget.productImage),
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productName,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                      Text(
                        '${widget.productPrice}\$/${unitData == null ? firstValue : unitData ??""}',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                               child: Text('50 Gram')
                          ),
                          SizedBox(width: 5,),
                          Count(
                            cartId: widget.productId,
                            cartImage: widget.productImage,
                            cartName: widget.productName,
                            cartPrice: widget.productPrice,
                          ),
                        ],
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}

