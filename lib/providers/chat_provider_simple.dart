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
      model: 'gemini-pro',
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
You are Pranik AI, a friendly and knowledgeable health assistant. Your role is to:
1. Provide general health information and wellness tips
2. Suggest when to consult healthcare professionals
3. Offer lifestyle and prevention advice
4. Be empathetic and supportive
5. Always remind users that you're not a replacement for professional medical advice

User's question: $messageText

Please provide a helpful, accurate, and caring response. Keep it concise but informative.
''';

      final content = [Content.text(healthPrompt)];
      final response = await _model.generateContent(content);

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
      String errorMessage = 'I\'m sorry, I\'m having trouble connecting right now. Please check your internet connection and try again.';
      
      // Check for specific error types
      if (e.toString().contains('API_KEY')) {
        errorMessage = 'There seems to be an issue with the API configuration. Please try again later.';
      } else if (e.toString().contains('SAFETY')) {
        errorMessage = 'I couldn\'t process that request due to safety guidelines. Please try rephrasing your question.';
      } else if (e.toString().contains('QUOTA') || e.toString().contains('429')) {
        errorMessage = 'The service is currently busy. Please try again in a moment.';
      }

      final errorChatMessage = ChatMessage(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        message: errorMessage,
        isUser: false,
        timestamp: DateTime.now(),
      );

      _messages.add(errorChatMessage);
      
      if (kDebugMode) {
        print('Gemini API Error: $e');
      }
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
