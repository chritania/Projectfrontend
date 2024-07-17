import 'package:flutter/material.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:icon_badge/icon_badge.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  String _searchText = '';
  final List<BannerModel> listBanners = [
    BannerModel(imagePath: 'assets/brittle.png', id: '1'),
    BannerModel(imagePath: 'assets/sampaloc.png', id: '2'),
    BannerModel(imagePath: 'assets/cashew nuts.png', id: '3'),
    BannerModel(imagePath: 'assets/cocoa.png', id: '4'),
    BannerModel(imagePath: 'assets/kalamyas.png', id: '5'),
  ];
  final List<Map<String, dynamic>> _items = [
    {'name': 'Peanut Brittle', 'image': 'assets/brittle.png'},
    {'name': 'Sampaloc', 'image': 'assets/sampaloc.png'},
    {'name': 'Cocoa', 'image': 'assets/cocoa.png'},
    {'name': 'Cashew Nuts', 'image': 'assets/cashew nuts.png'},
    {'name': 'Kalamyas', 'image': 'assets/kalamyas.png'},
    {'name': 'Labong', 'image': 'assets/labong.png'},
    {'name': 'Ubod', 'image': 'assets/ubod.png'},
    {'name': 'Papaya', 'image': 'assets/papaya.png'},
    {'name': 'Ampalaya', 'image': 'assets/ampalaya.png'},
    {'name': 'Burong Bawang', 'image': 'assets/bawang.png'},
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onPersonIconPressed() {
    Navigator.pushNamed(context, '/profile');
  }

  void _onCartIconPressed() {
    Navigator.pushNamed(context, '/cart');
  }

  void onSearchTextChanged(String text) {
    setState(() {
      _searchText = text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter items based on search text
    List<Map<String, dynamic>> filteredItems = _items.where((item) {
      return _searchText.isEmpty || item['name'].toLowerCase().contains(_searchText);
    }).toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 200,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.person),
                          onPressed: _onPersonIconPressed,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0,),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 50.0,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Available Products...',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.grey),
                      ),
                      onChanged: onSearchTextChanged,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              // Conditional rendering of product list
              if (_searchText.isNotEmpty) // Show only when there is search text
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredItems[index]['name']),
                        leading: Image.asset(filteredItems[index]['image']),
                        onTap: () {
                          // Handle item tap if needed
                        },
                      );
                    },
                  ),
                ),
              SizedBox(height: 30,),
              BannerCarousel(
                banners: listBanners,
                customizedIndicators: IndicatorModel.animation(width: 20, height: 5, spaceBetween: 2, widthAnimation: 50),
                height: 200,
                activeColor: Colors.amberAccent,
                disableColor: Colors.white,
                animation: true,
                borderRadius: 10,
                width: 400,
                indicatorBottom: false,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green[400],
        elevation: 3.0,
        onTap: (int val){
          switch(val){
            case 0:
              Navigator.pushNamed(context, '/menu');
              break;
            case 1:
              Navigator.pushNamed(context, '/cart');
              break;
            case 2:
              Navigator.pushNamed(context, '/transactionHistory');
              break;
          }
        },
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, color: Colors.black),
              label: 'Menu'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag, color: Colors.black),
              label: 'Cart'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.history,color:  Colors.black),
              label: 'Transaction History'
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
