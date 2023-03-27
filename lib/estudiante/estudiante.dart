import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:segundo_parcial/estudiante/java.dart';
import 'package:segundo_parcial/estudiante/php.dart';
import 'package:segundo_parcial/estudiante/phyton.dart';

import '../login.dart';
import 'editpublic.dart';

class Estudiante extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Estudiante> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('report').snapshots();

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        title: Text('Estudiante'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 11, 133),
              ),
              child: Center(
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'PHP Categoria',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PHPPAGE()),
                );
              },
            ),
            ListTile(
              title: Text(
                'java Categoria',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JAVAPAGE()),
                );
              },
            ),
            ListTile(
              title: Text(
                'PHYTON Categoria',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PHYTONPAGE()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Buscar por palabra clave...',
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Algo estÃ¡ mal");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final filteredDocs = snapshot.data!.docs.where((doc) =>
                    doc['Titulo'].toString().contains(_searchQuery) ||
                    doc['Descripcion'].toString().contains(_searchQuery));

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    itemCount: filteredDocs.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => editnote(
                                docid: filteredDocs.elementAt(index),
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 3,
                                right: 3,
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                title: Text(
                                  filteredDocs
                                      .elementAt(index)['Titulo']
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data!.docChanges[index].doc['Categoria'],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}