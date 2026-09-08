import 'package:flutter/material.dart';
import '../../data/programming_data.dart';
import '../../models/lesson.dart';
import '../../theme/app_theme.dart';
import '../../widgets/speaker_button.dart';

class ProgrammingDashboard extends StatelessWidget {
  const ProgrammingDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('कोडिंग सीखो'),
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(text: '🧠 Basics'),
              Tab(text: '🐍 Python'),
              Tab(text: '☕ Java'),
              Tab(text: '⚙️ C'),
              Tab(text: '➕ C++'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _TopicListView(topics: ProgrammingData.fundamentals, color: Colors.teal),
            _TopicListView(topics: ProgrammingData.pythonTopics, color: const Color(0xFF3776AB)),
            _TopicListView(topics: ProgrammingData.javaTopics, color: const Color(0xFFE76F00)),
            _TopicListView(topics: ProgrammingData.cTopics, color: const Color(0xFF00599C)),
            _TopicListView(topics: ProgrammingData.cppTopics, color: const Color(0xFF004482)),
          ],
        ),
      ),
    );
  }
}

class _TopicListView extends StatelessWidget {
  final List<ProgrammingTopic> topics;
  final Color color;

  const _TopicListView({required this.topics, required this.color});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: topics.length,
      itemBuilder: (context, i) {
        final topic = topics[i];
        return CodeCard(topic: topic, color: color);
      },
    );
  }
}

class CodeCard extends StatelessWidget {
  final ProgrammingTopic topic;
  final Color color;

  const CodeCard({super.key, required this.topic, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.7)],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        topic.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                SpeakerButton(
                  text: '${topic.title}. ${topic.explanation}',
                  language: 'hi-IN',
                  size: 36,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Container(
            color: const Color(0xFF1E1E1E),
            padding: const EdgeInsets.all(14),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                topic.code,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  color: Color(0xFF4EC9B0),
                  height: 1.5,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            color: color.withOpacity(0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.tips_and_updates_outlined, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    topic.explanation,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}