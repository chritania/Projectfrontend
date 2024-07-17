import'package:flutter/material.dart';

import '../services/product.dart';


class selectedProduct extends StatefulWidget {
  final Product product;
  const selectedProduct({super.key,required this.product});

  @override

  State<selectedProduct> createState() => _selectedProductState(product: product);
}

class _selectedProductState extends State<selectedProduct> {
  final Product product;
  late double totalAmount = product.price;
  int numbersOfOrders =1;
  _selectedProductState({required this.product});

  @override
  void initState(){
    super.initState();
    totalAmount = product.price;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(

        children: [
          SizedBox(height: 20.0,),
          Text(widget.product.productName,
            style: TextStyle(
              fontSize: 40.0,
            ),
          ),
          SizedBox(height: 20.0,),
          Text(widget.product.description,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 50.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₱ ${totalAmount.toString()}',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: (){
                      setState(() {
                        if(numbersOfOrders > 1){
                          numbersOfOrders -= 1;
                          totalAmount = product.price * numbersOfOrders;
                        }
                      });
                    },
                    icon: Icon(Icons.remove),
                  ),
                  Text(
                    numbersOfOrders.toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  IconButton(
                    onPressed:(){
                      setState(() {
                        numbersOfOrders += 1;
                        totalAmount = product.price * numbersOfOrders;
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 50,),
          ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, '/cart');
            }
            , child: Text(
            '         Add to cart      ',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
        ],
      ),
    );
  }
}