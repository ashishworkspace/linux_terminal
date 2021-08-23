import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String cmd = "";
  String? output = "";
  void httpCallFunction() async {
    var url = Uri.parse('http://13.233.143.214/cgi-bin/f.py?var=$cmd');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        output = response.body;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Linux Terminal")),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("[root@localhost~] "),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none),
                    cursorWidth: 7,
                    cursorHeight: 20,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      cmd = value;
                    },
                  ),
                ),
                TextButton(
                    onPressed: () {
                      httpCallFunction();
                    },
                    child: Text("Press"))
              ],
            ),
            Text("$output")
          ],
        ),
      ),
    );
  }
}
