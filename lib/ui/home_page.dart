import 'dart:io';

import 'package:contact_list/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();
  List<Contact> contacstList = List<Contact>();

  @override
  void initState() {
    super.initState();

    /*
    Contact contact = Contact.create(
        'Luca Mendes', 'luca.mendes@gmail.com', '71988088763', 'myimage');
    helper.saveContact(contact);
    */

    helper.getAllContacts().then((list) {
      setState(() {
        contacstList = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Contact List',
            style: TextStyle(fontSize: 25, color: Colors.red[100]),
          ),
          backgroundColor: Colors.red[400],
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          backgroundColor: Colors.red[400],
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: contacstList.length,
            itemBuilder: _contactCard));
  }

  Widget _contactCard(context, index) {
    return GestureDetector(
      child: Card(
        color: Colors.red[400]
        ,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: contacstList[index].img != null
                              ? FileImage(File(contacstList[index].img))
                              : AssetImage('images/person.png'))),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        contacstList[index].name ?? '',
                        style: TextStyle(
                          color: Colors.pink[50],
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        contacstList[index].phone ?? '',
                        style: TextStyle(fontSize: 18, color: Colors.red[50]),

                      ),
                      Text(
                        contacstList[index].email ?? '',
                        style: TextStyle(fontSize: 18, color: Colors.red[50]),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
