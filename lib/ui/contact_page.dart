import 'dart:io';

import 'package:contact_list/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _editedContact.name ?? 'Novo Contato',
          style: TextStyle(fontSize: 25, color: Colors.red[50]),
        ),
        centerTitle: true,
        backgroundColor: Colors.red[300],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
                          image: _editedContact.img != null
                              ? FileImage(File(_editedContact.img))
                              : AssetImage('images/person.png'))),
                ),
                onTap: () {},
              ),
              Form(
                  child: Column(
                children: <Widget>[
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle:
                            TextStyle(fontSize: 22, color: Colors.black),
                        border: OutlineInputBorder()),
                    onChanged: (value) {
                      _userEdited = true;
                      setState(() {
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
                      _editedContact.email = value;
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
                      _editedContact.phone = value;
                    },
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
