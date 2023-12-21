import 'package:flutter/material.dart';
import 'package:foodapp/models/product_model.dart';
import 'package:foodapp/product_providers/wish_list_provider.dart';
import 'package:provider/provider.dart';

import '../../config/config.dart';
import '../../widgets/Single_Item.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}



void _showAlertDialog(BuildContext context,ProductModel delete) {
  WishListProvider wishListProvider = Provider.of<WishListProvider>(context, listen: false);
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
                wishListProvider.deleteWishList(delete.productId);
                Navigator.of(context).pop();
              },
              child: Text('Yes')
          )
        ],
      );
    },
  );
}
class _WishListScreenState extends State<WishListScreen> {
  late WishListProvider wishListProvider = Provider.of(context);
  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider.getWishListData();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: textColor
          ),
          backgroundColor: primaryColor,
          title: Text(
            'WishList',
            style: TextStyle(color: textColor,fontSize: 18),
          ),
        ),
        body:ListView.builder(
            itemCount: wishListProvider.getWishList.length,
            itemBuilder: (context,index){
              ProductModel data = wishListProvider.getWishList[index];
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SingleItem(
                    isBool: true,
                    wishList: true,
                    productImage: data.productImage,
                    productName: data.productName,
                    productPrice: data.productPrice,
                    productId: data.productId,
                    onDelete: () {
                      _showAlertDialog(context, data);
                    },
                    productQuantity: 12,
                  ),
                ],
              );
            }
        )
    );
  }
}
