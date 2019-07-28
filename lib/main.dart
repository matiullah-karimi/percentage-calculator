import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Percentage Caclulator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<TextEditingController> _subjectControllers = [
    TextEditingController(text: ''),
    TextEditingController(text: ''),
    TextEditingController(text: ''),
    TextEditingController(text: ''),
  ];

  List<TextEditingController> _creditControllers = [
    TextEditingController(text: ''),
    TextEditingController(text: ''),
    TextEditingController(text: ''),
    TextEditingController(text: ''),
  ];

  List<TextEditingController> _scoreControllers = [
    TextEditingController(text: ''),
    TextEditingController(text: ''),
    TextEditingController(text: ''),
    TextEditingController(text: ''),
  ];

  final _formKey = GlobalKey<FormState>();

  List<Padding> _getColumnChildren() {
    List<Padding> rows = [];
    for (var i = 0; i < _subjectControllers.length; i++) {
      rows.add(_buildSingleSubjecRow(
          _subjectControllers[i], _creditControllers[i], _scoreControllers[i]));
    }

    rows.add(
      Padding(
        padding: EdgeInsets.all(5),
        child: RaisedButton(
          color: Colors.blue,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _calculate();
            }
          },
          child: Text(
            'Calculate',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Percentage Calculator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _getColumnChildren(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _subjectControllers.add(TextEditingController(text: ''));
            _creditControllers.add(TextEditingController(text: ''));
            _scoreControllers.add(TextEditingController(text: ''));
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _buildSingleSubjecRow(
      TextEditingController subjectController,
      TextEditingController creditController,
      TextEditingController scoreController) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Subject',
                  border: OutlineInputBorder(),
                  labelText: 'Subject'),
              controller: subjectController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            flex: 3,
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Credit',
                  border: OutlineInputBorder(),
                  labelText: 'Credit'),
              controller: creditController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            flex: 1,
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Score',
                  border: OutlineInputBorder(),
                  labelText: 'Score'),
              controller: scoreController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  void _calculate() {
    int totalScore = 0;
    int totalCredit = 0;

    for (var i = 0; i < _subjectControllers.length; i++) {
      int credit = int.parse(_creditControllers[i].text);
      int score = int.parse(_scoreControllers[i].text);

      totalScore += credit * score;
      totalCredit += credit;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Result'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '${(totalScore / totalCredit).toStringAsFixed(3)}%',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
