class Lesson {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final int totalSteps;
  final int completedSteps;
  final bool isLocked;
  final String? iconPath;

  Lesson({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    this.totalSteps = 1,
    this.completedSteps = 0,
    this.isLocked = false,
    this.iconPath,
  });

  double get progress =>
      totalSteps > 0 ? completedSteps / totalSteps : 0.0;

  bool get isCompleted => completedSteps >= totalSteps;

  Lesson copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? category,
    int? totalSteps,
    int? completedSteps,
    bool? isLocked,
    String? iconPath,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      category: category ?? this.category,
      totalSteps: totalSteps ?? this.totalSteps,
      completedSteps: completedSteps ?? this.completedSteps,
      isLocked: isLocked ?? this.isLocked,
      iconPath: iconPath ?? this.iconPath,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'category': category,
        'totalSteps': totalSteps,
        'completedSteps': completedSteps,
        'isLocked': isLocked,
      };

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json['id'],
        title: json['title'],
        subtitle: json['subtitle'],
        category: json['category'],
        totalSteps: json['totalSteps'] ?? 1,
        completedSteps: json['completedSteps'] ?? 0,
        isLocked: json['isLocked'] ?? false,
      );
}

class LetterItem {
  final String character;
  final String transliteration;
  final String word;
  final String wordMeaning;
  final String audioLabel;

  const LetterItem({
    required this.character,
    required this.transliteration,
    this.word = '',
    this.wordMeaning = '',
    this.audioLabel = '',
  });
}

class WordItem {
  final String hindi;
  final String english;
  final String meaning;
  final int length;

  const WordItem({
    required this.hindi,
    required this.english,
    required this.meaning,
    this.length = 0,
  });
}

class StoryPage {
  final String text;
  final String? imageUrl;
  final String audioText;

  const StoryPage({
    required this.text,
    this.imageUrl,
    required this.audioText,
  });
}

class Story {
  final String id;
  final String title;
  final String language;
  final String description;
  final List<StoryPage> pages;
  final String? coverImage;

  const Story({
    required this.id,
    required this.title,
    required this.language,
    required this.description,
    required this.pages,
    this.coverImage,
  });
}

class ChatMessage {
  final String sender;
  final String text;
  final bool isMe;
  final String? hinglishBreakdown;

  const ChatMessage({
    required this.sender,
    required this.text,
    required this.isMe,
    this.hinglishBreakdown,
  });
}

class CountingItem {
  final int number;
  final String english;
  final String hindi;

  const CountingItem({
    required this.number,
    required this.english,
    required this.hindi,
  });
}

class TableEntry {
  final String text;
  final String hindiText;

  const TableEntry({
    required this.text,
    required this.hindiText,
  });
}

class ProgrammingTopic {
  final String title;
  final String language;
  final String description;
  final String code;
  final String explanation;

  const ProgrammingTopic({
    required this.title,
    required this.language,
    required this.description,
    required this.code,
    required this.explanation,
  });
}

class UserProfile {
  String name;
  int avatarIndex;
  int dailyStreak;
  int totalStars;
  int totalLessonsCompleted;
  DateTime lastActiveDate;
  Map<String, int> categoryProgress;

  UserProfile({
    this.name = 'Learner',
    this.avatarIndex = 0,
    this.dailyStreak = 0,
    this.totalStars = 0,
    this.totalLessonsCompleted = 0,
    DateTime? lastActiveDate,
    Map<String, int>? categoryProgress,
  })  : lastActiveDate = lastActiveDate ?? DateTime.now(),
        categoryProgress = categoryProgress ?? {};

  Map<String, dynamic> toJson() => {
        'name': name,
        'avatarIndex': avatarIndex,
        'dailyStreak': dailyStreak,
        'totalStars': totalStars,
        'totalLessonsCompleted': totalLessonsCompleted,
        'lastActiveDate': lastActiveDate.toIso8601String(),
        'categoryProgress': categoryProgress,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        name: json['name'] ?? 'Learner',
        avatarIndex: json['avatarIndex'] ?? 0,
        dailyStreak: json['dailyStreak'] ?? 0,
        totalStars: json['totalStars'] ?? 0,
        totalLessonsCompleted: json['totalLessonsCompleted'] ?? 0,
        lastActiveDate: json['lastActiveDate'] != null
            ? DateTime.parse(json['lastActiveDate'])
            : DateTime.now(),
        categoryProgress: Map<String, int>.from(json['categoryProgress'] ?? {}),
      );
}
