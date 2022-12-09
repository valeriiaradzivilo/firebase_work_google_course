import 'package:cloud_firestore/cloud_firestore.dart';

import '../classes/MessageClass.dart';

class MessagesList
{
  List<Message> messagesList = [];

  Future<void> getMessages() async
  {
    CollectionReference messages = FirebaseFirestore.instance.collection('messages');
    var querySnapshot = await messages.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      messagesList.add(Message(queryDocumentSnapshot.data["fromName"]=="Sanyok", message))
    }
  }




}