import 'package:flutter/material.dart';
import '../../models/lesson.dart';
import '../../services/tts_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/speaker_button.dart';

class WhatsAppReaderScreen extends StatelessWidget {
  const WhatsAppReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp & Hinglish Reader'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF25D366), Color(0xFF128C7E)],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF128C7E).withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🔤 Hinglish सीखो:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Ka = क\tKya = क्या\tKaise = कैसे\nHinglish में हिंदी शब्दों को English अक्षरों में लिखा जाता है!',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ChatThread(
              messages: ChatData.sampleThread,
            ),
          ),
        ],
      ),
    );
  }
}

class ChatThread extends StatelessWidget {
  final List<ChatMessage> messages;

  const ChatThread({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFECE5DD), Color(0xFFDCF8C6)],
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: messages.length,
        itemBuilder: (context, i) {
          final m = messages[i];
          return _MessageBubble(
            message: m,
            isLast: i == messages.length - 1,
          );
        },
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isLast;

  const _MessageBubble({required this.message, required this.isLast});

  Color get _bubbleColor =>
      message.isMe ? const Color(0xFFDCF8C6) : Colors.white;

  Alignment get _alignment => message.isMe
      ? Alignment.centerRight
      : Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isMe ? 16 : 4),
            bottomRight: Radius.circular(message.isMe ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isMe)
              Text(
                message.sender,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF128C7E),
                ),
              ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (_) => _MessageDetail(
                          message: message,
                        ),
                      );
                    },
                    child: Text(
                      message.text,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    '10:30',
                    style: TextStyle(
                      fontSize: 10,
                      color: message.isMe
                          ? const Color(0xFF075E54)
                          : AppTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.isMe ? '✓✓' : '✓',
                  style: TextStyle(
                    fontSize: 12,
                    color: message.isMe
                        ? const Color(0xFF34B7F1)
                        : AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () {
                    TTSService().speak(
                      message.hinglishBreakdown ?? message.text,
                    );
                  },
                  child: Icon(
                    Icons.volume_up,
                    size: 14,
                    color: message.isMe
                        ? const Color(0xFF075E54)
                        : AppTheme.primary,
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

class _MessageDetail extends StatelessWidget {
  final ChatMessage message;

  const _MessageDetail({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.sender,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFDCF8C6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message.text,
              style: const TextStyle(
                fontSize: 18,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (message.hinglishBreakdown != null) ...[
            const Text(
              '🔍 Hinglish Breakdown:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message.hinglishBreakdown!,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.8,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          Center(
            child: SpeakerButton(
              text: message.hinglishBreakdown ?? message.text,
              size: 56,
              color: const Color(0xFF128C7E),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatData {
  static const sampleThread = [
    ChatMessage(
      sender: 'Anjali',
      text: 'Kaise ho?',
      isMe: false,
      hinglishBreakdown: 'Kaise = कैसे (How)\nHo = हो (are you)\nपूरा मतलब: How are you?',
    ),
    ChatMessage(
      sender: 'Me',
      text: 'Main theek hoon! Shukriya.',
      isMe: true,
      hinglishBreakdown: 'Main = मैं (I)\nTheek = ठीक (fine)\nShukriya = धन्यवाद (Thanks)',
    ),
    ChatMessage(
      sender: 'Anjali',
      text: 'Aaj school jaoge?',
      isMe: false,
      hinglishBreakdown: 'Aaj = आज (Today)\nSchool = विद्यालय\nJaoge = जाओगे (will go)',
    ),
    ChatMessage(
      sender: 'Me',
      text: 'Haan, paath yaad karna hai.',
      isMe: true,
      hinglishBreakdown: 'Haan = हाँ (Yes)\nPaath = पाठ (Lesson)\nYaad karna hai = याद करना है (to memorize)',
    ),
    ChatMessage(
      sender: 'Anjali',
      text: 'Bahut badhiya! All the best!',
      isMe: false,
      hinglishBreakdown: 'Bahut = बहुत (Very)\nBadhiya = बढ़िया (Nice)\nAll the best = शुभकामनाएँ',
    ),
    ChatMessage(
      sender: 'Me',
      text: 'Dhanyavaad dost! Milte hain kal.',
      isMe: true,
      hinglishBreakdown: 'Dhanyavaad = धन्यवाद (Thanks)\nDost = दोस्त (friend)\nMilte hain = मिलते हैं (see you)',
    ),
  ];
}