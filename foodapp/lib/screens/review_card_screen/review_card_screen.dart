
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/config/config.dart';
import 'package:foodapp/models/rewiew_cart_model.dart';
import 'package:foodapp/product_providers/review_cart_provider.dart';
import 'package:foodapp/screens/checkout/delivery_detail.dart';
import 'package:provider/provider.dart';

import '../../widgets/Single_Item.dart';


class ReviewCardScreen extends StatelessWidget {
  const ReviewCardScreen({super.key});
  void _showAlertDialog(BuildContext context,ReviewCartModel delete) {
    ReviewCartProvider reviewCartProvider = Provider.of<ReviewCartProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Are you sure to delete this product.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
                onPressed: (){
                  reviewCartProvider.reviewCartDataDelete(delete.cartId);
                  Navigator.of(context).pop();
                },
                child: Text('Yes')
            )
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: textColor
        ),
        backgroundColor: primaryColor,
        title: Text('Review Cart',
          style: TextStyle(color: textColor,fontSize: 18),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text('Total Amount'),
        subtitle: Text('\$${reviewCartProvider.getTotalPrice()}',style: TextStyle(color: Colors.green[900]),),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            child: Text('Submit'),
            color: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            onPressed: () {
              if (reviewCartProvider != null &&
                  reviewCartProvider.getReviewCartDataList != null) {
                if (reviewCartProvider.getReviewCartDataList.isEmpty) {
                  Fluttertoast.showToast(msg: 'No Cart Data Found');
                  // Don't navigate to the next screen if the cart is empty
                } else {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DeliveryDetails()));
                }
              }
            },
            ),
        ),
      ),
      body:reviewCartProvider.getReviewCartDataList.isEmpty?Center(

        child: Text('No Data'),

      ) :ListView.builder(
          itemCount: reviewCartProvider.getReviewCartDataList.length,
          itemBuilder: (context,index){
            ReviewCartModel data = reviewCartProvider.getReviewCartDataList[index];
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SingleItem(
                    isBool: true,
                    wishList: false,
                    productImage: data.cartImage,
                    productName: data.cartName,
                    productPrice: data.cartPrice,
                    productId: data.cartId,
                    productQuantity: data.cartQuantity,
                    onDelete: () {
                      _showAlertDialog(context,data);
                  },
                ),
              ],
            );
          }
          )
    );
  }
}
