import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    DashboardScreen(),
    ProductScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Set Scaffold background to transparent
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow, Colors.green],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Image.asset(
                  'assets/logo.png',
                  width: 200,
                ),
              ),
              SizedBox(height: 20.0,),
              FlutterCarousel(
                options: CarouselOptions(
                  height: 400.0,
                  showIndicator: true,
                  slideIndicator: CircularSlideIndicator(),
                ),
                items: [
                  'assets/ampalaya.png',
                  'assets/labong.png',
                  'assets/papaya.png',
                  'assets/ubod.png',
                  'assets/bawang.png',
                ].map((String imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 8.0,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Conching\'s Atchara, located @ Poblacion 5 on Marasigan St. in Calaca City, Batangas, has been a beloved local business since its founding in 1957 by Casiana Villamar. Known for its delicious atchara, a traditional Filipino pickled relish, the store has been delighting customers for decades. Conching\'s Atchara has become a household name in the community, cherished for its commitment to quality and tradition. Whether enjoyed as a condiment or a side dish, Conching\'s Atchara brings a taste of heritage to every bite.',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Product',
          ),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 360,
        child: Image.asset(
          'assets/tinda.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 360,
        child: Image.asset(
          'assets/logo.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
