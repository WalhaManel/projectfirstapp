import 'package:bloc/bloc.dart';
import 'package:projectfirstapp/model/contact.model.dart';
import 'package:projectfirstapp/repository/contact.rep.dart';

abstract class ContactsEvent{}
  class LoadAllContactsEvent extends ContactsEvent{}

enum RequestState {LOADING,LOADED,ERROR,NONE}
class ContactsState{
  List<Contact> contacts;
  RequestState requestState;
  String errorMessage;
  ContactsState({this.contacts, this.requestState, this.errorMessage});

}


class ContactsBloc extends Bloc<ContactsEvent,ContactsState>{
ContactRep ContactsRepository;
ContactsBloc(ContactsState initialState,this.ContactsRepository):super(initialState);

@override
Stream<ContactsState> add(ContactsEvent event) async*{
  if(event is LoadAllContactsEvent )
    {
      yield ContactsState(contacts: state.contacts,requestState :RequestState.LOADING);
     try {
       List<Contact> data = await ContactsRepository.allContacts();
       yield ContactsState(contacts: data, requestState: RequestState.LOADED);
     } catch(e){
       yield ContactsState(contacts: state.contacts,requestState: RequestState.ERROR);
     }
    }

}
}