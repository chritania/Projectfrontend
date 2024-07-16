import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _obscure = true;
  IconData _obscureIcon = Icons.visibility_off;

  Widget buttonContent = Text('Log in');

  Widget loadingDisplay = CircularProgressIndicator();

  Future<bool>Login(User user)async{
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/v1/auth/login'),
      headers: <String, String>{
        'Content-Type' : 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'usernameOrEmail': user.email,
        'password':user.password
      }),
    );
    if(response.statusCode == 200){
      return true;
    }
    return false;
    //print(response.body);
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
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 50.0, 10.0, 0),
            child: Column(
              children: <Widget>[
                Center(
                  child:Image.asset(
                    'assets/logo.png',
                    width: 360,
                  ),
                ),
                SizedBox(height: 60.0,),
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      fontSize: 25
                  ),
                ),
                SizedBox(height: 40.0,),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: Text('Email'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please provide an email';
                          }
                          if(value.length < 2){
                            return 'Email should be existing';
                          }
                          return null;
                        },
                        onSaved: (value){
                          email=value!;
                        },
                      ),
                      SizedBox(height: 30.0,),
                      TextFormField(
                        obscureText: _obscure,
                        decoration: InputDecoration(
                          label: Text('Password'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureIcon),
                            onPressed: (){
                              setState(() {
                                _obscure = !_obscure;
                                if(_obscure){
                                  _obscureIcon = Icons.visibility_off;
                                }else{
                                  _obscureIcon = Icons.visibility;
                                }
                              });
                            },
                          ),
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Please provide a password';
                          }
                          if(value.length < 8){
                            return 'Password should be 8 characters long';
                          }
                          return null;
                        },
                        onSaved: (value){
                          password=value!;
                        },
                      ),
                      SizedBox(height: 30.0,),
                      ElevatedButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            formKey.currentState!.save();
                            User user = User(
                                username: '',
                                email: email,
                                password: password
                            );
                            // if(login(user)){
                            //   Navigator.pushReplacementNamed(context, '/dashboard');
                            // }
                            setState(() {
                              buttonContent = FutureBuilder(
                                  future: Login(user),
                                  builder: (context, snapshots){
                                    if(snapshots.connectionState == ConnectionState.waiting){
                                      return loadingDisplay;
                                    }
                                    if(snapshots.hasData){
                                    }
                                    return Text('Log in');
                                  }
                              );
                            });
                            Navigator.pushReplacementNamed(context, '/');
                          }
                        },
                        child: buttonContent,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.amber,
                        ),
                      ),
                SizedBox(height: 50.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    InkWell(
                      child: Text(
                        'Signup here',
                        style: TextStyle(
                          color: Colors.amber[700],
                        ),
                      ),
                      onTap: ()=> Navigator.popAndPushNamed(context, '/Signup'),
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
    );
  }
}
