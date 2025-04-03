import 'dart:convert';
import 'package:http/http.dart' as http;

class Quote {
  final String q;
  final String a;

  Quote({required this.q, required this.a});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      q: json['q'],
      a: json['a'],
    );
  }
}

class QuoteApiService {
  static Future<Quote?> fetchQuote() async {
    final url = Uri.parse('https://zenquotes.io/api/random');

    try {
      final response = await http.get(url);

      //print('API ответ: ${response.body}');
      //print('Статус код: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Quote.fromJson(jsonData[0]);
      } else {
        return null;
      }
    } catch (e) {
      print('Ошибка при получении цитаты: $e');
      return null;
    }
  }
}
