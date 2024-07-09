import 'package:flutter/material.dart';
import 'package:project/services/product.dart';

class Menucard extends StatelessWidget {
  final Product product;

  Menucard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[200],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 10),
            Row(
              children: [
                Image.asset(
                  'assets/${product.productName.toLowerCase()}.png', // Adjust image asset path
                  height: 50, // Adjust height as needed
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 10.0,),
                Text(product.productName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            Text('${product.price}',
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
