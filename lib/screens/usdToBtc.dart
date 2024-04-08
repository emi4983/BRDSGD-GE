import 'package:bitcoin_calculator/utils/Conversions.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_calculator/utils/bitcoin_api.dart';
import 'package:http/http.dart' as http;

class UsdToBtc extends StatefulWidget {
  @override
  State<UsdToBtc> createState() => _UsdToBtcState();
}

class _UsdToBtcState extends State<UsdToBtc> {
  Future<double> btcPrice;
  TextEditingController _controller = TextEditingController();
  String _errorMessage = '';
  double _result = 0.0;
  @override
  void initState() {
    super.initState();
    btcPrice = BitcoinCalculatorAPI.fetchPrice(http.Client());
  }

  FutureBuilder<double> buildFutureBuilderUsdToBTC() {
    return FutureBuilder<double>(
      future: btcPrice,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          double price = snapshot.data;
          double usdAmount = double.tryParse(_controller.text) ?? 0.0;
          double btcAmount = Conversion.usdtobtc(usdAmount, price);
          return Text(
            "$btcAmount",
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
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
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
            buildFutureBuilderUsdToBTC(), //Result key for usdtobtc
            // Text(
            //   _result.toString(),
            //   key: Key('usdtobtc_result'), //Key for usdtobtc
            //   style: TextStyle(color: Colors.green, fontSize: 25.0),
            // ), //Result key for usdtobtc
            TextField(
              key: Key('usdtobtc_textfield'), //TextField key for usdtobtc
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your USD value',
              ),
              controller: _controller,
              keyboardType: TextInputType.number,
            ),
            Text(_errorMessage,
                style: TextStyle(color: Colors.red), key: Key('error_message')),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text(
                'Convert',
                key: Key('convertButtonText'),
              ),
              key: Key('Result'), //Button key for usdtobtc
            ),
          ],
        ),
      ),
    );
  }
}
