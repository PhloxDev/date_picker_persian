import 'package:flutter/material.dart';
import 'package:date_picker_persian/date_converter.dart';
import 'package:date_picker_persian/date_picker_gregorian.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Date Picker Shamsi'),
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

  DateTime _date;
  ValueChanged<DateTime> _valueChangeDate;

  @override
  void initState() {
    super.initState();

    _date = new DateTime.now();

    _valueChangeDate = (DateTime date) {
      setState(() {
        _date = date;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Text(getPersianDate(_date),style: TextStyle(fontSize: 18.0),),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _selectDate(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.date_range),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePickerShamsi(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2015, 8),
        lastDate: new DateTime(2101));
      if (picked != null && picked != _date) _valueChangeDate(picked);
  }
}
