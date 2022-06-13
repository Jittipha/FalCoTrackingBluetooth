import 'package:flutter/material.dart';

class RepairList extends StatefulWidget {
  const RepairList({Key? key}) : super(key: key);

  @override
  State<RepairList> createState() => _RepairListState();
}

class _RepairListState extends State<RepairList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 18, 95, 116),
            title:  const Center(
              child:Text(
                "ประวัติการซ่อม",
                style: TextStyle(fontSize: 30),
              ),
            ),
    ));
  }
}