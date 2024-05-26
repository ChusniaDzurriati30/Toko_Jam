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

  User(
      {this.id,
      required this.name,
      required this.phoneNumber,
      required this.profileImage});

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
    List<Map<String, dynamic>> maps =
        await _database.query('users', orderBy: 'id DESC', limit: 1);
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
    await _database
        .update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<void> deleteProfileImage(int id) async {
    await _database.update('users', {'profileImage': ''},
        where: 'id = ?', whereArgs: [id]);
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
                _buildImageButton(
                    Icons.camera_alt, 'Kamera', ImageSource.camera),
                _buildImageButton(Icons.photo, 'Galeri', ImageSource.gallery),
                _buildImageButton(Icons.delete, 'Hapus', null),
              ],
            ),
            SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildImageButton(IconData icon, String label, ImageSource? source) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 30),
          onPressed: () async {
            if (source != null) {
              final XFile? pickedImage =
                  await _imagePicker.pickImage(source: source);
              if (pickedImage != null) {
                setState(() {
                  _profileImage = pickedImage.path;
                });
                _showSnackBar('Profil diperbarui!');
              }
            } else {
              User? user = await _databaseHelper.getUser();
              if (user != null) {
                await _databaseHelper.deleteProfileImage(user.id!);
                setState(() {
                  _profileImage = '';
                });
                _showSnackBar('Gambar dihapus!');
              }
            }
            Navigator.pop(context);
          },
        ),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context as BuildContext)
        .showSnackBar(SnackBar(content: Text(message)));
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
                      : const AssetImage('assets/placeholder.png')
                          as ImageProvider,
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
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'Nama',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Chusnia Dzurriati',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text(
                'Telepon',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  hintText: '+62 857-4757-9309',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                  left: 55, right: 20), // Adjust left and right padding
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _saveUserData,
                  child: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 10),
                    backgroundColor: Color(0xFFFE1AFD1),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                ),
              ),
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
