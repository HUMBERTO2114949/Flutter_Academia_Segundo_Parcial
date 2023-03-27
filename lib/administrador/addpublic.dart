import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'administrador.dart';

class addnote extends StatelessWidget {
  TextEditingController titulo = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController link = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('report');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        actions: [
          MaterialButton(
            onPressed: () {
              ref.add({
                'Titulo': titulo.text,
                'Descripcion': descripcion.text,
                'Link': link.text
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Administrador()));
              });
            },
            child: Text(
              "Guardar",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Administrador()));
            },
            child: Text(
              "Regresar",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: titulo,
                decoration: InputDecoration(
                  hintText: 'Titulo',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: descripcion,
                decoration: InputDecoration(
                  hintText: 'Descripcion',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: link,
                decoration: InputDecoration(
                  hintText: 'link',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}