import 'dart:convert';
import 'package:article_mobile_app/services/user/user_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:article_mobile_app/model/user.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late UserModel _user;
  String _userId = '';
  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userString = prefs.getString('user');

      if (userString != null) {
        final Map<String, dynamic> userMap = jsonDecode(userString);
        final user = UserModel.fromJson(userMap);
        String userId = userMap['id'];

        setState(() {
          _user = user;
          _userId = userId;
          _usernameController.text = _user.name;
          _emailController.text = _user.email;
        });

        print(_userId);
      }
    } catch (e) {
      print('Error loading user data: $e');
      // Handle error jika terjadi kesalahan dalam memuat data pengguna
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/109224556?v=4'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
              enabled: _isEditing,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              enabled: _isEditing,
            ),
            SizedBox(height: 16),
            SizedBox(
              width: 600,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  backgroundColor: const Color(0xFF0A73D3),
                ),
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                    if (!_isEditing) {
                      _saveUserData();
                    }
                  });
                },
                child: Text(
                  _isEditing ? 'Save' : 'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _saveUserData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final UserProvider _userProvider = UserProvider();

      await _userProvider.updateUser(
        id: _userId,
        name: _usernameController.text,
        email: _emailController.text,
      );

      setState(() {
        final userUpdate = {
          "id": _userId,
          "name": _usernameController.text,
          "email": _emailController.text,
        };
        prefs.setString('user', jsonEncode(userUpdate));
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Profile updated successfully'),
      ));
    } catch (e) {
      print('Failed to update profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update profile'),
      ));
    }
  }
}
