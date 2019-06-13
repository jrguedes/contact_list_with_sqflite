import 'dart:io';

import 'package:contact_list/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool _userEdited = false;
  Contact _editedContact;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _nameFocus = FocusNode();

  @override
  void initState() {
    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = widget.contact;
      setState(() {
        _nameController.text = _editedContact.name;
        _emailController.text = _editedContact.email;
        _phoneController.text = _editedContact.phone;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _requestPop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _editedContact.name ?? 'Novo Contato',
            style: TextStyle(fontSize: 35, color: Colors.red[50]),
          ),
          centerTitle: true,
          backgroundColor: Colors.red[300],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editedContact.name != null && _editedContact.name.isNotEmpty) {
              Navigator.pop(context, _editedContact);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
          child: Icon(
            Icons.save,
          ),
          backgroundColor: Colors.red[300],
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                            image: _editedContact.img != null
                                ? FileImage(File(_editedContact.img))
                                : AssetImage('images/person.png'))),
                  ),
                  onTap: () {
                    ImagePicker.pickImage(source: ImageSource.gallery)
                        .then((file) {
                      if (file == null) {
                        return;
                      } else {
                        setState(() {
                          _editedContact.img = file.path;
                        });
                      }
                    });
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 20),),
                Form(
                    child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _nameController,
                      focusNode: _nameFocus,
                      decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle:
                              TextStyle(fontSize: 22, color: Colors.black),
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        setState(() {
                          _userEdited = true;
                          _editedContact.name = value;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(fontSize: 22, color: Colors.black),
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        setState(() {
                          _userEdited = true;
                          _editedContact.email = value;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Phone',
                          labelStyle:
                              TextStyle(fontSize: 22, color: Colors.black),
                          border: OutlineInputBorder()),
                      onChanged: (value) {
                        setState(() {
                          _userEdited = true;
                          _editedContact.phone = value;
                        });
                      },
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Registro Alterado'),
              content: Text('Deseja sair sem salvar as alterações?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('Sim'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
