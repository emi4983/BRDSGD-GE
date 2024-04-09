import 'package:bitcoin_calculator/utils/Conversions.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_calculator/utils/bitcoin_api.dart';
import 'package:http/http.dart' as http;
import 'package:bitcoin_calculator/config/globals.dart';

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
    btcPrice = BitcoinCalculatorAPI.fetchPrice(httpClient);
  }

  FutureBuilder<double> buildFutureBuilderUsdToBTC() {
    return FutureBuilder<double>(
      future: btcPrice,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          try {
            double price = snapshot.data;
            double usdAmount = double.tryParse(_controller.text) ?? 0.0;
            double btcAmount = Conversion.usdtobtc(usdAmount, price);
            return Text(
              "$btcAmount",
              key: Key('btc_price'),
              style: TextStyle(color: Colors.green, fontSize: 25.0),
            );
          } catch (e) {
            return Text(
              "USD value cannot be negative",
              key: Key('error_message'),
              style: TextStyle(color: Colors.red, fontSize: 25.0),
            ); 
          }
        } else if (snapshot.hasError) {
          return Text(
            snapshot.error.toString(),
            //key: Key('error_message'),
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
            buildFutureBuilderUsdToBTC(),
            TextField(
              key: Key('usdtobtc_textfield'), //TextField key for usdtobtc
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your USD value',
              ),
              controller: _controller,
              keyboardType: TextInputType.number,
            ),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
              //key: Key('error_message')
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  double usdAmount = double.tryParse(_controller.text) ?? 0.0;
                  if (usdAmount > 0) {
                    _errorMessage = '';
                  } else {
                    _errorMessage = 'USD value cannot be negative';
                  }
                });
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
