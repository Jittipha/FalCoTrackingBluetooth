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
              color: const Color.fromARGB(250, 255, 255, 255),
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: ListView(children: <Widget>[
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'รหัสเครื่อง : ' + widget.result['Track_ID'],
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'ยี่ห้อ : ' + widget.result['Brand'],
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'รุ่น : ' + widget.result['Generation'],
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'ผู้ผลิต : ' + widget.result['Menufacturer'],
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'ขนาดเครื่อง : ' + widget.result['Size'],
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'สภาพการใช้งาน : ' + widget.result['Working_Condition'],
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'อายุการใช้งาน : ' + widget.result['Age_of_use'].toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'ตำเเหน่งที่ตั้ง : ' + widget.result['Location'],
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'ใช้ในการ : ' + widget.result['Work_for'],
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'วันเปิดใช้งาน : ' + widget.result['Start_Enable_Date'],
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'จำนวนครั้งที่ซ่อม : ' +
                      (widget.result['Count_Improve'].toString()),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'วันที่ปรับปรุงล่าสุด : ' +
                      (widget.result['Last_Improve_Date'] ?? '- - -'),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'วันที่สิ้นสุดงาน : ' +
                      (widget.result['End_Date'] ?? '- - -'),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  'หมายเหตุ : ' + (widget.result['Note'] ?? '- - -'),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
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
