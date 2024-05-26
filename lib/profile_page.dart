import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path_pkg;
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
    path = path_pkg.join(path, 'profile_database.db');
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

  Future<void> updateUser(User user) async {
    await _database.update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<void> deleteProfileImage(int id) async {
    await _database.update('users', {'profileImage': ''}, where: 'id = ?', whereArgs: [id]);
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
      id: (await _databaseHelper.getUser())?.id,
      name: _nameController.text,
      phoneNumber: _phoneController.text,
      profileImage: _profileImage,
    );
    await _databaseHelper.updateUser(user);
    _showSnackBar('Profil diperbarui!');
  }

 Future<void> _changeProfileImage() async {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Foto profil',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt, size: 30),
                    onPressed: () async {
                      final XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.camera);
                      if (pickedImage != null) {
                        setState(() {
                          _profileImage = pickedImage.path;
                        });
                        _showSnackBar('Profil diperbarui!');
                      }
                      Navigator.pop(context);
                    },
                  ),
                  const Text('Kamera', style: TextStyle(fontSize: 16)),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo, size: 30),
                    onPressed: () async {
                      final XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
                      if (pickedImage != null) {
                        setState(() {
                          _profileImage = pickedImage.path;
                        });
                        _showSnackBar('Profil diperbarui!');
                      }
                      Navigator.pop(context);
                    },
                  ),
                  const Text('Galeri', style: TextStyle(fontSize: 16)),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete, size: 30),
                    onPressed: () async {
                      User? user = await _databaseHelper.getUser();
                      if (user != null) {
                        await _databaseHelper.deleteProfileImage(user.id!);
                        setState(() {
                          _profileImage = '';
                        });
                        _showSnackBar('Gambar dihapus!');
                      }
                      Navigator.pop(context);
                    },
                  ),
                  const Text('Hapus', style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      );
    },
  );
}




  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage.isNotEmpty
                      ? FileImage(File(_profileImage))
                      : const AssetImage('assets/placeholder.png') as ImageProvider,
                ),
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: IconButton(
                    iconSize: 30.0,
                    icon: const Icon(Icons.camera_alt),
                    onPressed: _changeProfileImage,
                  ),
                ),
              ],
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
              onPressed: _saveUserData,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: ProfilePage()));
}
