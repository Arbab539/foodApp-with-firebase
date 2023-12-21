import 'package:flutter/material.dart';
import 'package:foodapp/config/config.dart';
import 'package:foodapp/product_providers/checkout_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_text_field.dart';

class AddDeliveryAddress extends StatefulWidget {
  const AddDeliveryAddress({super.key});

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

enum AddressTypes{
  Home,
  Work,
  Other,
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  var myType = AddressTypes.Home;
  CheckOutProvider checkOutProvider = CheckOutProvider();

  @override
  Widget build(BuildContext context) {
    CheckOutProvider checkOutProvider = Provider.of(context);


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Delivery Address',
          style: TextStyle(
            fontSize: 18
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        width: 160,
        height: 48,
        child: checkOutProvider.isLoading==false?
        MaterialButton(
          child: Text(
            'Add Address',
            style: TextStyle(
              color: textColor,
            ),
          ),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: (){
            checkOutProvider.validator(context,myType);
            },
        ):Center(
          child: CircularProgressIndicator(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
           CustomTextField(
             labText: 'First Name',
             keyboardType: TextInputType.text,
             controller: checkOutProvider.firstName,
           ),
           CustomTextField(
             labText: 'Last Name',
             keyboardType: TextInputType.text,
             controller: checkOutProvider.lastName,
           ),
           CustomTextField(
             labText: 'Mobile No',
             keyboardType: TextInputType.number,
             controller: checkOutProvider.mobileNo,
           ),
           CustomTextField(
             labText: 'Alternate Mobile No',
             keyboardType: TextInputType.number,
             controller: checkOutProvider.alterMobileNo,
           ),
           CustomTextField(
             labText: 'Scoiety',
             keyboardType: TextInputType.text,
             controller: checkOutProvider.society,
           ),
           CustomTextField(
             labText: 'Street',
             keyboardType: TextInputType.text,
             controller: checkOutProvider.street,
           ),
           CustomTextField(
             labText: 'LandMark',
             keyboardType: TextInputType.text,
             controller: checkOutProvider.landmark,
           ),
           CustomTextField(
             labText: 'City',
             keyboardType: TextInputType.text,
             controller: checkOutProvider.city,
           ),
           CustomTextField(
             labText: 'Area',
             keyboardType: TextInputType.text,
             controller: checkOutProvider.area,
           ),
           CustomTextField(
             labText: 'Pincode',
             keyboardType: TextInputType.number,
             controller: checkOutProvider.pinCode,
           ),


            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text('Address Type'),
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
              value: AddressTypes.Work,
              groupValue: myType,
              title: Text('Work'),
              onChanged: (value){
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(Icons.work,color: primaryColor,),
            ),
            RadioListTile(
              value: AddressTypes.Other,
              groupValue: myType,
              title: Text('Others'),
              onChanged: (value){
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(Icons.devices_other,color: primaryColor,),
            ),
          ],
        ),
      ),
    );
  }
}
