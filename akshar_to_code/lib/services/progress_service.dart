import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lesson.dart';

class ProgressService {
  static const _userKey = 'user_profile';
  static const _categoryKey = 'category_completed';

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<UserProfile> getUserProfile() async {
    final raw = _prefs?.getString(_userKey);
    if (raw == null) return UserProfile();
    return UserProfile.fromJson(jsonDecode(raw));
  }

  static Future<void> saveUserProfile(UserProfile profile) async {
    await _prefs?.setString(_userKey, jsonEncode(profile.toJson()));
  }

  static Future<void> recordLesson(
    String lessonId, {
    int? stars,
    bool isCategoryCompletion = false,
    String category = '',
  }) async {
    final profile = await getUserProfile();
    profile.totalLessonsCompleted += 1;
    if (stars != null) profile.totalStars += stars;

    final now = DateTime.now();
    final lastDate = profile.lastActiveDate;
    final lastDay = DateTime(lastDate.year, lastDate.month, lastDate.day);
    final today = DateTime(now.year, now.month, now.day);
    final diff = today.difference(lastDay).inDays;

    if (diff == 1) {
      profile.dailyStreak += 1;
    } else if (diff > 1) {
      profile.dailyStreak = 1;
    } else {
      profile.dailyStreak = profile.dailyStreak > 0 ? profile.dailyStreak : 1;
    }
    profile.lastActiveDate = now;
    await saveUserProfile(profile);

    if (isCategoryCompletion && category.isNotEmpty) {
      final catMap = Map<String, int>.from(profile.categoryProgress);
      final currentIdx = catMap[category] ?? -1;
      if (currentIdx < 0) {
        catMap[category] = 0;
      }
      profile.categoryProgress = catMap;
      await saveUserProfile(profile);
    }

    await _prefs?.setInt('lesson_${lessonId}_stars', stars ?? 1);
    await _prefs?.setBool('lesson_${lessonId}_completed', true);
  }

  static Future<bool> isLessonCompleted(String lessonId) async {
    return _prefs?.getBool('lesson_${lessonId}_completed') ?? false;
  }

  static Future<int> getLessonStars(String lessonId) async {
    return _prefs?.getInt('lesson_${lessonId}_stars') ?? 0;
  }

  static Future<Map<String, int>> getLessonProgress() async {
    final map = <String, int>{};
    final keys = _prefs?.getKeys() ?? {};
    for (final key in keys) {
      if (key.startsWith('lesson_') && key.endsWith('_stars')) {
        final id = key.replaceFirst('lesson_', '').replaceFirst('_stars', '');
        final val = _prefs?.getInt(key) ?? 0;
        map[id] = val;
      }
    }
    return map;
  }

  static Future<void> saveCategoryProgress(
      String category, int step) async {
    await _prefs?.setInt('$_categoryKey$category', step);
  }

  static Future<int> getCategoryProgress(String category) async {
    return _prefs?.getInt('$_categoryKey$category') ?? 0;
  }

  static Future<void> clearAll() async {
    await _prefs?.clear();
  }
}