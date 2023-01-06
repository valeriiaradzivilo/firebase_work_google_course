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
  late List<Message> messagesForUser;
  MessagesList messagesList = MessagesList();


  Future<void> loadMessages() async
  {
    await messagesList.getMessages("Lerok");
    messagesForUser = messagesList.getMessageList();
    print("loading complete");
  }

  @override
  void initState() {
    loadMessages();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(title: Text("Sanyok"),),
        body: SingleChildScrollView(
          child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 540,
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                        return Text(messagesForUser.elementAt(index).message);
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
                                        FirebaseSendMessage("Lerok", "Sanyok",
                                            messageController.text);
                                    newMessage.sendMessage();
                                    messageController.clear();

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



    );
  }
}
