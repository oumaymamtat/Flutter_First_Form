import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'model.dart';

// ignore: must_be_immutable
class Result extends StatelessWidget {
  Model model;
  Result({this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Data : '),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('data').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return GridView.count(
                crossAxisCount: 1,
                scrollDirection: Axis.vertical,
                children: snapshot.data.docs.map((data) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: ListView(
                      key: ValueKey(Record.fromSnapshot(data).location),
                      children: <Widget>[
                        // Text( Record.fromSnapshot(data).location,),

                        RichText(
                          text: new TextSpan(
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              new TextSpan(
                                  text: 'First Name :',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)),
                              new TextSpan(
                                  text: data['first'],
                                  style: TextStyle(fontSize: 18.0)),
                            ],
                          ),
                        ),

                        RichText(
                          text: new TextSpan(
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              new TextSpan(
                                  text: 'Last Name :',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)),
                              new TextSpan(
                                  text: data['last'],
                                  style: TextStyle(fontSize: 18.0)),
                            ],
                          ),
                        ),

                        RichText(
                          text: new TextSpan(
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              new TextSpan(
                                  text: 'Email :',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)),
                              new TextSpan(
                                  text: data['email'],
                                  style: TextStyle(fontSize: 18.0)),
                            ],
                          ),
                        ),

                        RichText(
                          text: new TextSpan(
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              new TextSpan(
                                  text: 'Password :',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)),
                              new TextSpan(
                                  text: data['password'],
                                  style: TextStyle(fontSize: 18.0)),
                            ],
                          ),
                        ),
                        Divider(),
                        Image.network(Record.fromSnapshot(data).url),
                      ],
                    ),
                  );
                }).toList(),
              );
            }));
  }
}

class Record {
  final String location;
  final String url;
  final DocumentReference reference;
  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['location'] != null),
        assert(map['url'] != null),
        location = map['location'],
        url = map['url'];
  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
  @override
  String toString() => "Record<$location:$url>";
}
