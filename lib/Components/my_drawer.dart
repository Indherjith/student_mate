import 'package:flutter/material.dart';
import '../auth_service.dart'; // Adjust the path as necessary

class CustomDrawer extends StatelessWidget {
  final AuthService _authService = AuthService();

  CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(user?.displayName ?? 'abc_user'),
            accountEmail: Text(user?.email ?? 'abc@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : const AssetImage('assets/person_icon.jpeg')
                      as ImageProvider,
              child: user?.photoURL == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Student'),
            onTap: () {
              Navigator.pushNamed(context, '/student');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await _authService.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
