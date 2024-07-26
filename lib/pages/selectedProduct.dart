import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../services/product.dart';

class selectedProduct extends StatefulWidget {
  final Product product;
  const selectedProduct({super.key, required this.product});

  @override
  State<selectedProduct> createState() => _selectedProductState(product: product);
}

class _selectedProductState extends State<selectedProduct> {
  final Product product;
  double totalAmount = 0.0;
  int numberOfOrder = 1;

  _selectedProductState({required this.product});

  Future<Map<String, dynamic>> _loadCredential() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    String password = prefs.getString('password') ?? '';
    int userId = prefs.getInt('userId') ?? 0;

    return <String, dynamic>{
      'email': email,
      'password': password,
      'userId': userId,
    };
  }

  Future<Map<String, dynamic>> addToBag(int productId, int numberOfOrder) async {
    try {
      final userCredentials = await _loadCredential();
      final basicAuth = base64Encode(utf8.encode('${userCredentials['email']}:${userCredentials['password']}'));
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/api/v1/bag'),
        headers: <String, String>{
          'Authorization': 'Basic $basicAuth',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'userId': userCredentials['userId'],
          'productId': productId,
          'numberOfOrder': numberOfOrder,
        }),
      );

      if (response.statusCode == 200) {
        return <String, dynamic>{
          "isOk": true,
          "result": response.body,
        };
      }
      return <String, dynamic>{
        "isOk": false,
        "result": response.body,
      };
    } catch (err) {
      return <String, dynamic>{
        "isOk": false,
        "result": err.toString(),
      };
    }
  }

  buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: SpinKitCircle(
            color: Colors.black,
            size: 100,
          ),
        );
      },
    );
  }

  createSnackBar(String content) {
    return SnackBar(
      content: Text(content),
      duration: const Duration(seconds: 5),
    );
  }

  @override
  void initState() {
    super.initState();
    totalAmount = product.price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
        backgroundColor: Colors.green,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 400,
                  height: 400,
                  // Add an image or any other widget here
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      product.productName,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      child: Text(
                        product.description,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              color: Colors.yellow[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₱${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (numberOfOrder > 1) {
                                  numberOfOrder -= 1;
                                }
                                totalAmount = product.price * numberOfOrder;
                              });
                            },
                            icon: const Icon(Icons.remove),
                            style: IconButton.styleFrom(
                              side: BorderSide(
                                style: BorderStyle.solid,
                                width: 3.0,
                                color: Colors.grey[500]!,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            numberOfOrder.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                numberOfOrder += 1;
                                totalAmount = product.price * numberOfOrder;
                              });
                            },
                            icon: const Icon(Icons.add),
                            style: IconButton.styleFrom(
                              side: BorderSide(
                                style: BorderStyle.solid,
                                width: 3.0,
                                color: Colors.grey[500]!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Show a loading dialog or some indication of progress
                      buildShowDialog(context);

                      // Perform the async operation to add the item to the bag
                      final result = await addToBag(product.id, numberOfOrder);

                      // Close the loading dialog
                      Navigator.pop(context);

                      // Show a SnackBar with the result
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('ADDED'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      // Navigate to the cart screen
                      Navigator.pushReplacementNamed(context, '/cart');
                    },
                    child: const Text('Add to my cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white70,
                    ),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
