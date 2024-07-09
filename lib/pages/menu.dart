import 'package:flutter/material.dart';
import 'package:project/services/product.dart';
import 'package:project/services/menuCard.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});
  @override
  State<Menu> createState() => _MenuState();
  }

class _MenuState extends State<Menu> {
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
          'Menu',
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
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: products.map((product)=> Menucard(product: product)).toList(),
            ),
          ),
        ),
    );
    }
  }