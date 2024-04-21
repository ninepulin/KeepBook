import 'package:flutter/material.dart';
import 'package:keepbook/Bottom.dart';
import 'package:keepbook/Bookshelf.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Settings UI',
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool pushNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.settings, color: Colors.white, size: 35),
          onPressed: null,
        ),
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 125, 161, 197),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Account Settings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const ListTile(
            title: Text('Edit profile'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: null,
          ),
          const ListTile(
            title: Text('Change password'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: null,
          ),
          ListTile(
            title: const Text('View Bookshelf'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookshelfPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Add a payment method'),
            trailing: const Icon(Icons.add),
            onTap: null,
          ),
          SwitchListTile(
            title: const Text('Push notifications'),
            value: pushNotifications,
            onChanged: (bool value) {
              setState(() {
                pushNotifications = value;
              });
            },
            activeTrackColor: Colors.lightBlueAccent,
            activeColor: Colors.blue,
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'More',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const ListTile(
            title: Text('About us'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: null,
          ),
          const ListTile(
            title: Text('Privacy policy'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: null,
          ),
          const ListTile(
            title: Text('Terms and conditions'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: null,
          ),
        ],
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
