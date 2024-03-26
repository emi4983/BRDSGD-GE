import 'package:test/test.dart';
import 'package:bitcoin_calculator/utils/Conversions.dart';

void main() {
  group("conversions", () {

    test('BTC to USD conversion', () {
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
