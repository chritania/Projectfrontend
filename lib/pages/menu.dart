import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/selectedProduct.dart';

import '../services/product.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late Future<List<dynamic>> products;
  Future<List<dynamic>> fetchData() async{
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/v1/product/All')
    );
    print(response.body);
    final data = jsonDecode(response.body);
    List products = <Product>[];
    for(var product in data){
      products.add(Product.fromJson(product));
    }
    print(products);
    return products;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white70,
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
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: FutureBuilder(
            future: products,
            builder: (context, snapshots){
              if(snapshots.connectionState == ConnectionState.waiting){
                return Center(
                  child:CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              }
              if(snapshots.hasData){
                List products = snapshots.data!;
                print(products);
                return Padding(
                  padding: EdgeInsets.all(3.0),
                  child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index){
                        return Card(
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(products[index].productName),
                                Text(products[index].price.toString()),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => selectedProduct(product: products[index]),
                                ),
                              );
                            },
                          ),
                        );

                      }
                  ),
                );
              }
              if(snapshots.hasError){
                print(snapshots.error);
              }
              return Center(
                child: Text('Unable to load data'),
              );
            },
          ),
        ),
      ),
    );
  }
}