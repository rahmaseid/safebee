// main.dart

import 'package:flutter/material.dart';
import 'screens/contacts_page.dart'; // Imported for the contacts_page.dart file
import 'package:safebee/services/calls_and_messages_service.dart'; //imported to support calls and messages
import 'package:safebee/services/service_locator.dart'; //imported to support calls and messages

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Test',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Test'),
      ),
      body: Center(
        child: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Contacts page when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactsPage()),
          );
        },
        child: Icon(Icons.contacts),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
