import 'package:flutter/material.dart';

class FreeChatScreen extends StatefulWidget {
  @override
  _FreeChatScreenState createState() => _FreeChatScreenState();
}

class _FreeChatScreenState extends State<FreeChatScreen> {
  // Controller for the text field
  TextEditingController _controller = TextEditingController();

  // List of random greeting messages
  final List<String> _greetingMessages = [
    "Hello! How can I assist you today?",
    "Hi there! Welcome, how can I help?",
    "Hey! What can I do for you?",
    "Greetings! How may I assist you?",
    "Hello! It's a pleasure to meet you, how can I help?"
  ];

  // List of user1's replies
  final List<String> _user1Replies = [
    "Hi there!",
    "What is your name?",
    "What is your gender?",
    "What is your Date of Birth?",
    "What is your Time of Birth?",
    "What is your marital status?",
    "You will get success soon😊😊",
    "How may I help you?",
    "Have a great day!"
  ];

  // Variable to track the index of the replies
  int _currentReplyIndex = 0;

  // To track if the first message is sent
  bool _isFirstMessage = true;

  // List of all chat messages
  List<Map<String, String>> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Free Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Align(
                    alignment: _messages[index]['sender'] == 'User 1'
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _messages[index]['sender'] == 'User 1'
                            ? Colors.blueAccent
                            : Colors.greenAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _messages[index]['message']!,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to send the message
  void _sendMessage(String text) {
    if (text.isEmpty) return;

    // Add the user's message to the chat
    setState(() {
      _messages.add({"sender": "User 2", "message": text});
    });

    _controller.clear();
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);

    // Check if it's the first message, send a random greeting
    if (_isFirstMessage) {
      _isFirstMessage = false;
      _sendRandomGreeting();
    } else {
      _handleReply(text);
    }
  }

  // Method to send a random greeting from the list
  void _sendRandomGreeting() {
    final randomGreeting = _greetingMessages[
    (DateTime.now().millisecondsSinceEpoch % _greetingMessages.length)
    ];

    setState(() {
      _messages.add({"sender": "User 1", "message": randomGreeting});
    });

    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    Future.delayed(const Duration(seconds: 1), _triggerReply);
  }

  // Method to handle user1's reply after the first message
  void _triggerReply() {
    if (_currentReplyIndex < _user1Replies.length) {
      setState(() {
        _messages.add({"sender": "User 1", "message": "typing..."});
      });

      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages[_messages.length - 1] = {
            "sender": "User 1",
            "message": _user1Replies[_currentReplyIndex]
          };
          _currentReplyIndex++;
        });

        _scrollToBottom();
      });
    }
  }

  // Method to scroll to the bottom of the messages
  void _scrollToBottom() {
    // Use a ScrollController to scroll to the bottom of the list
    final scrollController = ScrollController();
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // Method to handle the reply based on user's input
  void _handleReply(String userMessage) {
    if (_currentReplyIndex < _user1Replies.length) {
      _triggerReply();
    }
  }
}
