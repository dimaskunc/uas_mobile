import 'package:flutter/material.dart';
import 'user.dart';
import 'addkost.dart';
import 'listkost.dart';

void main() {
  runApp(MyApp());
  
}

class Message {
  String senderName;
  String messageText;
  String time;
  String avatarUrl;

  Message({required this.senderName, required this.messageText, required this.time, required this.avatarUrl});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Message', style: TextStyle(color: Colors.white),),
           backgroundColor: const Color.fromARGB(255, 66, 163, 243),
        ),
        body: MessageScreen(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 3,
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
      ),
    );
  }
}

class MessageScreen extends StatelessWidget {
  final List<Message> messages = [
    Message(senderName: 'Jerome Polin', messageText: 'Ya, nanti saya cek dulu', time: '10:30 AM', avatarUrl: 'assets/jerome.png'),
    Message(senderName: 'Rafi Ahmad', messageText: 'Oke, nanti saya transfer', time: '08.00 AM', avatarUrl: 'assets/rafi.jpg'),
    Message(senderName: 'Jusuf Hamka', messageText: 'Nanti malam saya kabari lagi', time: '13.00 PM', avatarUrl: 'assets/jusuf.jpeg'),
    Message(senderName: 'Hotman Paris', messageText: 'Baik, saya suruh aspri saya dulu', time: '17.00 PM', avatarUrl: 'assets/hotman.jpg'),
    Message(senderName: 'Ariel', messageText: 'Ya, di tunggu infonya', time: '09:30 AM', avatarUrl: 'assets/ariel.jpg'),
    Message(senderName: 'Fiersa', messageText: 'Oke, terimakasih ya', time: '14.00 PM', avatarUrl: 'assets/fiersa.jpg'),
    Message(senderName: 'Najwa', messageText: 'Coba kasih yang lain dulu', time: '11.00 AM', avatarUrl: 'assets/najwa.jpg'),
    Message(senderName: 'Prily', messageText: 'Baik, nanti di infokan lagi', time: '18.00 PM', avatarUrl: 'assets/prily.jpg'),
    // Add more messages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return buildMessageItem(messages[index]);
      },
    );
  }

  Widget buildMessageItem(Message message) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(message.avatarUrl),
      ),
      title: Text(
        message.senderName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(message.messageText),
      trailing: Text(message.time),
      onTap: () {
        // Handle tapping on a message
        // You can navigate to a detailed message view or perform other actions here
      },
    );
  }
}



