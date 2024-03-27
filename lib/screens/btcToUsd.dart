import 'package:bitcoin_calculator/utils/Conversions.dart';
import 'package:flutter/material.dart';

class btcToUsd extends StatefulWidget {
  @override
  State<btcToUsd> createState() => _btcToUsdState();
}

class _btcToUsdState extends State<btcToUsd> {
  TextEditingController _controller = TextEditingController();
  String _errorMessage = '';
  double _result = 0.0;
  @override
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
            Text(
              _result.toString(),
              key: Key('btctousd_result'), //Key for btctousd
              style: TextStyle(color: Colors.green, fontSize: 25.0),
            ), //Result key for btctousd
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
                try {
                  String btcValue = _controller.text;
                  String usdValue =
                      Conversion.btcToUsd(double.parse(btcValue)).toString();
                  setState(() {
                    _result = double.parse(usdValue);
                    _errorMessage = '';
                  });
                } catch (e) {
                  setState(() {
                    _errorMessage = 'BTC value cannot be negative';
                  });
                }
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
