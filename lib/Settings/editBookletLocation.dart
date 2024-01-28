import 'package:flutter/material.dart';
import 'package:safebee/Settings/bookletPage.dart';
import 'package:safebee/screens/contacts_page.dart';

class EditBookletLocation extends StatefulWidget {
  @override
  const EditBookletLocation({super.key, required this.booklets});
  final BookletsObject booklets;
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

class _MyFormState extends State<EditBookletLocation> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Contact dropdownValue = defaultcontacts.toList().first;

    TextEditingController _nameController =
        TextEditingController(text: widget.booklets.Name);
    TextEditingController _ActionNameController =
        TextEditingController(text: widget.booklets.Action.actionName);
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
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              SizedBox(height: 16.0),
              Text("Action"),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _ActionNameController,
                decoration: InputDecoration(
                  labelText: 'Action Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Action Name';
                  }
                  // You can add more complex email validation logic here
                  return null;
                },
              ),
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
              ElevatedButton(
                onPressed: () {
                  // Validate the form
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, process the data
                    var returnObj = BookletsObject(
                        Name: _nameController.text,
                        Action: ActionsObject(
                            actionName: _ActionNameController.text,
                            contact: dropdownValue));
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
