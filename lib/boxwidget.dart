import 'package:flutter/material.dart';

class BoxWidget extends StatelessWidget {
  final String? command;
  final String? output;
  BoxWidget({this.command, this.output});

  @override
  Widget build(BuildContext context) {
    print(command);
    print(output);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [Text("[root@localhost~] "), Text("${this.command}")],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text("${this.output}"),
        )
      ],
    );
  }
}
