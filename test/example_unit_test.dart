//import 'package:test/test.dart';
import 'package:bitcoin_calculator/utils/Conversions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:bitcoin_calculator/utils/bitcoin_api.dart';

class MockClient extends Mock implements http.Client {}
void main() {
  group("conversions", () {

    test('BTC to USD conversion', () async {
      final client = MockClient();
      final fakePriceData = '{"time":{"updated":"Apr 8, 2024 02:41:00 UTC","updatedISO":"2024-04-08T02:41:00+00:00","updateduk":"Apr 8, 2024 at 03:41 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"69,390.926","description":"United States Dollar","rate_float":69390.9264}}}';
      var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');      
      when(client.get(url))
        .thenAnswer((_) async => http.Response(fakePriceData, 200));
      double price = await BitcoinCalculatorAPI.fetchPrice(client);
      var usdValue = Conversion.btcToUsd(3, price);
      expect(usdValue, 208172.7792);
    });

    test('throws ArgumentError on negative number usd', () async {
      final client = MockClient();
      final fakePriceData = '{"time":{"updated":"Apr 8, 2024 02:41:00 UTC","updatedISO":"2024-04-08T02:41:00+00:00","updateduk":"Apr 8, 2024 at 03:41 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"69,390.926","description":"United States Dollar","rate_float":69390.9264}}}';
      var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');      
      when(client.get(url))
        .thenAnswer((_) async => http.Response(fakePriceData, 200));
      double price = await BitcoinCalculatorAPI.fetchPrice(client);      
      expect(() => Conversion.btcToUsd(-1, price), throwsArgumentError);
    });
    test('throws ArgumentError on negative number btc', () async{
      final client = MockClient();
      final fakePriceData = '{"time":{"updated":"Apr 8, 2024 02:41:00 UTC","updatedISO":"2024-04-08T02:41:00+00:00","updateduk":"Apr 8, 2024 at 03:41 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"69,390.926","description":"United States Dollar","rate_float":69390.9264}}}';
      var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');      
      when(client.get(url))
        .thenAnswer((_) async => http.Response(fakePriceData, 200));
      double price = await BitcoinCalculatorAPI.fetchPrice(client);      
      expect(() => Conversion.usdtobtc(-69855, price), throwsArgumentError);
    });
    test('USD to BTC conversion', () async{
      final client = MockClient();
      final fakePriceData = '{"time":{"updated":"Apr 8, 2024 02:41:00 UTC","updatedISO":"2024-04-08T02:41:00+00:00","updateduk":"Apr 8, 2024 at 03:41 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"69,390.926","description":"United States Dollar","rate_float":69390.9264}}}';
      var url =
        Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');      
      when(client.get(url))
        .thenAnswer((_) async => http.Response(fakePriceData, 200));
      double price = await BitcoinCalculatorAPI.fetchPrice(client);
      var btcValue = Conversion.usdtobtc(208172.7792, price);
      expect(btcValue, 3);
    });
  });
}
