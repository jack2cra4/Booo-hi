# Akshar to Code (अक्षर से कोड)

A gamified, offline-first Flutter app for zero-literacy beginners to learn Hindi, English, Math, and Programming.

## Features

- **हिंदी Mastery**: स्वर/व्यंजन → शब्द → मात्राएँ → वाक्य → पैराग्राफ
- **English Mastery**: Phonics → CVC words → Word families → Complex sounds
- **Bilingual Bridge**: Line-by-line Hindi-English mapping
- **Interactive Storybooks**: Karaoke word-highlight with tap-to-read TTS
- **WhatsApp Reader**: Real-chat simulation with Hinglish breakdown
- **Math & Tables**: Counting 1-100, multiplication tables 2-30
- **Programming**: Visual coding fundamentals + Python/Java/C/C++ micro-lessons
- **Gamification**: Confetti, star ratings, avatars, daily streaks, listening quizzes

## CI/CD

On every push to `main`, GitHub Actions:
1. Sets up Java 17 + Android SDK + Flutter
2. Runs `flutter pub get`
3. Builds debug + release APKs
4. Uploads both as downloadable artifacts

## Build Locally

```bash
flutter pub get
flutter build apk --debug
```

APK output: `build/app/outputs/flutter-apk/app-debug.apk`