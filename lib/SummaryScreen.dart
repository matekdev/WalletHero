import 'package:flutter/material.dart';

class SummaryScreen extends StatefulWidget {
  var data;
  SummaryScreen({Key? key, this.data}) : super(key: key);

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("${widget.data}"),
    );
  }
}
