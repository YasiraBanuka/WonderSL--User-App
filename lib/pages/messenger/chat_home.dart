import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wondersl/components/bottom_navbar.dart';
import 'package:wondersl/pages/chatbot/bot_home.dart';
import 'package:wondersl/pages/messenger/chat_page.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F7F7),
        title: Text(
          'Chat Home Page',
          style: TextStyle(
            color: Color(0xFF323232),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: _buildAgentList(),
      bottomNavigationBar: const bottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BotHome(),
            ),
          );
        },
        // backgroundColor: Color(0xFF008FA0),
        backgroundColor: Color.fromARGB(255, 165, 230, 236),
        child: Image.asset(
          'images/bot.png',
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // build a list of agents
  Widget _buildAgentList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('agents').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0),
            child: const Text('loading.....'),
          );
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildAgentListItem(doc))
              .toList(),
        );
      },
    );
  }

  // build individual agent list item
  Widget _buildAgentListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Get the first letter of the agent's name
    String agentName = data['a_name'];
    String firstLetter = agentName[0];

    // Define the image container
    Container imageContainer = Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue, // image container color
      ),
      alignment: Alignment.center,
      child: Text(
        firstLetter,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    // Return the entire agent list item with image to the left
    return InkWell(
      onTap: () {
        // Navigate to the chat page with agent details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              agentEmail: data['a_email'],
              agentId: data['aid'],
              agentName: data['a_name'],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.only(
            top: 20.0,
            bottom: 0,
            left: 20.0,
            right: 20.0), // Add margin for spacing between agents
        padding: EdgeInsets.all(15), // Add padding inside the container
        child: Row(
          children: [
            // Display the image container to the left
            imageContainer,
            SizedBox(width: 16), // Add spacing between the image and text
            // Display agent name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['a_name'],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  data['a_email'],
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
