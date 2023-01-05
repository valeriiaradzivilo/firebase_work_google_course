import 'package:cloud_firestore/cloud_firestore.dart';

import '../classes/MessageClass.dart';

class MessagesList
{
  List<Message> messagesList = [];

  Future<void> getMessages(String fromName) async
  {
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('messages');
    QuerySnapshot querySnapshot = await usersCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    for (QueryDocumentSnapshot document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      if(data['fromName']==fromName){
        print("${data['fromName']} - ${data['messageText']}");
        messagesList.add(Message(false,data['messageText']));
      }
    }

  }

  List<Message> getMessageList ()
  {
    return messagesList;
  }




}