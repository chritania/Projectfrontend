import 'package:flutter/material.dart';
import 'package:project/pages/Homepage.dart';
import 'package:project/pages/Dashboard.dart';
import 'package:project/pages/Login.dart';
import 'package:project/pages/menu.dart';
import 'package:project/pages/profile.dart';

import 'package:project/pages/Signup.dart';
import 'package:project/pages/home.dart';

void main() =>runApp(MaterialApp(
  initialRoute: '/menu',
  routes: {
    '/' : (context) => Homepage(),
    '/Login' : (context) => Login(),
    '/Dashboard': (context) => Dashboard(),
    //'/Products': (context) => Products(),
    '/Signup':(context) => Signup(),
    '/home':(context) => Home(),
    '/profile':(context) => Profile(),
    '/menu':(context) => Menu(),
    '/Homepage': (context) => Homepage(),



  },
));



