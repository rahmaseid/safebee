import 'package:flutter/material.dart';
import 'package:safebee/Settings/SettingsItemClass.dart';
import 'package:safebee/services/service_locator.dart'; //imported to support calls and messages

class SettingsPage extends StatelessWidget {
  var menuItems = [
    SettingsItemClass(
        title: 'Contacts',
        description: 'Call, Text, or Manage your Emergency Contacts',
        pagetoLoad: '/contacts_Page',
        icon: Icons.call),
    SettingsItemClass(
        title: 'Map',
        description: 'Configure what shows on the Map Screen',
        pagetoLoad: '/mapsPage',
        icon: Icons.map),
    SettingsItemClass(
        title: 'Emergency Info Booklet',
        description: '',
        pagetoLoad: '/bookletPage',
        icon: Icons.book),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(
                          menuItems[index].icon,
                          color: Colors.pink,
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        title: Text(menuItems[index].title),
                        subtitle: Text(
                            menuItems[index].description),
                        trailing: Icon(Icons.more_vert),
                        onTap: () {
                          // Navigate to the destination page when the ListTile is tapped
                          Navigator.pushNamed(
                              context, menuItems[index].pagetoLoad);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the main page
              },
              child: Text('Return'),
            ),
          ],
        ),
      ),
    );
  }

  openPage(String pagetoLoad, BuildContext context) {
    //Navigator.pushNamed(context, pagetoLoad);
    print(pagetoLoad);
  }
}
