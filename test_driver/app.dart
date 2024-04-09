import 'package:flutter_driver/driver_extension.dart';
import 'package:bitcoin_calculator/main.dart' as app;
import 'package:bitcoin_calculator/config/globals.dart' as globals;
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:bitcoin_calculator/utils/bitcoin_api.dart';

class MockClient extends Mock implements http.Client {}

void main() async{
  // This line enables the extension.
  enableFlutterDriverExtension();
  final MockClient client = MockClient();
  final fakePriceData =
      '{"time":{"updated":"Apr 8, 2024 02:41:00 UTC","updatedISO":"2024-04-08T02:41:00+00:00","updateduk":"Apr 8, 2024 at 03:41 BST"},"disclaimer":"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org","bpi":{"USD":{"code":"USD","rate":"69,390.926","description":"United States Dollar","rate_float":69390.92}}}';
  var url = Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
  when(client.get(url))
      .thenAnswer((_) async => http.Response(fakePriceData, 200));
  double price = await BitcoinCalculatorAPI.fetchPrice(client);
  globals.httpClient = client;
  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
