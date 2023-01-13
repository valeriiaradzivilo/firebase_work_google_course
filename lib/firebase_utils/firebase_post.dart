
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseSendMessage{
  final String fromName;
  final String toName;
  final String messageText;
  final Timestamp time;

  FirebaseSendMessage(this.fromName, this.toName, this.messageText,this.time);

  Future<void> sendMessage()
  {
    CollectionReference messages = FirebaseFirestore.instance.collection('messages');
    return messages.add(
      {
        'fromName': fromName,
        'toName': toName,
        'messageText': messageText,
        'time': time
      }
    ).then((value) => print("Message sent"))
        .catchError((error) => print("Failed to message user: $error"));
  }




}