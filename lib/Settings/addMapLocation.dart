import 'package:flutter/material.dart';
import 'package:safebee/Settings/mapsPage.dart';
import 'package:safebee/screens/contacts_page.dart';

class AddMapLocation extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

List<Contact> defaultcontacts = [
  Contact(
      name: 'Mom', phoneNumber: '123-456-7890', userId: '001', priority: '1'),
  Contact(
      name: 'Dad', phoneNumber: '987-654-3210', userId: '002', priority: '2'),
  Contact(
      name: 'Aunt Lisa',
      phoneNumber: '456-789-0123',
      userId: '003',
      priority: '3'),
  // Has the ability to either preload more contacts or dynamically add contacts
];

class _MyFormState extends State<AddMapLocation> {
  final _formKey = GlobalKey<FormState>();
  Contact dropdownValue = defaultcontacts.toList().first;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Form Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              DropdownButton<Contact>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (Contact? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: defaultcontacts
                    .map<DropdownMenuItem<Contact>>((Contact value) {
                  return DropdownMenuItem<Contact>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'location',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  // You can add more complex email validation logic here
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Validate the form
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, process the data
                    var returnObj = MapsObject(
                        contact: dropdownValue,
                        location: _locationController.text);

                    // You can perform actions with the form data here
                    Navigator.pop(context, returnObj);
                    // For demonstration purposes, print the data
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
