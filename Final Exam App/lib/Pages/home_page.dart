import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final db = Firestore.instance;

    return  Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('exams').orderBy('name').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;

          return ListView.builder(

            itemCount: docs.length,
            itemBuilder: (context, index) {
              return Material(
                color: Colors.white,
                child: InkWell(
                    child: ListTile(
                      onTap: () {},
                      title: Text(
                        docs[index].data['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(docs[index].documentID),
                    ),
                  ),
              );
            },
          );
        },
      ),
    );
  }
}
