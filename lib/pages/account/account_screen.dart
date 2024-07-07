import 'package:article_mobile_app/pages/account/change_password_screen.dart';
import 'package:article_mobile_app/pages/auth/login_screen.dart';
import 'package:article_mobile_app/pages/account/profile_screen.dart';
import 'package:article_mobile_app/services/auth/auth_services.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  final AuthServices _authServices = AuthServices();
  void _navigateToProfile(BuildContext context) {
    // Logika navigasi ke halaman profil
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }

  void _navigateToChangePassword(BuildContext context) {
    // Logika navigasi ke halaman ubah password
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OldPasswordScreen()),
    );
  }

  void _logout(BuildContext context) {
    // Logika untuk logout
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Apakah Anda yakin ingin logout?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Tidak"),
            ),
            TextButton(
              onPressed: () {
                // Implementasikan logika logout di sini
                _authServices.logout();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text("Ya"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun Saya'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profil'),
            onTap: () => _navigateToProfile(context),
          ),
          // ListTile(
          //   leading: Icon(Icons.lock),
          //   title: Text('Ubah Password'),
          //   onTap: () => _navigateToChangePassword(context),
          // ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
