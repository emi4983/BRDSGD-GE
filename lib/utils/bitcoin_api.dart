import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BitcoinCalculatorAPI {
  static Future<double> fetchPrice(http.Client client) async {
    var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return json["bpi"]["USD"]["rate_float"];
    } else {
      throw Exception('Failed to get price');
    }
  }
}