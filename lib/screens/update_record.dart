import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase_project/screens/fetch_data.dart';

class UpateRecord extends StatefulWidget {
  const UpateRecord({super.key, required this.studentKey});

  final String studentKey;

  @override
  State<UpateRecord> createState() => _UpateRecordState();
}

class _UpateRecordState extends State<UpateRecord> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPhoneController = TextEditingController();
  final TextEditingController userAddressController = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Students');
    getStudentData();
  }

  void getStudentData() async {
    DataSnapshot snapshot = await dbRef.child(widget.studentKey).get();

    Map student = snapshot.value as Map;

    userNameController.text = student['name'];
    userEmailController.text = student['email'];
    userPhoneController.text = student['phone'];
    userAddressController.text = student['address'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updating Record'),
        centerTitle: true,
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
                height: 15,
              ),
              TextField(
                controller: userAddressController,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    hintText: "Enter Your Address",
                    labelText: "Address",
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  Map<String, String> students = {
                    'name': userNameController.text,
                    'email': userEmailController.text,
                    'phone': userPhoneController.text,
                    'address': userAddressController.text,
                  };

                  dbRef
                      .child(widget.studentKey)
                      .update(students)
                      .then((value) => {Navigator.pop(context)});

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => FetchData()));
                }, //onPressed
                child: Text('Update Data'),
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
  }
}
