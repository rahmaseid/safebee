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
      home: DefaultTabController(
        length: 2, // Set the number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home Test'),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(
                    icon: Icon(Icons.contacts),
                    text: 'Contacts'), // Add this line for the Contacts tab
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // The content of the first tab (replace this with the home page)
              const Center(
                child: Text('Home Page'),
              ),
              // The content of the second tab (ContactsPage)
              ContactsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
