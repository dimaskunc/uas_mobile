import 'package:flutter/material.dart';
import 'addkost.dart';
import 'message.dart';
import 'listkost.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 66, 163, 243),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            SizedBox(height: 20,),
            ProfileCard(
              icon: Icons.account_circle,
              title: 'My Account',
            ),
            ProfileCard(
              icon: Icons.notifications,
              title: 'Notifications',
            ),
            ProfileCard(
              icon: Icons.settings,
              title: 'Settings',
            ),
            ProfileCard(
              icon: Icons.help,
              title: 'Help Center',
            ),
            ProfileCard(
              icon: Icons.logout,
              title: 'Logout',
              onTap: ()  {
              Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add Kost',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
          Navigator.pushReplacementNamed(context, '/dashboard');
          } else if (index == 1) {
            Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ListKostPage()),
    );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AddKostPage()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
          } else if (index == 4) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => UserPage()),
            );
          }
        },
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;  // Tambahkan properti onTap

  const ProfileCard({
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title, style: TextStyle(color: Colors.black)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
        onTap: onTap,  // Panggil onTap pada pengklikan card
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserPage(),
  ));
}
