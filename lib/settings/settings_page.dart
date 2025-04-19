import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = _auth.currentUser?.email ?? '';
  }

  Future<void> _updateEmail() async {
    try {
      await _auth.currentUser?.updateEmail(_emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email updated successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating email: $e')));
    }
  }

  Future<void> _updatePassword() async {
    try {
      await _auth.currentUser?.updatePassword(_passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password updated successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating password: $e')));
    }
  }

  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateEmail,
              child: Text('Update Email'),
            ),
            ElevatedButton(
              onPressed: _updatePassword,
              child: Text('Update Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout,
              child: Text('Log Out'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
