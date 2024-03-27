import 'package:bitcoin_calculator/screens/btcToUsd.dart';
import 'package:bitcoin_calculator/screens/usdToBtc.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      home: MyHomePage(title: 'Counter App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed:() {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context)=>UsdToBtc())
                );
                },
              child: Text("USD to BTC", key: Key("usdtobtc")),
              key: Key('usdtobtc_button') //Key for usdtobtc_button+
            ),
            ElevatedButton(onPressed:() {
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>btcToUsd())
              );
            },
            child: Text("BTC to USD", key: Key("btctousd")),
            key: Key('btctousd_button') //Key for btctousd_button
            ),
          ],
        ),
      ),
    );
  }
}
