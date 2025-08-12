import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/chat_message.dart';

class ChatProviderSimple with ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  bool _isLoading = false;

  List<ChatMessage> get messages => _messages;
  bool get isTyping => _isTyping;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String messageText) async {
    // Simple implementation
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: messageText.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    notifyListeners();
  }

  List<String> getQuickSuggestions() {
    return [
      "I have a headache",
      "How to improve sleep?",
      "Healthy diet tips",
      "Exercise recommendations",
      "Stress management",
      "Book an appointment",
    ];
  }
}
