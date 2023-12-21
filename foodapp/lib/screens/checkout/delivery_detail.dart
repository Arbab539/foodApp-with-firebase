import 'package:flutter/material.dart';
import 'package:foodapp/config/config.dart';
import 'package:foodapp/models/delivery%20_address_model.dart';
import 'package:foodapp/product_providers/checkout_provider.dart';
import 'package:foodapp/screens/checkout/add_delivery_address.dart';
import 'package:foodapp/screens/checkout/payment_summary.dart';
import 'package:foodapp/widgets/Single_delivery_item.dart';
import 'package:provider/provider.dart';


class DeliveryDetails extends StatefulWidget {

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
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

  late DeliveryAddressModel value;
  @override
  Widget build(BuildContext context) {
    // Use Provider.of to access the delivery address data provider.
    final deliveryAddressProvider = Provider.of<CheckOutProvider>(context);

    // Fetch delivery address data when the widget is built.
    deliveryAddressProvider.getDeliveryAddressData();


    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Details'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDeliveryAddress()),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Text('Add new Address')
              : Text('Payment Summary'),
          onPressed: () {
            deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddDeliveryAddress()))
                : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PaymentSummary(deliveryAddressList: value,)));
          },
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Deliver To'),
            leading: Icon(Icons.location_on_outlined, size: 30),
          ),
          Divider(
            height: 1,
          ),
          // Use a conditional expression to render different content based on data presence.
          deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Container(
            child: Center(
              child: Text('No Data'),
            ),
          )
              : Column(
            children: deliveryAddressProvider.getDeliveryAddressList
                .map(
                  (e) {
                    setState(() {
                     value = e;
                    });

                   return SingleDeliveryItem(
                      title: '${e.firstName} ${e.lastName}',
                      address: '${e.area}, ${e.city}, ${e.society}, ${e
                          .street}, ${e.landMark}, ${e.pinCode}',
                      number: '${e.mobileNo}',
                      addressType: getAddressTypeLabel(e.addressType),
                    );
                  }
            )
                .toList(),
          ),
        ],
      ),
    );
  }
}


