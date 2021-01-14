import 'dart:io';

import 'package:contact_list/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback onTap;

  const ContactCard({Key key, @required this.contact, @required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _contactCard(context);
  }

  Widget _contactCard(context) {
    return GestureDetector(
      onTap: onTap,
      child: SingleChildScrollView(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.cyan[600],
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
                            fit: BoxFit.cover,
                            image:
                                contact.img != null ? FileImage(File(contact.img)) : AssetImage('images/person.png'))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          contact.name ?? '',
                          style: TextStyle(color: Colors.deepOrange[50], fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          contact.phone ?? '',
                          style: TextStyle(fontSize: 18, color: Colors.blueGrey[50]),
                        ),
                        Text(
                          contact.email ?? '',
                          style: TextStyle(fontSize: 18, color: Colors.grey[100]),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
