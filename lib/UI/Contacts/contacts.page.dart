import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectfirstapp/bloc/contacts.blocs.dart';
import 'package:projectfirstapp/model/contact.model.dart';
List<Contact> contacts =
[Contact(1, 'manel', 'famille'),
  Contact(2, 'nour', 'amis'),
  Contact(3, 'hiba', 'amis'),
  Contact(4, 'souhir', 'famille'),
  Contact(5, 'nesrine', 'famille')]
;

class ContactsPage extends StatelessWidget {





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text('Contacts'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Column(

                        children: [
                    for (var c in contacts)
                        Text(c.name.toString())


                ],),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FamilleContacts()),
                    );

                  },
                  child: Text('Famille'),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AmisContacts()),
                    );

                  },
                  child: Text('amis'),
                ),

              ],
            ),
          ),


        ],

      ),
    );

  }
}




// Page : affichage des contacts de famille
class FamilleContacts extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Famille Contacts'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: (){},
              title:Text(contacts[index].name),

            ),
          );
        },
      )


      );


  }
}

class AmisContacts extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Amis Contacts'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Column(

                  children: [
                    for (var c in contacts)
                      if(c.profile=='amis')
                        Text(c.name.toString())

                  ],),

              ],
            ),
          ),


        ],

      ),
    );

  }
}

//page : form ajout de contact
class suppContact extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Famille Contacts'),
      ),
      body: Column(
        children: [


        ],

      ),
    );

  }
}

