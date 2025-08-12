import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider_simple.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final chatProvider = Provider.of<ChatProviderSimple>(context, listen: false);

    setState(() => _isComposing = false);
    _messageController.clear();

    await chatProvider.sendMessage(text);

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _onQuickSuggestionTap(String suggestion) {
    _sendMessage(suggestion);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // App bar - matching home screen exactly
            Container(
              padding: EdgeInsets.all(isTablet ? 24 : 16),
              decoration: const BoxDecoration(
                color: Color(0xFF3B82F6),
              ),
              child: Row(
                children: [
                  Text(
                    'Pranik AI',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: isTablet ? 20 : 18,
                      fontFamily: 'Comic Sans MS',
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),

            // Quick suggestions - compact horizontal scroll
            Consumer<ChatProviderSimple>(
              builder: (context, chatProvider, child) {
                if (chatProvider.messages.isEmpty && !chatProvider.isTyping) {
                  return Container(
                    height: 60,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: isTablet ? 24 : 16),
                      child: Row(
                        children: chatProvider.getQuickSuggestions().map((suggestion) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () => _onQuickSuggestionTap(suggestion),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F8FF),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFF3B82F6).withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  suggestion.length > 25 
                                    ? '${suggestion.substring(0, 25)}...'
                                    : suggestion,
                                  style: TextStyle(
                                    color: const Color(0xFF3B82F6),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            // Chat list
            Expanded(
              child: Consumer<ChatProviderSimple>(
                builder: (context, chatProvider, child) {
                  if (chatProvider.isLoading && chatProvider.messages.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(isTablet ? 24 : 16),
                    itemCount: chatProvider.messages.length +
                        (chatProvider.isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= chatProvider.messages.length) {
                        // Typing indicator slot
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            children: [
                              const CircularProgressIndicator(strokeWidth: 2),
                              const SizedBox(width: 8),
                              Text(
                                'AI is typing...',
                                style: TextStyle(
                                  fontSize: isTablet ? 16 : 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      final message = chatProvider.messages[index];
                      return Align(
                        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                          padding: const EdgeInsets.all(12),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                          ),
                          decoration: BoxDecoration(
                            color: message.isUser
                                ? const Color(0xFF3B82F6)
                                : const Color(0xFFF0F8FF),
                            borderRadius: BorderRadius.circular(12),
                            border: message.isUser
                                ? null
                                : Border.all(
                                    color: const Color(0xFF3B82F6).withOpacity(0.2),
                                  ),
                          ),
                          child: Text(
                          message.message,
                          style: TextStyle(
                            color: message.isUser ? Colors.white : Colors.black87,
                            fontSize: isTablet ? 16 : 14,
                            height: 1.4,
                          ),
                        ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // Input box
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(isTablet ? 24 : 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: _isComposing
                                ? const Color(0xFF3B82F6)
                                : Colors.transparent,
                          ),
                        ),
                        child: TextField(
                          controller: _messageController,
                          onChanged: (text) =>
                              setState(() => _isComposing = text.trim().isNotEmpty),
                          onSubmitted: (value) => _sendMessage(value),
                          decoration: const InputDecoration(
                            hintText: 'Type your question.',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Consumer<ChatProviderSimple>(
                      builder: (context, chatProvider, child) {
                        return GestureDetector(
                          onTap: chatProvider.isTyping
                              ? null
                              : () => _sendMessage(_messageController.text),
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: _isComposing && !chatProvider.isTyping
                                  ? const Color(0xFF3B82F6)
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: chatProvider.isTyping
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Icon(
                                    Icons.send,
                                    color: _isComposing
                                        ? Colors.white
                                        : Colors.grey[600],
                                    size: 20,
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
