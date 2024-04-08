import 'package:bitcoin_calculator/utils/Conversions.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_calculator/utils/bitcoin_api.dart';
import 'package:http/http.dart' as http;

class btcToUsd extends StatefulWidget {
  @override
  State<btcToUsd> createState() => _btcToUsdState();
}

class _btcToUsdState extends State<btcToUsd> {
  Future<double> usdPrice;
  TextEditingController _controller = TextEditingController();
  String _errorMessage = '';
  double _result = 0.0;
  @override
  void initState() {
    super.initState();
    usdPrice = BitcoinCalculatorAPI.fetchPrice(http.Client());
  }

  FutureBuilder<double> buildFutureBuilderBtcToUSD() {
    return FutureBuilder<double>(
      future: usdPrice,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          double price = snapshot.data;
          double btcAmount = double.tryParse(_controller.text) ?? 0.0;
          double usdAmount = Conversion.btcToUsd(btcAmount, price);
          return Text(
            "$usdAmount",
            key: Key('btc_price'),
            style: TextStyle(color: Colors.green, fontSize: 25.0),
          );
        } else if (snapshot.hasError) {
          return Text(
            snapshot.error.toString(),
            key: Key('error_message'),
            style: TextStyle(color: Colors.red),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context);
          },
          key: Key('backButton'), //Key for back button
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildFutureBuilderBtcToUSD(), //Result key for btctousd
            TextField(
              key: Key('btctousd_textfield'), //TextField key for btctousd
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your BTC value',
              ),
              controller: _controller,
              keyboardType: TextInputType.number,
            ),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
              key: Key('error_message'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text(
                'Convert',
                key: Key("convertButtonText"),
              ),
              key: Key('Result'), //Button key for btctousd
            ),
          ],
        ),
      ),
    );
  }
}
