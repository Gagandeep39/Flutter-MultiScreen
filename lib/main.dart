import 'package:flutter/material.dart';

main() {
  runApp(MaterialApp(
    title: "Multiscreen",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _nameController = new TextEditingController();
  String receivedData;

  Future _goToSecondScreen(BuildContext context) async {
    //Because we are returning data as map
    Map result = await Navigator.of(context)
        .push(new MaterialPageRoute<Map>(builder: (BuildContext context) {
      return new NextScreen(name: _nameController.text);
    }));
    if (result != null && result.containsKey('info')) {
      receivedData = result['info'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen One"),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(receivedData == null
                ? "App Launched "
                : "Recieved Data: $receivedData"),
          ),
          ListTile(
            title: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
          ),
          ListTile(
            title: RaisedButton(
              child: Text("Next Screen"),
              onPressed: () {
//                Navigator.of(context).push(
//                  new MaterialPageRoute<Map>(builder: (BuildContext context) {
//                    return new NextScreen(name: _nameController.text);
//                  }));
                _goToSecondScreen(context);
              },
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class NextScreen extends StatefulWidget {
  final String name;

  const NextScreen({Key key, this.name}) : super(key: key);

  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  var _returnTextController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Scree")),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("${widget.name}"),
            ),
            ListTile(
              title: TextField(
                decoration: InputDecoration(
                  labelText: "Enter Text to send back",
                ),
                controller: _returnTextController,
              ),
            ),
            ListTile(
              title: RaisedButton(
                onPressed: () {
                  Navigator.pop(context, {'info': _returnTextController.text});
                },
                child: Text("Back"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
