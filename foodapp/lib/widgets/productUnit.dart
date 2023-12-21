import 'package:flutter/material.dart';

import '../config/config.dart';

class ProductUnit extends StatelessWidget {
  final Function() onTap;
  final String title;
  const ProductUnit({super.key,required this.onTap,required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 50,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Expanded(
                  child: Text(
                '$title',
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.black
                    ),
                  )
              ),
            ),
            Icon(Icons.arrow_drop_down,color: primaryColor,)
          ],
        ),
      ),
    );
  }
}
