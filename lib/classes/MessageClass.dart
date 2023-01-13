import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  bool isSender;
  String message;
  Timestamp time;

  Message(this.isSender, this.message, this.time);
}