// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  Detail({Key? key, required this.result}) : super(key: key);
  Map<String, dynamic> result;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
            title: const Text(
              "รายละเอียดอุปกรณ์",
              style: TextStyle(fontSize: 25),
            ),
            titleSpacing: 300),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 800,
              height: 500,
              color: const Color(0x003A94FB),
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: ListView(children: <Widget>[
                Text(
                  'รหัสเครื่อง : ' + widget.result['Track_ID'],
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'ยี่ห้อ : ' + widget.result['Brand'],
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'รุ่น : ' + widget.result['Generation'],
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'ผู้ผลิต : ' + widget.result['Menufacurer'],
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'ขนาดเครื่อง : ' + widget.result['Size'],
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'สภาพการใช้งาน : ' + widget.result['Working_Condition'],
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'อายุการใช้งาน : ' + widget.result['Age_of_use'].toString(),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'ตำเเหน่งที่ตั้ง : ' + widget.result['Location'],
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'ใช้ในการ : ' + widget.result['Work_for'],
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'วันเปิดใช้งาน : ' + widget.result['Start_Enable_Date'],
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'จำนวนครั้งที่ซ่อม : ' +
                      (widget.result['Count_Improve'].toString()),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'วันที่ปรับปรุงล่าสุด : ' +
                      (widget.result['Last_Improve_Date'] ?? '- - -'),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'วันที่สิ้นสุดงาน : ' +
                      (widget.result['End_Date'] ?? '- - -'),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'หมายเหตุ : ' + (widget.result['Note'] ?? '- - -'),
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
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
