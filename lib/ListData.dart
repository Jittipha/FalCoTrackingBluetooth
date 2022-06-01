import 'package:flutter/material.dart';

class Listdata extends StatefulWidget {
  const Listdata({Key? key}) : super(key: key);

  @override
  State<Listdata> createState() => _ListdataState();
}

class _ListdataState extends State<Listdata> {
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: const SingleChildScrollView());
  }
}
