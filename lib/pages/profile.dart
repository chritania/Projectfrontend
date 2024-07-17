import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String address = '';
  String phoneNumber = '';

  void _changeAddress() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _addressController = TextEditingController(text: address);
        return AlertDialog(
          title: Text('Change Address'),
          content: TextField(
            controller: _addressController,
            decoration: InputDecoration(
              hintText: 'Enter new address',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  address = _addressController.text;
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

  void _changePhoneNumber() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _phoneController = TextEditingController(text: phoneNumber);
        return AlertDialog(
          title: Text('Change Phone Number'),
          content: TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              hintText: 'Enter new phone number',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  phoneNumber = _phoneController.text;
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

  //void () {
   // Navigator.pushReplacementNamed(context, '/login'); // Replace with your login route
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/Login');
            },
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
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Casiana C. Villamar',
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
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'casiana57',
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
                    phoneNumber,
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
                    address,
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
