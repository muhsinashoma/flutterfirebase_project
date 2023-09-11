import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase_project/screens/insert_data.dart';

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Students');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('Students');
  Widget ListItem({required Map student}) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      // height: 110,
      color: Colors.amberAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            //  'Email',
            student['email'],
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            // 'Name',
            student['name'],
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            // 'Phone',
            student['phone'],
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  reference.child(student['key']).remove();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  } //ListItem()

  @override
  Widget build(BuildContext context) {
    //return const Placeholder();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Fetching Data From Firebase Realtime Database In Flutter'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirebaseProject()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          //  height: double.infinity,  //showing error in design

          height: 800,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map student = snapshot.value as Map;
              student['key'] = snapshot.key;
              return ListItem(student: student);
            },
          ),
        ),
      ),
    );
  } //build
} //FetchData
