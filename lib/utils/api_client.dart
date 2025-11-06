import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = 'https://api.coingecko.com/api/v3';

  static Future<double> getCryptoPrice(String cryptoId, String currency) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/simple/price?ids=$cryptoId&vs_currencies=$currency'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data[cryptoId][currency]?.toDouble() ?? 0.0;
      }
    } catch (e) {
      print('Error fetching crypto price: $e');
    }
    return 0.0;
  }

  static Future<Map<String, dynamic>> getCryptoInfo(String cryptoId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/coins/$cryptoId'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error fetching crypto info: $e');
    }
    return {};
  }

  static Future<List<dynamic>> getMarketData() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error fetching market data: $e');
    }
    return [];
  }
}