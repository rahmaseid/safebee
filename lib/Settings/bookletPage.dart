import 'package:flutter/material.dart';
import 'package:safebee/Settings/SettingsItemClass.dart';

class BookletPage extends StatelessWidget {
  var menuItems = [
    MapsObject(id: '1234', Location: '1301 E Main St, Murfreesboro, TN 37132')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booklet Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/addMapLocation');
              // Add your add button logic here
              // For example, you can navigate to a new page
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.map,
                          color: Colors.pink,
                          size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        title: Text(menuItems[index].id),
                        subtitle:
                            Text('Description: ${menuItems[index].Location}'),
                        trailing: Icon(Icons.more_vert),
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
    Navigator.pushNamed(context, pagetoLoad);
  }

  AddPage() {
    print("HI");
  }
}

class MapsObject {
  String id;
  String Location;

  MapsObject({required this.id, required this.Location});

  factory MapsObject.fromJson(Map<String, dynamic> json) {
    return MapsObject(
      id: json['id'],
      Location: json['Location'],
    );
  }
}
