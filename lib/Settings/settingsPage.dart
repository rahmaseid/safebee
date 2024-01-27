import 'package:flutter/material.dart';
import 'package:safebee/Settings/SettingsItemClass.dart';

class SettingsPage extends StatelessWidget {
  var menuItems = [
    SettingsItemClass(
        title: 'Call',
        description: 'This is a contact page which you can load your contacts',
        pagetoLoad: '/mapsPage',
        icon: Icons.call),
    SettingsItemClass(
        title: 'Maps',
        description: 'This is a Maps page which you can load your contacts',
        pagetoLoad: '/mapsPage',
        icon: Icons.map),
    SettingsItemClass(
        title: 'Booklet',
        description: 'This is a Booklet page which you can load your contacts',
        pagetoLoad: '/bookletPage',
        icon: Icons.book),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Settings Page',
              style: TextStyle(fontSize: 20),
            ),
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
                            'Description: ${menuItems[index].description}'),
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
              child: Text('Go Return'),
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
