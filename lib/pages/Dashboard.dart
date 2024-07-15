import 'package:flutter/material.dart';
import 'package:project/services/product.dart';
import 'package:project/services/menuCard.dart';

//ITO ANG PINAKA BEST SELLING NA NAKA FEATURED SA HOMEPAGE
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List products = <Product>[
    Product(productName: "Papaya", price: 149.99),
    Product(productName: "Ampalaya", price: 149.99),
    Product(productName: "Ubod", price: 299.99),
    Product(productName: "Labong", price: 329.99),
    Product(productName: "Bawang", price: 149.99),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        foregroundColor:Colors.white70,
        title: Text(
          'Best Selling',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow, Colors.green],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WALK IN BEST SELLING PRODUCTS @ CONCHING\'S ATCHARA & DELICACIES',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 30.0,),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: products.map((product) => Menucard(product: product)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}