import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class User {
  final int? id;
  final String name;
  final String phoneNumber;
  final String profileImage;

  User({this.id, required this.name, required this.phoneNumber, required this.profileImage});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
    };
  }
}

class DatabaseHelper {
  late Database _database;

  Future<void> initializeDatabase() async {
    String path = await getDatabasesPath();
    path = join(path, 'profile_database.db');
    _database = await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY,
        name TEXT,
        phoneNumber TEXT,
        profileImage TEXT
      )
    ''');
  }

  Future<void> insertUser(User user) async {
    await _database.insert('users', user.toMap());
  }

  Future<User?> getUser() async {
    List<Map<String, dynamic>> maps = await _database.query('users', orderBy: 'id DESC', limit: 1);
    if (maps.isNotEmpty) {
      return User(
        id: maps[0]['id'],
        name: maps[0]['name'],
        phoneNumber: maps[0]['phoneNumber'],
        profileImage: maps[0]['profileImage'],
      );
    }
    return null;
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  late String _profileImage = '';
  late DatabaseHelper _databaseHelper;
  final ImagePicker _imagePicker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
    _initializeUserData();
  }

  _initializeUserData() async {
    await _databaseHelper.initializeDatabase();
    User? user = await _databaseHelper.getUser();
    if (user != null) {
      setState(() {
        _nameController.text = user.name;
        _phoneController.text = user.phoneNumber;
        _profileImage = user.profileImage;
      });
    }
  }

  _saveUserData() async {
    User user = User(
      name: _nameController.text,
      phoneNumber: _phoneController.text,
      profileImage: _profileImage,
    );
    await _databaseHelper.insertUser(user);
    _showSnackBar('Data saved successfully!');
  }

  Future<void> _changeProfileImage() async {
    final XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage.path;
      });
    }
  }

void _showSnackBar(String message) {
  var showSnackBar2 = ScaffoldMessenger.of(context as BuildContext).showSnackBar(
    const SnackBar(content: Text("Login failed")),
  );
  var showSnackBar22 = showSnackBar2;
  var showSnackBar = showSnackBar22;
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _changeProfileImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage.isNotEmpty
                    ? FileImage(File(_profileImage))
                    : const AssetImage('assets/images/chusnia.jpg') as ImageProvider,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Nomor HP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveUserData();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
