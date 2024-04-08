//import 'package:test/test.dart';
import 'package:bitcoin_calculator/utils/Conversions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}


main() {
  group("conversions", () {

    test('BTC to USD conversion', () async {
      final client = MockClient();
      final fakePriceData = {"time":{"updated":"Apr 8, 2024 02:41:00 UTC","updatedISO":"2024-04-08T02:41:00+00:00","updateduk":"Apr 8, 2024 at 03:41 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"69,390.926","description":"United States Dollar","rate_float":69390.9264}}}

      var usdValue = Conversion.btcToUsd(3);
      expect(usdValue, 209565);
    });

    test('throws ArgumentError on negative number usd', () {
      expect(() => Conversion.btcToUsd(-1), throwsArgumentError);
    });
    test('throws ArgumentError on negative number btc', () {
      expect(() => Conversion.usdtobtc(-69855), throwsArgumentError);
    });
    test('USD to BTC conversion', () {
      var btcValue = Conversion.usdtobtc(209565);
      expect(btcValue, 3);
    });
  });
}
