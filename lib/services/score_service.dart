import 'package:shared_preferences/shared_preferences.dart';

class RankingService {
  static const String _rankingKey = 'ranking';

  Future<void> saveScore(String playerName, int score) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> ranking = prefs.getStringList(_rankingKey) ?? [];

    ranking.add('$playerName|$score');

    await prefs.setStringList(_rankingKey, ranking);
  }

  Future<List<String>> loadScores() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(_rankingKey) ?? [];
  }
}
