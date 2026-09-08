enum CelebrationType { noCelebration, simple, confetti, sfx }

class CelebrationService {
  static const List<String> applauseWords = [
    'शाबाश!',
    'बहुत बढ़िया!',
    'Awesome!',
    'Amazing!',
    'Fantastic!',
  ];

  static String getRandomPraise() {
    final index = DateTime.now().millisecondsSinceEpoch % applauseWords.length;
    return applauseWords[index];
  }
}