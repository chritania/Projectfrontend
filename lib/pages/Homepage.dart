import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

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

  void _onPersonIconPressed() {
    // Define what happens when the person icon is pressed
    // For example, navigate to the Profile page or show a dialog
    Navigator.pushNamed(context, '/profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Image.asset(
                      'assets/logo.png',
                      width: 200,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.person, size: 40.0,),
                    onPressed: _onPersonIconPressed,
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              FlutterCarousel(
                options: CarouselOptions(
                  height: 400.0,
                  showIndicator: true,
                  slideIndicator: CircularSlideIndicator(),
                ),
                items: [
                  'assets/brittle.png',
                  'assets/sampaloc.png',
                  'assets/cashew nuts.png',
                  'assets/cocoa.png',
                  'assets/kalamyas.png',
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
              SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Conching\'s Atchara, located @ Poblacion 5 on Marasigan St. in Calaca City, Batangas, has been a beloved local business since its founding in 1957 by Casiana Villamar. Known for its delicious atchara, a traditional Filipino pickled relish, the store has been delighting customers for decades. Conching\'s Atchara has become a household name in the community, cherished for its commitment to quality and tradition.',
                  style: TextStyle(
                    fontSize: 13.0,
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
        backgroundColor: Colors.yellow,
        elevation: 3.0,
        onTap: (int val){
          switch(val){
            case 0:
              Navigator.pushNamed(context, '/menu');
              break;
            case 1:
              Navigator.pushNamed(context, '/Dashboard');
              break;
            case 2:
              Navigator.pushNamed(context, '/transactionHistory');
              break;
          }
        },
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood, color: Colors.black),
              label: 'Menu'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.vertical_align_top, color: Colors.black),
              label: 'Best Selling'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.vertical_align_top, color: Colors.black),
              label: 'Transaction History'
          ),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
  const ProductScreen({super.key});

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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}
