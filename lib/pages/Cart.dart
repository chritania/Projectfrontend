import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../services/product.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  Future<Map<String, dynamic>> _loadCredential() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.get('email').toString();
    String password = prefs.get('password').toString();
    int userId = int.parse(prefs.get('userId').toString());

    return <String, dynamic>{
      'email': email,
      'password': password,
      'userId' : userId
    };
  }

  Future<List<dynamic>> fetchBag() async {
    List<Map<String, dynamic>> orders = [];
    try {
      final userCredentials = await _loadCredential();
      final basicAuth = base64Encode(utf8.encode('${userCredentials['email']}:${userCredentials['password']}'));
      final response = await http.get(
          Uri.parse('http://10.0.2.2:8080/api/v1/bag/${userCredentials['userId']}'),
          headers: <String, String>{
            'Authorization' : 'Basic $basicAuth',
            'Content-Type' : 'application/json'
          }
      );
      print(response.body);  // Print JSON response for debugging
      final data = jsonDecode(response.body);
      for(var item in data){
        orders.add(<String, dynamic>{
          'bagId' : item['bagId'],
          'product' : Product.fromJson(item['product'][0]),
          'userId' : item['userId'],
          'numberOfOrder' : item['numberOfOrder']
        });
      }
      return orders;
    } catch (err) {
      print(err);
      return orders;
    }
  }

  Future<void> removeItem(int bagId) async {
    try {
      final userCredentials = await _loadCredential();
      final basicAuth = base64Encode(utf8.encode('${userCredentials['email']}:${userCredentials['password']}'));
      final response = await http.delete(
          Uri.parse('http://10.0.2.2:8080/api/v1/bag/$bagId'),
          headers: <String, String>{
            'Authorization' : 'Basic $basicAuth',
            'Content-Type' : 'application/json'
          }
      );
      if (response.statusCode == 200) {
        setState(() {
          fetchBag();  // Refresh the cart after deleting an item
        });
      } else {
        print('Failed to delete the item');
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white70,
        title: const Text(
          'Cart',
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
        child: FutureBuilder(
          future: fetchBag(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(), // Or any other loading indicator
              );
            }
            if (snapshots.hasData) {
              List bagItems = snapshots.data!;
              print(bagItems.length.toString());
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: bagItems.length,
                      itemBuilder: (context, bagIndex) {
                        final item = bagItems[bagIndex];
                        return Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(item['product'].productName),
                            subtitle: Text('Quantity: ${item['numberOfOrder']}'),
                            trailing: IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                removeItem(item['bagId']);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('Button Pressed!');
                    },
                    child: Text(
                      'Place your order',
                      style: TextStyle(
                        color: Colors.black,
                      ),),
                  ),
                ],
              );
            } else if (snapshots.hasError) {
              return Center(
                child: Text('Error: ${snapshots.error}'),
              );
            } else {
              return Center(
                child: Text('No data available'),
              );
            }
          },
        ),
      ),
    );
  }
}