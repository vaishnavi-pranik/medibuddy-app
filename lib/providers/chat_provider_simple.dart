import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/chat_message.dart';

class ChatProviderSimple with ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  bool _isLoading = false;
  
  // Gemini AI configuration
  static const String _apiKey = 'AIzaSyBPiDtnMkkAIhz0sXM-hPDQhdMDtlYuJvQ';
  late final GenerativeModel _model;

  ChatProviderSimple() {
    _initializeGemini();
  }

  void _initializeGemini() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.7,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 1024,
      ),
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.medium),
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium),
      ],
    );
  }

  List<ChatMessage> get messages => _messages;
  bool get isTyping => _isTyping;
  bool get isLoading => _isLoading;

  Future<void> sendMessage(String messageText) async {
    if (messageText.trim().isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: messageText.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    notifyListeners();

    // Set typing indicator
    _isTyping = true;
    notifyListeners();

    try {
      // Create a health-focused prompt
      final healthPrompt = '''
You are Pranik AI, a friendly health assistant. Provide helpful health advice, wellness tips, and general medical information. Always remind users to consult healthcare professionals for serious concerns.

Question: $messageText

Provide a helpful, concise response (2-3 sentences max).
''';

      if (kDebugMode) {
        print('Sending request to Gemini API...');
        print('API Key configured: ${_apiKey.isNotEmpty}');
      }

      final content = [Content.text(healthPrompt)];
      final response = await _model.generateContent(content);

      if (kDebugMode) {
        print('Received response from Gemini API');
        print('Response text: ${response.text}');
      }

      String responseText = response.text ?? 'I apologize, but I couldn\'t generate a response. Please try again.';
      
      // Clean up the response text
      responseText = responseText.trim();
      if (responseText.isEmpty) {
        responseText = 'I apologize, but I couldn\'t generate a response. Please try again.';
      }

      // Add AI response
      final aiMessage = ChatMessage(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        message: responseText,
        isUser: false,
        timestamp: DateTime.now(),
      );

      _messages.add(aiMessage);
    } catch (e) {
      // Handle errors gracefully
      String errorMessage = 'I\'m having trouble connecting to the AI service. Please check your internet connection and try again.';
      
      if (kDebugMode) {
        print('Gemini API Error Details: $e');
        print('Error type: ${e.runtimeType}');
        print('Error string: ${e.toString()}');
      }
      
      // Check for specific error types
      if (e.toString().contains('API_KEY') || e.toString().contains('403')) {
        errorMessage = 'There seems to be an issue with the API configuration. Please contact support.';
      } else if (e.toString().contains('SAFETY')) {
        errorMessage = 'I couldn\'t process that request due to safety guidelines. Please try rephrasing your question.';
      } else if (e.toString().contains('QUOTA') || e.toString().contains('429')) {
        errorMessage = 'The service is currently busy. Please try again in a moment.';
      } else if (e.toString().contains('network') || e.toString().contains('connection')) {
        errorMessage = 'Network connection issue. Please check your internet and try again.';
      }

      final errorChatMessage = ChatMessage(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        message: errorMessage,
        isUser: false,
        timestamp: DateTime.now(),
      );

      _messages.add(errorChatMessage);
    } finally {
      _isTyping = false;
      notifyListeners();
    }
  }

  List<String> getQuickSuggestions() {
    return [
      "I have a headache",
      "Improve sleep",
      "Healthy diet tips",
      "Daily exercise",
      "Manage stress",
      "Vitamin advice",
      "Boost immunity",
      "Mental health",
      "Weight loss tips",
      "Heart health",
    ];
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
