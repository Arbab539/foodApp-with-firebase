import 'package:flutter/material.dart';
import 'package:foodapp/config/config.dart';
import 'package:foodapp/models/delivery%20_address_model.dart';
import 'package:foodapp/product_providers/checkout_provider.dart';
import 'package:foodapp/product_providers/product_provider.dart';
import 'package:foodapp/product_providers/review_cart_provider.dart';
import 'package:foodapp/widgets/order_item.dart';
import 'package:provider/provider.dart';

import '../../widgets/Single_delivery_item.dart';




class PaymentSummary extends StatefulWidget {
  final DeliveryAddressModel deliveryAddressList;

  const PaymentSummary({
    super.key,
    required this.deliveryAddressList
  });

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}

enum AddressTypes{
  Home,
  OnlinePayment,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  String getAddressTypeLabel(String addressType) {
    switch (addressType) {
      case 'AddressTypes.Other':
        return 'Other';
      case 'AddressTypes.Home':
        return 'Home';
      case 'AddressTypes.Work':
        return 'Work';
      default:
        return 'Other'; // Provide a default value for unknown types
    }
  }

  var myType = AddressTypes.Home;

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    double discount = 30;
    double shippingCharge = 3.7;
    double discountValue = 0.0;
    double total = 0.0;
    double totalPrice = reviewCartProvider.getTotalPrice();

    if(totalPrice > 300){
       discountValue = (totalPrice * discount)/100;
      total = totalPrice - discountValue;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Payment Summary',
        style: TextStyle(
          fontSize: 18
        ),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text('Total Amount'),
        subtitle: Text(
            '\$${totalPrice > 300 ? total : totalPrice + 5}',
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
              onPressed: (){},
            child: Text(
              'Place Order',
              style: TextStyle(
                color: textColor
              ),
            ),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          itemCount: 1,
            itemBuilder: (context,index){
              return Column(
                children: [
                  SingleDeliveryItem(
                    title: '${widget.deliveryAddressList.firstName} ${widget.deliveryAddressList.lastName}',
                    address: '${widget.deliveryAddressList.area}, ${widget.deliveryAddressList.city}, ${widget.deliveryAddressList.society}, ${widget.deliveryAddressList
                        .street}, ${widget.deliveryAddressList.landMark}, ${widget.deliveryAddressList.pinCode}',
                    number: '${widget.deliveryAddressList.mobileNo}',
                    addressType: getAddressTypeLabel(widget.deliveryAddressList.addressType),
                  ),
                  Divider(),
                  ExpansionTile(
                    children: reviewCartProvider.getReviewCartDataList.map((e){
                      return OrderItem(e: e,);
                    }).toList(),
                      title: Text('Order Item ${reviewCartProvider.getReviewCartDataList.length}'),
                  ),
                  Divider(),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      'Sub Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    trailing:  Text(
                      '\$${totalPrice+5}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      'Shipping Charge',
                      style: TextStyle(
                         color: Colors.grey[600]
                      ),
                    ),
                    trailing:  Text(
                      '\$5',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      'Compen Discount',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    trailing:  Text(
                      '\$${discountValue}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    minVerticalPadding: 5,
                    leading: Text(
                      'Payment Options',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  RadioListTile(
                    value: AddressTypes.Home,
                    groupValue: myType,
                    title: Text('Home'),
                    onChanged: (value){
                      setState(() {
                        myType = value!;
                      });
                    },
                    secondary: Icon(Icons.home,color: primaryColor,),
                  ),
                  RadioListTile(
                    value: AddressTypes.OnlinePayment,
                    groupValue: myType,
                    title: Text('OnlinePayment'),
                    onChanged: (value){
                      setState(() {
                        myType = value!;
                      });
                    },
                    secondary: Icon(Icons.work,color: primaryColor,),
                  ),
                ],
              );
            }
        )
      ),
    );
  }
}
