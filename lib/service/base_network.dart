import 'dart:async';

import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BaseNetwork {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';

  static String getImageUrl(String pictureId, {String size = 'small'}) {
    return '$baseUrl/images/$size/$pictureId';
  }

  static final _logger = Logger();

  static Future<List<Map<String, dynamic>>> getAll(String path) async {
    final uri = Uri.parse('$baseUrl/$path');
    _logger.i("GET ALL : $uri");

    try {
      final response = await http.get(uri).timeout(Duration(seconds: 10));
      _logger.i("Response: ${response.statusCode}");
      _logger.i("Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        final List<dynamic> jsonList = jsonMap['restaurants'];
        return jsonList.cast<Map<String, dynamic>>();
      } else {
        _logger.e("Error: ${response.statusCode}");
        throw Exception('server error : ${response.statusCode}');
      }
    } on TimeoutException {
      _logger.e("Timeout error from $uri");
      throw Exception('Req timeout $uri');
    } catch (e) {
      _logger.e("Error from $uri: $e");
      throw Exception('Error fetching data : $e');
    }
  }
}
