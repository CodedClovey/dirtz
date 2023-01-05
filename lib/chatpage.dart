import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

var prefs;

var colnm = 'G1';
var msj = 'si';

class Database {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addMsg(Map<String, dynamic> set, String col) async {
    await _db.collection(col).doc().set(set);
  }
}

class CPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CPage();
}

class _CPage extends State<CPage> {
  final TextEditingController _msgg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
        backgroundColor: const Color(0xff171c21),
      ),
      backgroundColor: const Color(0xff171c21),
      body: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 75,
              color: Colors.white10,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        colnm = 'G1';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white24,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("G1"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        colnm = 'G2';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white24,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("G2"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: 70,
                color: Colors.white30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: Database._db.collection(colnm).snapshots(),
                          builder: (BuildContext context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("no");
                            }
                            return ListView(
                              children: snapshot.data!.docs.map((document) {
                                return Container(
                                  margin: const EdgeInsets.all(5),
                                  color: Colors.white24,
                                  child: ListTile(
                                    title: Text(
                                        document['n'] + ': ' + document['m']),
                                  ),
                                );
                              }).toList(),
                            );
                          }),
                    ),
                    TextField(
                      controller: _msgg,
                      onSubmitted: (ow) {
                        msj = ow;
                        Database.addMsg(
                            {'m': ow, 'n': prefs.getString('n')}, colnm);
                        _msgg.text = '';
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(),
                        hintText: 'Message',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
