import 'package:flutter/material.dart';
import 'package:safebee/services/calls_and_messages_service.dart'; //imported to support calls and messages
import 'package:safebee/services/service_locator.dart'; //imported to support calls and messages

//---------------------This is our Contacts page--------------
            // This page Delivers 5 major functions
                // 1. Add a contact
                // 2. Edit a contact
                // 3. Delete a contact
                // 4. Call a contact
                // 5. Text a contact


class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}


class _ContactsPageState extends State<ContactsPage> {
              //List of preloaded contacts
      final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
      final String number = "123456789";
      final String email = "kaneRich@example.com";
  
  List<Contact> contacts = [
    Contact(name: 'Mom', phoneNumber: '123-456-7890', userId: '001', priority: '1'),
    Contact(name: 'Dad', phoneNumber: '987-654-3210', userId: '002', priority: '2'),
    Contact(name: 'Aunt Lisa', phoneNumber: '456-789-0123', userId: '003', priority: '3'),
    // Has the ability to either preload more contacts or dynamically add contacts
  ];

  // Controllers for the text fields in the add/edit contact form
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController priorityController = TextEditingController();

  // Index of the contact being edited
  int editingIndex = -1;


                  //Building the Widget
  @override
  Widget build(BuildContext context) {
    // Here we Sort contacts by priority before displaying them 
    // to dynamically display the most important contacts first
    contacts.sort((a, b) => a.priority.compareTo(b.priority));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contacts[index].name),
            subtitle: Text(contacts[index].phoneNumber),
            onTap: () {
              // Here we are showing the add/edit contact form 
              // with the selected contact's data
              _showAddEditContactForm(context, contact: contacts[index], index: index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Showing the add/edit contact form for adding a new contact
          _showAddEditContactForm(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Method to show the add/edit contact form
  void _showAddEditContactForm(BuildContext context, {Contact? contact, int? index}) {
    // Initializing controllers with existing contact data for editing
    if (contact != null) {
      nameController.text = contact.name;
      phoneNumberController.text = contact.phoneNumber;
      userIdController.text = contact.userId;
      priorityController.text = contact.priority;
      editingIndex = index!;
    } else {
      // Clearing controllers for adding new contacts
      nameController.clear();
      phoneNumberController.clear();
      userIdController.clear();
      priorityController.clear();
      editingIndex = -1;
    }
  //displaying the dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // The content of the dialog based on whether we are adding or editing
          title: Text(contact == null ? 'Add Contact' : 'Edit Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //the text fields for the contact form
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: userIdController,
                decoration: InputDecoration(labelText: 'User ID'),
              ),
              TextField(
                controller: priorityController,
                decoration: InputDecoration(labelText: 'Priority'),
              ),
              //call or text buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //here we are calling the call and text functions from the service locator
                  ElevatedButton(
                    onPressed: () => _service.call(number),
                    child: Text('Call'),
                  ),
                  ElevatedButton(
                    onPressed: () => _service.sendSms(number),
                    child: Text('Text'),
                  ),
                ],
              ), 
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Saves the contact or updates the existing contact
                Contact newContact = Contact(
                  name: nameController.text,
                  phoneNumber: phoneNumberController.text,
                  userId: userIdController.text,
                  priority: priorityController.text,
                );

                if (editingIndex != -1) {
                  // If editing, we replace the old contact with the new updated contact
                  setState(() {
                    contacts[editingIndex] = newContact;
                  });
                } else {
                  // If we are adding, we then add the new contact to the list
                  setState(() {
                    contacts.add(newContact);
                  });
                }

                // here Sort contacts by priority before closing the dialog
                contacts.sort((a, b) => a.priority.compareTo(b.priority));

                // simply closing the dialog
                Navigator.pop(context);
              },
              // The text on the button changes based on whether we are adding or editing
              child: Text(editingIndex != -1 ? 'Save Changes' : 'Add Contact'),
            ),
            if (editingIndex != -1)
              ElevatedButton(
                onPressed: () {
                  // This deletes the contact
                  setState(() {
                    contacts.removeAt(editingIndex);
                  });
                  // Another instance of Sorting contacts by priority before we close the dialog
                  contacts.sort((a, b) => a.priority.compareTo(b.priority));
                  // Close the dialog
                  Navigator.pop(context);
                },
                // Here we are choosing red to be the color of the delete button
                // to make the user more aware of the action they are about to take
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Delete Contact'),
              ),
          ],
        );
      },
    );
  }
}




                      //Contact class
class Contact {
  final String name;
  final String phoneNumber;
  final String userId;
  final String priority;


            //A contact must have a name, phone number, user id, and priority
  Contact({required this.name, required this.phoneNumber, required this.userId, required this.priority});
}



// push 
// push