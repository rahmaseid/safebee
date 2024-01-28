import 'package:flutter/material.dart';



class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Type of Emergency'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        //color: Colors.white,
      ),

      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          List <String> names = ['Car Crash','Fire', 'Lost/Kidnapped', 'Trapped','Chemical Outbreak','Other' ];
          return Container(
            constraints: BoxConstraints(
              minHeight: 50, // Adjust this according to your needs
            ),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  trailing: Icon(Icons.device_hub),
                  title: Text('${names[index]}'),
                  leading: Icon(Icons.local_activity),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1, // Adjust the thickness of the divider if needed
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(height: 0),
        itemCount: 6,
      ),
    );
  }
}




