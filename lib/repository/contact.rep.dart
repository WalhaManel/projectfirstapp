import 'dart:math';

import 'package:projectfirstapp/model/contact.model.dart';

class ContactRep{
  Map<int,Contact> contacts = {
    1: Contact(1,'manel','famille'),
    2: Contact(2,'nour','amis'),
    3: Contact(3,'hiba','amis')
  };

  Future<List<Contact>> allContacts() async{
   var future= await Future.delayed(Duration(seconds: 1));
   int rnd=new Random().nextInt(10);
   if(rnd>3){
     return contacts.values.toList();
   }else{
     throw new Exception('Erreur ');
   }
  }
 /* Future<List<Contact>> ContactsByType(String prof) async{
    var future= await Future.delayed(Duration(seconds: 1));
    int rnd=new Random().nextInt(10);
    if(rnd>3){
      //return contacts.values.toList().where((element) => element.profile==prof);
    }else{
      throw new Exception('Erreur ');
    }
  }
*/

}