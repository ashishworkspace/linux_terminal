import 'package:flutter/material.dart';
import 'package:terminal/boxwidget.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? cmd = "";
  String? out = "";

  List<BoxWidget> individual = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Linux Terminal")),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: individual),
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
                      child: Text("Press"),
                      onPressed: () async {
                        var url = Uri.parse(
                            'http://13.233.143.214/cgi-bin/f.py?var=$cmd');
                        var response = await http.get(url);
                        if (response.statusCode == 200) {
                          setState(() {
                            out = response.body;
                          });

                          individual.add(BoxWidget(
                            command: "$cmd",
                            output: "$out",
                          ));
                        }
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
