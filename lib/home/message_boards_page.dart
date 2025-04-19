import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:message_board/home/chat_page.dart';

class MessageBoardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message Boards')),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(title: Text('Profile'), onTap: () => Navigator.pushNamed(context, '/profile')),
            ListTile(title: Text('Settings'), onTap: () => Navigator.pushNamed(context, '/settings')),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('message_boards').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          var boards = snapshot.data!.docs;
          return ListView.builder(
            itemCount: boards.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(boards[index]['name']),
                leading: Icon(Icons.chat),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ChatPage(boardId: boards[index].id)),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
