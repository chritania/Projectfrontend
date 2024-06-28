import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
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
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/Dashboard');
                  },
                  child: Text(''),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
