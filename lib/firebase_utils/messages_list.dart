import 'package:cloud_firestore/cloud_firestore.dart';

import '../classes/MessageClass.dart';

class MessagesList
{
  String senderUser;
  String getterUser;

  MessagesList(this.senderUser, this.getterUser);
  List<Message> messagesList = [];

  Future<void> getMessages() async
  {
    messagesList.clear();
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('messages');
    QuerySnapshot querySnapshot = await usersCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    for (QueryDocumentSnapshot document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      if(data['fromName']==senderUser || data['fromName']==getterUser  ){
        print("${data['fromName']} - ${data['messageText']}");
        messagesList.add(Message(data['fromName']==senderUser?true:false,data['messageText'],data['time']));
      }
    }

  }

  List<Message> getMessageList ()
  {
    messagesList.sort((a, b) => a.time.microsecondsSinceEpoch.compareTo(b.time.microsecondsSinceEpoch));
    return messagesList;
  }




}