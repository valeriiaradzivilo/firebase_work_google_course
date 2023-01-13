import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_work_google_course/classes/MessageClass.dart';
import 'package:firebase_work_google_course/firebase_utils/messages_list.dart';
import 'package:flutter/material.dart';

import 'firebase_utils/firebase_post.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final messageController = TextEditingController();
  late MessagesList messagesList;
  late List<Message> messagesForUser = messagesList.getMessageList();
  bool isLoadedList = false;
  late String userGetter;
  late String userSender;

  Future<void> loadMessages() async {
    await messagesList.getMessages();
    messagesForUser = messagesList.getMessageList();
    print("loading complete");
    setState(() {
      isLoadedList = true;
    });
  }

  @override
  void initState() {
    userGetter = "Sanyok";
    userSender = "Lerok";
    messagesList = MessagesList(userSender, userGetter);
    loadMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text(userGetter),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  String tmp = userGetter;
                  userGetter = userSender;
                  userSender = tmp;
                  isLoadedList = false;
                  messagesList = MessagesList(userSender, userGetter);
                  loadMessages();
                });
              },
              icon: Icon(Icons.person_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Visibility(
          visible: isLoadedList,
          replacement: Center(child: const CircularProgressIndicator()),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 540,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: messagesForUser.elementAt(index).isSender
                                ?Alignment.centerRight:Alignment.centerLeft,
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:
                                        messagesForUser.elementAt(index).isSender
                                            ? Colors.indigo[300]
                                            : Colors.indigo[400]),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                    "${messagesForUser.elementAt(index).message}\n ${messagesForUser.elementAt(index).time.toDate().hour} : ${messagesForUser.elementAt(index).time.toDate().minute} ",
                                style: TextStyle(fontSize: 16),)),
                          ));
                    },
                    itemCount: messagesForUser.length,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter your message',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                FirebaseSendMessage newMessage =
                                    FirebaseSendMessage(
                                        userSender,
                                        userGetter,
                                        messageController.text,
                                        Timestamp.now());
                                newMessage.sendMessage();
                                messageController.clear();
                                setState(() {
                                  isLoadedList = false;
                                  // Reload the messages when the refresh button is pressed
                                  loadMessages();
                                });
                              },
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
