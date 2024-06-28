import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Homepage');
                  },
                  child: Text('Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
