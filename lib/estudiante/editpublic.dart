import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'estudiante.dart';
import 'report.dart';

class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState(docid: docid);
}

class _editnoteState extends State<editnote> {
  DocumentSnapshot docid;
  _editnoteState({required this.docid});

  TextEditingController titulo = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController link = TextEditingController();
  String categoriaSeleccionada = '';

  @override
  void initState() {
    titulo = TextEditingController(text: widget.docid.get('Titulo'));
    descripcion = TextEditingController(text: widget.docid.get('Descripcion'));
    link = TextEditingController(text: widget.docid.get('Link'));
    categoriaSeleccionada = widget.docid.get('Categoria');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Estudiante()));
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
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: titulo,
                  decoration: InputDecoration(
                    hintText: 'Titulo',
                  ),
                  enabled: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: descripcion,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Descripcion',
                  ),
                  enabled: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: link,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'link',
                  ),
                  enabled: false,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: DropdownButtonFormField<String>(
                  value: categoriaSeleccionada,
                  items: [
                    DropdownMenuItem(
                      child: Text('PHP'),
                      value: 'PHP',
                    ),
                    DropdownMenuItem(
                      child: Text('JAVA'),
                      value: 'JAVA',
                    ),
                    DropdownMenuItem(
                      child: Text('PHYTON'),
                      value: 'PHYTON',
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      categoriaSeleccionada = value!;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Categoria',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (_) => reportt(
                        docid: docid,
                      ),
                    ),
                              );
                },
                child: Text(
                  "Crear informe",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 251, 251, 251),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
