import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'homepage.dart'; // Import the Homepage widget for navigation
import '../.env'; // Import the .env file to access the API key

class Learnpage extends StatefulWidget {
  const Learnpage({Key? key}) : super(key: key);

  @override
  _LearnpageState createState() => _LearnpageState();
}

class _LearnpageState extends State<Learnpage> {
  // Gemini model setup
  final model = GenerativeModel(
    model: 'gemini-1.5-flash', // Specify the Gemini model to use
    apiKey: apiKey, // Access the API key from the .env file
    safetySettings: [
      // Configure safety settings to block harmful content
      SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
      SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.high),
    ],
  );

  // Text controller for the input field
  final _textController = TextEditingController();
  // Scroll controller for the chat history list
  final _scrollController = ScrollController();
  // List to store the chat history (user and Gemini messages)
  List<ChatMessage> _chatHistory = [];
  // Boolean to track if a message is being processed
  bool _isLoading = false;

  // User's financial information (simplified for this example)
  Map<String, String> _financialInfo = {
    'income': '₱30,000 per month',
    'savings': '₱10,000',
    'investments': '₱5,000 in stocks',
    'debts': '₱2,000 credit card debt',
    'expenses': '₱20,000 per month',
    'financialGoals': 'Save for a down payment on a car',
  };

  @override
  void dispose() {
    // Dispose of the controllers to prevent memory leaks
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Function to send a message to Gemini
  Future<void> _sendMessage() async {
    // Prevent sending empty messages
    if (_textController.text.trim().isEmpty) return;

    setState(() {
      // Set loading to true to show the loading indicator
      _isLoading = true;
      // Add the user's message to the chat history
      _chatHistory.add(ChatMessage(text: _textController.text, isUser: true));
      // Clear the input field
      _textController.clear();
    });

    try {
      // Build the detailed prompt with financial information
      String financialPrompt =
          "You are a financial learning assistant. You will provide financial advice based on the user's current financial situation. Here's the user's financial information:\n";
      _financialInfo.forEach((key, value) {
        financialPrompt += "$key: $value\n";
      });
      financialPrompt +=
          "Only provide information related to financial learning and advice. Do not provide any other information. ";

      // Format the chat history for the Gemini API
      final content = Content.text(_chatHistory.map((e) => e.text).join('\n'));
      // Start a new chat session with the model
      final chat = model.startChat(history: [content]);
      // Send the last message to Gemini with a specific prompt
      final response = await chat.sendMessage(
        Content.text("$financialPrompt ${_chatHistory.last.text}"),
      );

      if (response.text != null) {
        // If Gemini returns a response, add it to the chat history
        setState(() {
          _chatHistory.add(ChatMessage(text: response.text!, isUser: false));
        });
      } else {
        // Handle the case where response.text is null
        setState(() {
          _chatHistory.add(
            ChatMessage(
              text: "Sorry, I couldn't generate a response.",
              isUser: false,
            ),
          );
        });
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      setState(() {
        _chatHistory.add(
          ChatMessage(text: "An error occurred: $e", isUser: false),
        );
      });
      print("Error sending message: $e");
    } finally {
      setState(() {
        // Set loading to false to hide the loading indicator
        _isLoading = false;
      });
      // Scroll to the bottom of the chat history
      _scrollToBottom();
    }
  }

  // Function to scroll to the bottom of the chat history
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black, // Set the background color to black
        child: Stack(
          children: [
            // Background gradient
            Opacity(
              opacity: 0.15, // Set the opacity of the gradient
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFA59E9E), // 0% - Light gray
                      Color(0xFFEA1A6E), // 50% - Pink
                      Color(0xFF9B51E0), // 80% - Purple
                      Color(0xFF9B51E0), // 100% - Purple
                    ],
                    stops: [0.0, 0.5, 0.8, 1.0], // Gradient stops
                  ),
                ),
              ),
            ),

            //Content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 32,
                            ),
                            onPressed: () {
                              // Navigate back to the Homepage
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Homepage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    // Chat history list
                    Expanded(
                      child: ListView.builder(
                        controller:
                            _scrollController, // Assign the scroll controller
                        itemCount: _chatHistory.length, // Number of messages
                        itemBuilder: (context, index) {
                          final message = _chatHistory[index];
                          // Build a ChatBubble for each message
                          return ChatBubble(
                            message: message.text,
                            isUser: message.isUser,
                          );
                        },
                      ),
                    ),
                    // Input area for sending messages
                    _buildInputArea(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build the input area
  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          // Input field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(24.0), // Rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _textController, // Assign the text controller
                  style: const TextStyle(
                    color: Colors.white,
                  ), // White text color
                  decoration: const InputDecoration(
                    hintText: 'Ask me anything...', // Placeholder text
                    hintStyle: TextStyle(color: Colors.grey), // Gray hint text
                    border: InputBorder.none, // Remove the border
                  ),
                  onSubmitted: (_) => _sendMessage(), // Send message on submit
                ),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          // Send button or loading indicator
          _isLoading
              ? const CircularProgressIndicator(
                color: Colors.white,
              ) // Loading indicator
              : IconButton(
                icon: const Icon(Icons.send, color: Colors.white), // Send icon
                onPressed: _sendMessage, // Send message on press
              ),
        ],
      ),
    );
  }
}

// Class to represent a single chat message
class ChatMessage {
  final String text; // Message text
  final bool
  isUser; // True if the message is from the user, false if from Gemini

  ChatMessage({required this.text, required this.isUser});
}

// Class to build a chat bubble
class ChatBubble extends StatelessWidget {
  final String message; // Message text
  final bool
  isUser; // True if the message is from the user, false if from Gemini

  const ChatBubble({Key? key, required this.message, required this.isUser})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      // Align the bubble to the right if it's a user message, left otherwise
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0), // Vertical margin
        padding: const EdgeInsets.all(12.0), // Padding inside the bubble
        decoration: BoxDecoration(
          // Blue for user messages, dark gray for Gemini messages
          color: isUser ? Colors.blue[700] : Colors.grey[800],
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ), // White text
      ),
    );
  }
}
