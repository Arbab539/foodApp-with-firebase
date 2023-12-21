
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodapp/models/product_model.dart';

class ProductProvider with ChangeNotifier{

 late ProductModel productModel;

 List<ProductModel> search = [];
 productModels(QueryDocumentSnapshot element){
  productModel = ProductModel(
      productImage: element.get('productImage'),
      productName: element.get('productName'),
      productPrice: element.get('productPrice'),
      productId: element.get('productId'),


  );
  search.add(productModel);
 }
////////////////////////////Herbs Product/////////////////////////////////
 
 List<ProductModel> herbsList = [];

 fetchHerbsProductData() async{
  List<ProductModel> newList = [];
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Herbs').get();
  for (var element in snapshot.docs) {
   productModels(element);
   newList.add(productModel);
  }
  herbsList = newList;
  notifyListeners();
 }
 List<ProductModel> get getHerbsProductData{
  return herbsList;
 }
 
 //////////////////////////////////Fresh Fruits//////////////////////////////////////
 List<ProductModel> freshProductList = [];

 fetchFreshProductData()  async{
  List<ProductModel> newList = [];

  QuerySnapshot value = await FirebaseFirestore.instance.collection("FreshFruit").get();

  for (var element in value.docs) {
   productModels(element);
   newList.add(productModel);

  }
  freshProductList = newList;
  notifyListeners();
 }

 List<ProductModel> get getFreshProductDataList{
  return freshProductList;
 }

 //////////////////////////Search Return/////////////////////
 List<ProductModel> get getAllProductSearch{
  return search;
 }


}