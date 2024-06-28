import 'package:flutter/material.dart';
import 'package:project/pages/Homepage.dart';
import 'package:project/pages/Dashboard.dart';
import 'package:project/pages/Login.dart';

import 'package:project/pages/Products.dart';

void main() =>runApp(MaterialApp(
  initialRoute: '/Login',
  routes: {
    '/' : (context) => Homepage(),
    '/Login' : (context) => Login(),
    '/Dashboard': (context) => Dashboard(),
    '/Products': (context) => Products(),
  },
));
