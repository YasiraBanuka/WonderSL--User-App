import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wondersl/components/chat/chat_bubble.dart';
import 'package:wondersl/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String agentEmail;
  final String agentId;
  final String agentName;
  const ChatPage({
    super.key,
    required this.agentEmail,
    required this.agentId,
    required this.agentName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    // only send message if there's something to send
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.agentId, _messageController.text);
      // clear the text controller after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F7F7),
        title: Column(
          children: [
            Text(
              widget.agentName,
              style: TextStyle(
                color: Color(0xFF323232),
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.green,
                  size: 10,
                ),
                SizedBox(width: 5),
                Text(
                  'Online',
                  style: TextStyle(
                    color: Color(0XFF323232),
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
        iconTheme: IconThemeData(color: Color(0xFF323232)),
        // centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            // messages
            Expanded(
              child: _buildMessageList(),
            ),

            // user input
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.agentId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading....');
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Determine if the message was sent by the current user
    bool isSentMessage = (data['senderId'] == _firebaseAuth.currentUser!.uid);

    // Define colors for sent and received messages
    Color sentMessageColor = Color(0xFF008FA0).withOpacity(0.2);
    Color receivedMessageColor = Color.fromARGB(224, 204, 222, 255);

    // Determine the background color for the message container
    Color messageBackgroundColor =
        isSentMessage ? sentMessageColor : receivedMessageColor;

    return Container(
      alignment: isSentMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
          left: 20.0,
          right: 20.0,
        ),
        child: Column(
          crossAxisAlignment:
              isSentMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment:
              isSentMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: messageBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: isSentMessage
                        ? Radius.circular(20)
                        : Radius.circular(0),
                    bottomRight: isSentMessage
                        ? Radius.circular(0)
                        : Radius.circular(20)),
              ),
              child: ChatBubble(message: data['message']),
            ),
          ],
        ),
      ),
    );
  }

  // build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, bottom: 15.0, right: 20.0, left: 20.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type your message",
                    hintStyle: TextStyle(color: Colors.black45),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFf3f3f3),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Center(
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: Icon(Icons.send),
                    color: Color.fromARGB(255, 204, 200, 200),
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
