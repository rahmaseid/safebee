import 'package:flutter/material.dart';



class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SafeBee'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      //body: const Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        //  crossAxisAlignment: CrossAxisAlignment.center,
        //children: <Widget> [
            //Text('Hello world. How can I help you?'),
        //],
      //),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              Text('Hello. How can I help you?')
            ],
          ),
          TextButton(
            onPressed: null,
            style: ButtonStyle(
             backgroundColor: MaterialStatePropertyAll(Colors.lightBlue),
            ),
            child: Text("Car Crash",
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.lime)
            ),
            child: Text("Fire",
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red)
            ),
            child: Text("Lost",
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
        TextButton(
          onPressed: null,
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.deepPurpleAccent)
          ),
          child: Text("Trapped/Kidnapped",
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              color: Colors.black,
              ),
            ),
          ),
        TextButton(
          onPressed: null,
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)
          ),
          child: Text("Chemical Outbreak",
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight:FontWeight.bold,
              fontSize: 15.0,
              color: Colors.black,
              )
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.deepPurpleAccent,
        child: const Text(
          "I'm okay",
        style: TextStyle(
          fontFamily: 'Ubuntu',
          color: Colors.black,
        ),
      ),
    ));

  }
}




