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
        backgroundColor: Colors.green,
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
            colors: [
              Colors.green, // Top color
              Colors.yellow, // Middle color
              Colors.green, // Bottom color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0], // Gradient stops for each color
          ),
        ),
        child: Column(
          children: [
            Text(
              'Walk in best selling products @ Conching\'s Atchara & Delicacies',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 15.0,),
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