
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodapp/models/product_model.dart';

class WishListProvider with ChangeNotifier{
  void addWishListData({
    required String wishListId,
    required String wishListName,
    required String wishListImage,
    required int wishListPrice,
    required int wishListQuantity,
  }) async{
    FirebaseFirestore.instance.collection('wishList')
        .doc(FirebaseAuth.instance.currentUser?.uid).collection('YourWishList')
        .doc(wishListId).set(
        {
          "wishListId":wishListId,
          "wishListName":wishListName,
          "wishListImage":wishListImage,
          "wishListPrice":wishListPrice,
          "wishListQuantity":wishListQuantity,
          "wishList": true,
        }
    );
  }
  ////////////////////////  Get WishListData   ///////////////////////

  List<ProductModel> wishList = [];

  getWishListData() async {
    try {
      List<ProductModel> newList = [];
      QuerySnapshot value = await FirebaseFirestore.instance
          .collection('wishList')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('YourWishList')
          .get();

      for (var element in value.docs) {
        ProductModel productModel = ProductModel(
          productId: element.get('wishListId'),
          productImage: element.get('wishListImage'),
          productName: element.get('wishListName'),
          productPrice: element.get('wishListPrice'),
        );
        newList.add(productModel);
      }
      wishList = newList;
      notifyListeners();
    } catch (e) {
      print('Error fetching wishlist data: $e');
    }
  }
  List<ProductModel> get getWishList{
    return wishList;
  }


 ////////////////////////// Delete WishList /////////////////////
 deleteWishList(wishListId){
    FirebaseFirestore.instance
        .collection('wishList')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('YourWishList')
        .doc(wishListId)
        .delete();
 }

}