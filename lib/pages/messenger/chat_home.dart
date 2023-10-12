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
  // instance of auth
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Home Page'),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
          return const Text('loading.....');
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
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // display all agents
    return ListTile(
      title: Text(data['a_email']),
      onTap: () {
        // pass the clicked agent's UID to that page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              agentEmail: data['a_email'],
              agentId: data['aid'],
            ),
          ),
        );
      },
    );
  }
}
