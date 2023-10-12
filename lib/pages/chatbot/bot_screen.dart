import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;

  const MessagesScreen({
    Key? key,
    required this.messages,
  }) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.builder(
      reverse: true,
      itemBuilder: (context, index) {
        final message = widget.messages[widget.messages.length - 1 - index];
        return Padding(
          padding: EdgeInsets.only(top: 10), // Add padding between messages
          child: Container(
            child: Row(
              mainAxisAlignment: message['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight:
                          Radius.circular(message['isUserMessage'] ? 0 : 20),
                      topLeft:
                          Radius.circular(message['isUserMessage'] ? 20 : 0),
                    ),
                    color: message['isUserMessage']
                        ? Color.fromARGB(255, 211, 228, 243)
                        : Color.fromARGB(255, 234, 236, 240),
                  ),
                  constraints: BoxConstraints(maxWidth: w * 2 / 3),
                  child: Text(
                    message['message'].text.text[0],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: widget.messages.length,
    );
  }
}
