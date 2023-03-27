import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:segundo_parcial/docente/phyton.dart';
import 'package:segundo_parcial/estudiante/estudiante.dart';
import 'package:segundo_parcial/estudiante/java.dart';

import '../login.dart';
import 'editpublic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PHPPAGE());
}

class PHPPAGE extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PHPPAGE> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Proyectos",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 0, 11, 133),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
    .collection('report')
    .where('Categoria', isEqualTo: 'PHP')
    .snapshots();

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
                'Inicio',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Estudiante()),
                );
              },
            ),
            ListTile(
              title: Text(
                'JAVA Categoria',
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
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Algo está mal");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            editnote(docid: snapshot.data!.docs[index]),
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
                            snapshot.data!.docs[index]['Titulo'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data!.docs[index]['Categoria'],
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
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
