import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/models/delivery%20_address_model.dart';

class CheckOutProvider with ChangeNotifier{

  bool isLoading = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController alterMobileNo = TextEditingController();
  TextEditingController society = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController pinCode = TextEditingController();

  void validator(context,myType) async{

    if(firstName.text.isEmpty){
      Fluttertoast.showToast(msg: 'FirstName is Empty');
    }
    else if(lastName.text.isEmpty){
      Fluttertoast.showToast(msg: 'lastName is Empty');
    }
    else if(mobileNo.text.isEmpty){
      Fluttertoast.showToast(msg: 'MobileNo is Empty');
    }
    else if(alterMobileNo.text.isEmpty){
      Fluttertoast.showToast(msg: 'AlterMobileNo is Empty');
    }
    else if(society.text.isEmpty){
      Fluttertoast.showToast(msg: 'society is Empty');
    }
    else if(street.text.isEmpty){
      Fluttertoast.showToast(msg: 'street is Empty');
    }
    else if(landmark.text.isEmpty){
      Fluttertoast.showToast(msg: 'landmark is Empty');
    }
    else if(city.text.isEmpty){
      Fluttertoast.showToast(msg: 'city is Empty');
    }
    else if(area.text.isEmpty){
      Fluttertoast.showToast(msg: 'area is Empty');
    }
    else if(pinCode.text.isEmpty){
      Fluttertoast.showToast(msg: 'pinCode is Empty');
    }

    else{
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection('AddDeliveryAddress')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({

        'firstName':firstName.text,
        'lastName':lastName.text,
        'mobileNo':mobileNo.text,
        'alterMobileNo':alterMobileNo.text,
        'society':society.text,
        'street':street.text,
        'landmark':landmark.text,
        'city':city.text,
        'area':area.text,
        'pinCode':pinCode.text,
        'addressType':myType.toString(),
          }).then((value) async{
            isLoading = false;
            await Fluttertoast.showToast(msg: 'Add your delivery Address');
             Navigator.pop(context);
            notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAddressList = [];

  Future<void> getDeliveryAddressData() async {
    try {
      List<DeliveryAddressModel> newDeliveryAddressList = [];

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('AddDeliveryAddress')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      if (snapshot.exists) {
        DeliveryAddressModel deliveryAddressModel = DeliveryAddressModel(
          firstName: snapshot.get('firstName'),
          lastName: snapshot.get('lastName'),
          mobileNo: snapshot.get('mobileNo'),
          alterMobileNo: snapshot.get('alterMobileNo'),
          society: snapshot.get('society'),
          street: snapshot.get('street'),
          landMark: snapshot.get('landmark'),
          city: snapshot.get('city'),
          area: snapshot.get('area'),
          pinCode: snapshot.get('pinCode'),
          addressType: snapshot.get('addressType'),
        );

        newDeliveryAddressList.add(deliveryAddressModel);
        deliveryAddressList = newDeliveryAddressList;
        notifyListeners();
      }
    } catch (error) {
      print('Error fetching delivery address data: $error');
    }
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAddressList;
  }

}