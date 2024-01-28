import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:safebee/Settings/SettingsItemClass.dart';
import 'package:safebee/Settings/addBookletLocation.dart';
import 'package:safebee/Settings/editBookletLocation.dart';
import 'package:safebee/screens/contacts_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookletPage extends StatefulWidget {
  const BookletPage({super.key});

  @override
  State<BookletPage> createState() => _BookletPage();
}

class _BookletPage extends State<BookletPage> {
  late SharedPreferences _prefs;
  List<BookletsObject> bookletsMenuItems = [];

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  // Load the list from SharedPreferences
  Future<void> _loadList() async {
    _prefs = await SharedPreferences.getInstance();

    // Retrieve the JSON-encoded string from SharedPreferences
    String jsonString = _prefs.getString('bookletMenuItems') ?? '[]';
    // Decode the string to get the list

    List<BookletsObject> myObjects = (json.decode(jsonString) as List)
        .map((jsonObject) => BookletsObject.fromJson(jsonObject))
        .toList();

    // Print the decoded list of objects
    setState(() {
      bookletsMenuItems = myObjects;
    });
  }

  // Save a new list to SharedPreferences
  Future<void> _saveList(List<BookletsObject> newList) async {
    // Encode the list to a JSON-encoded string
    String jsonString = BookletsObject.encode(newList);
    // Save the string to SharedPreferences
    await _prefs.setString('bookletMenuItems', jsonString);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booklet Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.pushNamed(context, '/addBooklet');
              bookletsMenuItems.add(result as BookletsObject);

              setState(() {
                _saveList(bookletsMenuItems);
              });

              //bookletMenuItems.add(result as BookletsObject);
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
                  itemCount: bookletsMenuItems.length,
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
                        title: Text(bookletsMenuItems[index].Name),
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
                                    builder: (context) => EditBookletLocation(
                                      booklets: bookletsMenuItems[index],
                                    ),
                                  ),
                                );
                                setState(() {
                                  bookletsMenuItems[index] =
                                      (result as BookletsObject);
                                  _saveList(bookletsMenuItems);
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Handle delete button press
                                setState(() {
                                  bookletsMenuItems
                                      .remove(bookletsMenuItems[index]);
                                  _saveList(bookletsMenuItems);
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

  AddPage() {
    print("HI");
  }
}

class BookletsObject {
  String Name;
  ActionsObject Action;

  BookletsObject({required this.Name, required this.Action});

  factory BookletsObject.fromJson(Map<String, dynamic> json) {
    return BookletsObject(
      Name: json['Name'],
      Action: json['Action'],
    );
  }

  static Map<String, dynamic> toBooklet(BookletsObject bookletObject) => {
        'Name': bookletObject.Name,
        'Action': bookletObject.Action,
      };

  static String encode(List<BookletsObject> objects) => json.encode(
        objects
            .map<Map<String, dynamic>>((item) => BookletsObject.toBooklet(item))
            .toList(),
      );

  static List<BookletsObject> decode(String jsonString) =>
      (json.decode(jsonString) as List<dynamic>)
          .map<BookletsObject>((item) => BookletsObject.fromJson(item))
          .toList();
}

class ActionsObject {
  String actionName;
  Contact contact;

  ActionsObject({required this.contact, required this.actionName});

  factory ActionsObject.fromJson(Map<String, dynamic> json) {
    return ActionsObject(
      contact: Contact.fromJson((json['contact'])),
      actionName: json['actionName'],
    );
  }

  static Map<String, dynamic> toMap(ActionsObject mapsObject) => {
        'contact': Contact.toMap(mapsObject.contact),
        'actionName': mapsObject.actionName,
      };

  static String encode(List<ActionsObject> objects) => json.encode(
        objects
            .map<Map<String, dynamic>>((item) => ActionsObject.toMap(item))
            .toList(),
      );

  static List<ActionsObject> decode(String jsonString) =>
      (json.decode(jsonString) as List<dynamic>)
          .map<ActionsObject>((item) => ActionsObject.fromJson(item))
          .toList();
}
