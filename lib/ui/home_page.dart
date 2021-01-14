import 'dart:io';

import 'package:contact_list/helpers/contact_helper.dart';
import 'package:contact_list/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact_page.dart';

enum OrderOptions { orderaz, orderza }

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
    _showAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.group_sharp),
          title: Text(
            'Contact List',
            style: TextStyle(fontSize: 30, color: Colors.blueGrey[50]),
          ),
          backgroundColor: Colors.cyan[700],
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<OrderOptions>(
              itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                const PopupMenuItem<OrderOptions>(
                  child: Text('Order A-Z'),
                  value: OrderOptions.orderaz,
                ),
                const PopupMenuItem<OrderOptions>(
                  child: Text('Order Z-A'),
                  value: OrderOptions.orderza,
                ),
              ],
              onSelected: _orderList,
            )
          ],
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showContactPage();
          },
          child: Icon(Icons.person_add_alt_1),
          backgroundColor: Colors.amber[700],
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: contacstList.length,
            itemBuilder: (context, index) {
              return ContactCard(
                contact: contacstList[index],
                onTap: () => _showOptions(context, index),
              );
            }));
  }

  void _showContactPage({Contact contact}) async {
    final _returnedContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactPage(
                  contact: contact,
                )));
    if (_returnedContact != null) {
      if (contact != null) {
        await helper.updateContact(_returnedContact);
      } else {
        await helper.saveContact(_returnedContact);
      }
    }
    _showAllContacts();
  }

  void _showAllContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        contacstList = list;
      });
    });
  }

  void _showOptions(context, index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          child: Text(
                            'Call',
                            style: TextStyle(color: Colors.blueGrey[300], fontSize: 20),
                          ),
                          onPressed: () {
                            launch('tel:${contacstList[index].phone}');
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.red[300], fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _showContactPage(contact: contacstList[index]);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.red[300], fontSize: 20),
                          ),
                          onPressed: () {
                            helper.deleteContact(contacstList[index].id);
                            setState(() {
                              contacstList.removeAt(index);
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  void _orderList(OrderOptions value) {
    switch (value) {
      case OrderOptions.orderaz:
        {
          contacstList.sort((a, b) {
            return a.name.toLowerCase().compareTo(b.name.toLowerCase());
          });
        }
        break;
      case OrderOptions.orderza:
        {
          contacstList.sort((a, b) {
            return b.name.toLowerCase().compareTo(a.name.toLowerCase());
          });
        }
        break;
    }
    setState(() {});
  }
}
