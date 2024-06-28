import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.green[900],
      ),
      backgroundColor: Colors.green[800],
      body: Container(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Homepage');
                  },
                  child: Text('Dashboard'),
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/Product');
                    },
                    child: Text('Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
