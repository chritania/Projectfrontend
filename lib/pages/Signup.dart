import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import '../services/user.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';
  bool _obscure = true;
  IconData _obscureIcon = Icons.visibility_off;

  Widget buttonContent = Text('Sign up');

  Widget loadingDisplay = CircularProgressIndicator();

  buildShowDialog(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return Center(
            child: SpinKitCubeGrid(
              color: Colors.orange[400],
              size: 100,
            ),
          );
        });
  }

  createSnackBar(String content){
    return SnackBar(
      content: Text(content),
      duration: Duration(seconds: 5),
    );
  }

  Future<dynamic>createAccount(User user) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/auth/Userauth/register/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
      );
    if(response.statusCode == 200){
      return <String, dynamic>{
        'isOk' : true,
        'message' : jsonDecode(jsonEncode(response.body)),
      };
    }else{
      return <String, dynamic>{
        'isOk' : false,
        'message' : jsonDecode(jsonEncode(response.body)),
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.yellow, // Top color
              Colors.green, // Middle color
              Colors.yellow, // Bottom color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0], // Gradient stops for each color
          ),
        ),
        child: SafeArea(
          child: Center( // Wrap your Column with Center to align it both vertically and horizontally
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.0, 50.0, 10.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child:Image.asset(
                      'assets/logo.png',
                      width: 360,
                    ),
                  ),
                  SizedBox(height: 60.0,),
                  Text(
                    'Let\'s Get Started!',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.0,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          maxLength: 40,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a name';
                            }
                            if (value.length < 3) {
                              return 'Name should be at least 3 letters long';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            name = value!;
                          },
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide an email';
                            }
                            // Add more email validation logic as needed
                            return null;
                          },
                          onSaved: (value) {
                            email = value!;
                          },
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureIcon),
                              onPressed: () {
                                setState(() {
                                  _obscure = !_obscure;
                                  _obscureIcon = _obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide a password';
                            }
                            if (value.length < 8) {
                              return 'Password should be at least 8 characters long';
                            }
                            // Add more password validation logic as needed
                            return null;
                          },
                          onSaved: (value) {
                            password = value!;
                          },
                        ),
                        SizedBox(height: 40.0),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              User user = User(
                                username: name,
                                email: email,
                                password: password,
                              );
                              createAccount(user);
                              Navigator.pushReplacementNamed(context, '/Login');
                            }
                          },
                          child: Text('Create Account'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.black,
                          ),
                        ),
                        SizedBox(height: 50.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(width: 5.0),
                            InkWell(
                              child: Text(
                                'Login here',
                                style: TextStyle(
                                  color: Colors.amber[600],
                                ),
                              ),
                              onTap: () =>
                                  Navigator.popAndPushNamed(context, '/Login'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
