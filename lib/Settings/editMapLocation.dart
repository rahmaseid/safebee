import 'package:flutter/material.dart';
import 'package:safebee/Settings/mapsPage.dart';

class EditMapLocation extends StatefulWidget {
  @override
  const EditMapLocation({super.key, required this.maps});
  final MapsObject maps;
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<EditMapLocation> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController =
        TextEditingController(text: widget.maps.id);
    TextEditingController _locationController =
        TextEditingController(text: widget.maps.Location);
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
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Location';
                  }
                  // You can add more complex email validation logic here
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text(widget.maps.Location),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Validate the form
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, process the data
                    var returnObj = MapsObject(
                        id: _nameController.text,
                        Location: _locationController.text);

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
