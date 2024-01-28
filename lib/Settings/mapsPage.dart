import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:safebee/Settings/SettingsItemClass.dart';
import 'package:safebee/Settings/addMapLocation.dart';
import 'package:safebee/Settings/editMapLocation.dart';
import 'package:safebee/screens/contacts_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPage();
}

class _MapsPage extends State<MapsPage> {
  late SharedPreferences _prefs;
  List<MapsObject> mapsMenuItems = [];

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  // Load the list from SharedPreferences
  Future<void> _loadList() async {
    _prefs = await SharedPreferences.getInstance();

    // Retrieve the JSON-encoded string from SharedPreferences
    String jsonString = _prefs.getString('mapsMenuItems') ?? '[]';
    // Decode the string to get the list

    List<MapsObject> myObjects = (json.decode(jsonString) as List)
        .map((jsonObject) => MapsObject.fromJson(jsonObject))
        .toList();
    // Print the decoded list of objects
    setState(() {
      mapsMenuItems = myObjects;
    });
  }

  // Save a new list to SharedPreferences
  Future<void> _saveList(List<MapsObject> newList) async {
    // Encode the list to a JSON-encoded string

    String jsonString = MapsObject.encode(newList);
    // Save the string to SharedPreferences
    await _prefs.setString('mapsMenuItems', jsonString);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result =
                  await Navigator.pushNamed(context, '/addMapLocation');
              mapsMenuItems.add(result as MapsObject);

              setState(() {
                _saveList(mapsMenuItems);
              });

              //mapsMenuItems.add(result as MapsObject);
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
                  itemCount: mapsMenuItems.length,
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
                        title: Text(mapsMenuItems[index].contact.name),
                        subtitle: Text(
                            'Description: ${mapsMenuItems[index].location}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () async {
                                // Handle edit button press
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditMapLocation(
                                        maps: mapsMenuItems[index]),
                                  ),
                                );
                                setState(() {
                                  mapsMenuItems[index] = (result as MapsObject);
                                  _saveList(mapsMenuItems);
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Handle delete button press
                                setState(() {
                                  mapsMenuItems.remove(mapsMenuItems[index]);
                                  _saveList(mapsMenuItems);
                                });
                              },
                            ),
                          ],
                        ),
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
}

class MapsObject {
  Contact contact;
  String location;

  MapsObject({required this.contact, required this.location});

  factory MapsObject.fromJson(Map<String, dynamic> json) {
    return MapsObject(
      contact: Contact.fromJson((json['contact'])),
      location: json['location'],
    );
  }

  static Map<String, dynamic> toMap(MapsObject mapsObject) => {
        'contact': Contact.toMap(mapsObject.contact),
        'location': mapsObject.location,
      };

  static String encode(List<MapsObject> objects) => json.encode(
        objects
            .map<Map<String, dynamic>>((item) => MapsObject.toMap(item))
            .toList(),
      );

  static List<MapsObject> decode(String jsonString) =>
      (json.decode(jsonString) as List<dynamic>)
          .map<MapsObject>((item) => MapsObject.fromJson(item))
          .toList();
}
