// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseSendMessage{
  final String fromName;
  final String toName;
  final String messageText;

  FirebaseSendMessage(this.fromName, this.toName, this.messageText);

  Future<void> sendMessage()
  {
    CollectionReference messages = FirebaseFirestore.instance.collection('messages');
    return messages.add(
      {
        'fromName': fromName,
        'toName': toName,
        'messageText': messageText,
      }
    ).then((value) => print("Message sent"))
        .catchError((error) => print("Failed to message user: $error"));
  }




}