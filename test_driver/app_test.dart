// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {

  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      await driver.close();
    }
  });
  group('Sad Paths', () {

    test('BTC value cannot be negative', () async {
      final btcToUsdBtnFinder = find.byValueKey('btctousd_button');
      driver.tap(btcToUsdBtnFinder);
      final input = find.byValueKey('btctousd_textfield');
      await driver.tap(input);
      await driver.enterText("-10");
      final result = find.byValueKey('Result');
      await driver.tap(result);
      final errorMessage = find.byValueKey('error_message');
      expect(await driver.getText(errorMessage), 'BTC value cannot be negative');
      final backButton  = find.byValueKey("backButton");
      await driver.tap(backButton);
    });
    test('USD value cannot be negative', () async {
      final btcToUsdBtnFinder = find.byValueKey('usdtobtc_button');
      driver.tap(btcToUsdBtnFinder);
      final input = find.byValueKey('usdtobtc_textfield');
      await driver.tap(input);
      await driver.enterText("-10");
      final result = find.byValueKey('Result');
      await driver.tap(result);
      final errorMessage = find.byValueKey('error_message');

      expect(await driver.getText(errorMessage), 'USD value cannot be negative');
      final backButton  = find.byValueKey("backButton");
      await driver.tap(backButton);
    });

  });

  group('Happy Paths', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    test('We start at the home screen', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      final usdtobtc = find.byValueKey('usdtobtc');
      final btctousd = find.byValueKey('btctousd');
      expect(await driver.getText(usdtobtc), "USD to BTC");
      expect(await driver.getText(btctousd), "BTC to USD");
    });

    test('If we want to convert usd to btc, we change to appropriate screens',
        () async {
      // First, tap the button.
      final usdtobtc = find.byValueKey('usdtobtc_button');
      await driver.tap(usdtobtc);
      // Then, verify the counter text is incremented by 1.
      final input = find.byValueKey('convertButtonText');
      expect(await driver.getText(input), "Convert"); //check textfield text key
      final backButton = find.byValueKey("backButton");
      await driver.tap(backButton);
    });

    test('If we want to convert btc to usd, we change to appropriate screens',
        () async {
      // First, tap the button.
      final btctousd = find.byValueKey('btctousd_button');
      await driver.tap(btctousd);
      final input = find.byValueKey('convertButtonText');
      expect(await driver.getText(input), "Convert");
      final backButton = find.byValueKey("backButton");
      await driver.tap(backButton);
    });

    test('We are able to convert btc to usd', () async {
      // First, tap the button.
      
      final btctousd = find.byValueKey('btctousd_button');
      await driver.tap(btctousd);
      final input = find.byValueKey('btctousd_textfield');
      await driver.tap(input);
      await driver.enterText("1");
      final result = find.byValueKey('Result');
      await driver.tap(result);
      final finalResult = find.byValueKey('btctousd_result');
      // Then, verify the counter text is incremented by 1.
      expect(await driver.getText(finalResult), "69855.0"); //isnt right
      final backButton  = find.byValueKey("backButton");
      await driver.tap(backButton);
    });

    test('We are able to convert usd to btc', () async {
      // First, tap the button.
      final usdtobtc = find.byValueKey('usdtobtc_button');
      await driver.tap(usdtobtc);      
      final input = find.byValueKey('usdtobtc_textfield');
      await driver.tap(input);
      await driver.enterText("69855");
      final result = find.byValueKey('Result');
      await driver.tap(result);
      // Then, verify the counter text is incremented by 1.
      final finalResult  = find.byValueKey('usdtobtc_result');
      expect(await driver.getText(finalResult), "1.0");
      final backButton  = find.byValueKey("backButton");
      await driver.tap(backButton);
    });
  });
}
