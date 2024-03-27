import 'package:bitcoin_calculator/utils/Conversions.dart';
import 'package:flutter/material.dart';

class UsdToBtc extends StatefulWidget {

  @override
  State<UsdToBtc> createState() => _UsdToBtcState();
}

class _UsdToBtcState extends State<UsdToBtc> {
  TextEditingController _controller = TextEditingController();
  String _errorMessage = '';
  double _result = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          key: Key('backButton'), //Key for back button
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_result.toString(),
              key: Key('usdtobtc_result'), //Key for usdtobtc
              style: TextStyle(color: Colors.green,
              fontSize: 25.0), 
              ), //Result key for usdtobtc
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
              style: TextStyle(color: Colors.red),
              key: Key('error_message')
            ),
            ElevatedButton(
              onPressed: () {
              try{
                String usdValue = _controller.text;
                String btcValue = Conversion.usdtobtc(double.parse(usdValue)).toString();
                setState(() {
                  _result = double.parse(btcValue);
                  _errorMessage = '';
                });
              } catch(e){
                  setState(() {
                  _errorMessage = 'USD value cannot be negative';
                  });
                }
              },
              child: Text('Convert', key: Key('convertButtonText'),),
              key: Key('Result'), //Button key for usdtobtc
            ),
          ],
        ),
      ),
    );
  }
}