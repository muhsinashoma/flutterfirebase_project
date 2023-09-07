import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirebaseProject extends StatefulWidget {
  const FirebaseProject({super.key});

  @override
  State<FirebaseProject> createState() => _FirebaseProjectState();
}

class _FirebaseProjectState extends State<FirebaseProject> {
  //var userNameController;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPhoneController = TextEditingController();

  late DatabaseReference dbRef;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Students');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert using firebase'),
        centerTitle: true,
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Inserting data in Firebase Realtime Database ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: userNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Enter Your Name",
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: userEmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter Your Email Address",
                  labelText: "Email Address",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: userPhoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Enter Your Phone Number",
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  Map<String, String> students = {
                    'name': userNameController.text,
                    'email': userEmailController.text,
                    'phone': userPhoneController.text
                  };

                  dbRef.push().set(students);
                },
                child: Text('Insert Data'),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 45,
              ),
            ],
          ),
        ),
      ),
    );
  } //build
}  // FirebaseProject
