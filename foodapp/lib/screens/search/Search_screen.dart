import 'package:flutter/material.dart';
import 'package:foodapp/config/config.dart';
import 'package:foodapp/widgets/Single_Item.dart';

import '../../models/product_model.dart';

class SearchScreen extends StatefulWidget {
  final List<ProductModel> search;


  const SearchScreen({super.key, required this.search});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String quary = "";

  searchItem(String query) {
    Set<ProductModel> searchFood = Set<ProductModel>();

    // Filter and add matching items to the set
    widget.search.forEach((element) {
      if (element.productName.toLowerCase().contains(query)) {
        searchFood.add(element);
      }
    });

    return searchFood.toList(); // Convert the set to a list
  }


  @override
  Widget build(BuildContext context) {
    List<ProductModel> _searchItem = searchItem(quary);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(Icons.menu,color: textColor,),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(title: Text('Items')),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value){
                setState(() {
                  quary = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
                ),
                hintText: 'Search for items in the store',
                filled: true,
                fillColor: SearchFilledColor,
                prefixIcon: Icon(Icons.search)
              ),
            ),
          ),
          SizedBox(height: 10,),
          Column(
            children: _searchItem.map((data) {
              return SingleItem(
                isBool: false,
                productImage: data.productImage,
                productName: data.productName,
                productPrice: data.productPrice,
                productId: data.productId,
                onDelete: () {  },
                wishList: false,
                productQuantity: 12,
              );
            }).toList(),
          ),
        ],
      )
    );
  }
}
