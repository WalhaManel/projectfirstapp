import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher.dart';

List<Contact> famille =[];
List<Contact> favories =[];

void main() async {
  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Contact> contacts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();
  }

  void getContact() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      print(contacts);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "***  Contacts  ***",
            style: TextStyle(color: Colors.white),
          ),

            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FamilleContacts()),
                    );},
                    child: Icon(
                      Icons.home_rounded,
                      size: 26.0,
                    ),
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoriesContacts()),
                    );},
                    child: Icon(
                      Icons.favorite_border,
                      size: 26.0,
                    ),
                  )
              )]
        ),


        body:
        (contacts) == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  Uint8List image = contacts[index].photo;
                  String num = (contacts[index].phones.isNotEmpty)
                      ? (contacts[index].phones.first.number)
                      : "--";
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (DismissDirection direction) async {

                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirmation de suppression"),
                            content: const Text("voulez vous vraiment supprimer ce contact ?"),
                            actions: <Widget>[
                              ElevatedButton(
                                  onPressed: (){
                                    Navigator.of(context).pop(true);
                                    setState(() {
                                      contacts.removeAt(index);
                                    });
                          } ,
                                  child: const Text("Supprimer"),

                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text("Cancel"),
                              ),
                            ],
                          );
                        },

                      );

                    },

                    child: ListTile(
                        onLongPress: () {
                           showDialog(
                              context: context,
                              builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Ajouter à"),
                              content: const Text("Sélectionner une liste "),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: (){
                                    famille.add(contacts[index]);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => FamilleContacts()),
                                    );
                                  } ,
                                  child: const Text("Famille"),

                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    favories.add(contacts[index]);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => FavoriesContacts()),
                                    );
                                  },
                                  child: const Text("Favories"),
                                ),
                              ],
                            );
                          },

                          );
                        },
                        leading: (contacts[index].photo == null)
                            ? const CircleAvatar(child: Icon(Icons.person))
                            : CircleAvatar(backgroundImage: MemoryImage(image)),
                        title: Text(
                            "${contacts[index].name.first} ${contacts[index].name.last}"),
                        subtitle: Text(num),
                        onTap: () {
                          if (contacts[index].phones.isNotEmpty) {
                            launch('tel: ${num}');
                          }
                        }),
                  );
                },
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
          title: const Text(
            "***  Contacts de famille  ***",
            style: TextStyle(color: Colors.white),
          ),

        ),
        body: (famille) == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: famille.length,
          itemBuilder: (BuildContext context, int index) {
            Uint8List image = famille[index].photo;
            String num = (famille[index].phones.isNotEmpty)
                ? (famille[index].phones.first.number)
                : "--";
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (DismissDirection direction) async {

                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Delete Confirmation"),
                      content: const Text("Are you sure you want to delete this contact?"),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).pop(true);
                              famille.removeAt(index);
                          } ,
                          child: const Text("Delete"),

                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Cancel"),
                        ),
                      ],
                    );
                  },

                );

              },
              child: ListTile(
                  leading: (famille[index].photo == null)
                      ? const CircleAvatar(child: Icon(Icons.person))
                      : CircleAvatar(backgroundImage: MemoryImage(image)),
                  title: Text(
                      "${famille[index].name.first} ${famille[index].name.last}"),
                  subtitle: Text(num),
                  onTap: () {
                    if (famille[index].phones.isNotEmpty) {
                      launch('tel: ${num}');
                    }
                  }),
            );
          },
        )


    );


  }
}
// Page : affichage des contacts des favories
class FavoriesContacts extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "***  Contacts favories  ***",
            style: TextStyle(color: Colors.white),
          ),

        ),
        body: (favories) == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: favories.length,
          itemBuilder: (BuildContext context, int index) {
            Uint8List image = favories[index].photo;
            String num = (favories[index].phones.isNotEmpty)
                ? (favories[index].phones.first.number)
                : "--";
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (DismissDirection direction) async {

                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Delete Confirmation"),
                      content: const Text("Are you sure you want to delete this contact?"),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).pop(true);
                            favories.removeAt(index);
                          } ,
                          child: const Text("Delete"),

                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Cancel"),
                        ),
                      ],
                    );
                  },

                );

              },
              child: ListTile(
                  leading: (famille[index].photo == null)
                      ? const CircleAvatar(child: Icon(Icons.person))
                      : CircleAvatar(backgroundImage: MemoryImage(image)),
                  title: Text(
                      "${famille[index].name.first} ${famille[index].name.last}"),
                  subtitle: Text(num),
                  onTap: () {
                    if (famille[index].phones.isNotEmpty) {
                      launch('tel: ${num}');
                    }
                  }),
            );
          },
        )


    );


  }
}
