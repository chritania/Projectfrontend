import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = '';
  String username = '';
  String address = '';
  String phoneNumber = '';

  void _changeField(String currentValue, String hintText, Function(String) onSave) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _controller = TextEditingController(text: currentValue);
        return AlertDialog(
          title: Text('Change'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: hintText,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  onSave(_controller.text);
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _changeName() {
    _changeField(name, 'Enter new name', (newName) => name = newName);
  }

  void _changeUsername() {
    _changeField(username, 'Enter new username', (newUsername) => username = newUsername);
  }

  void _changeAddress() {
    _changeField(address, 'Enter new address', (newAddress) => address = newAddress);
  }

  void _changePhoneNumber() {
    _changeField(phoneNumber, 'Enter new phone number', (newPhoneNumber) => phoneNumber = newPhoneNumber);
  }

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

  Future<bool> _logout() async{
    try{
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.remove('userId');
      return true;
    }catch(err){
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              buildShowDialog(context);
              _logout().then((result) {
                if (result) {
                  Navigator.pushReplacementNamed(context, '/Login');
                } else {
                  Navigator.of(context).pop();
                }
              },
              );
            }
          ),
        ],
      ),
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
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/babae.png'),
                  radius: 70.0,
                ),
              ),
              Divider(
                height: 55.0,
                color: Colors.green,
                thickness: 2.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  SizedBox(width: 3.0),
                  Text(
                    'NAME',
                    style: TextStyle(
                      fontSize: 13.0,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.black),
                    onPressed: _changeName,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.isEmpty ? '' : name,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  SizedBox(width: 3.0),
                  Text(
                    'USERNAME',
                    style: TextStyle(
                      fontSize: 13.0,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.black),
                    onPressed: _changeUsername,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username.isEmpty ? '' : username,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Row(
                children: [
                  Icon(
                    Icons.contact_phone,
                    color: Colors.black,
                  ),
                  SizedBox(width: 3.0),
                  Text(
                    'CONTACT NUMBER',
                    style: TextStyle(
                      fontSize: 13.0,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.black),
                    onPressed: _changePhoneNumber,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    phoneNumber.isEmpty ? '' : phoneNumber,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.black,
                  ),
                  SizedBox(width: 3.0),
                  Text(
                    'ADDRESS',
                    style: TextStyle(
                      fontSize: 13.0,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.black),
                    onPressed: _changeAddress,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.isEmpty ? '' : address,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
