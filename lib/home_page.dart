import 'package:flutter/cupertino.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: null,
        body: Padding(
          padding: const EdgeInsets.only(top:50.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
               Container(
                   padding: EdgeInsets.all(10),
                   width: 600,
                   height: 50,
                   child: Text("Lerok",
                   style: TextStyle(
                     fontSize: 20,
                   ),
                   ),
                   decoration: BoxDecoration(
                     color: Colors.deepPurple,
                   ),
               ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 600,
                    child: ListView(
                      children: [
                        Text("1"),
                        Text("1"),
                        Text("1"),
                        Text("1"),
                        Text("1"),
                        Text("1"),
                        Text("1"),
                        Text("1"),
                        Text("1"),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
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
                )
              ],
            ),

      ),
        ),
    );
  }
}
