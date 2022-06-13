// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailRepair extends StatefulWidget {
  

  @override
  State<DetailRepair> createState() => _DetailRepairState();
}

class _DetailRepairState extends State<DetailRepair> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
            title: const Center(
              child: Text(
                "รายละเอียดการช่อม",
                style: TextStyle(fontSize: 30),
              ),
            ),
            titleSpacing: 300),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 800,
              height: 500,
              color: const Color.fromARGB(250, 255, 255, 255),
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: ListView(children: const <Widget>[
                 Text(
                  'รหัสเครื่อง : ' ,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'สถานะการใช้งาน : ',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height:30,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'บริษัท : '  ,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'วันที่ดำเนินการ : ' ,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'เวลาที่ซ่อม : ' ,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'รายละเอียด : ',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),
              ]),
            ),
          ),
        ));
  }

  //checktext(String check) {
  // print(check);
  // String text = "";
  // if (check == Null) {
  //   text = "- - -";
  // }
  //return check;
  //}
}
