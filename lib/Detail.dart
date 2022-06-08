// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

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
              child: ListView(children: const <Widget>[
                Text(
                  'รหัสเครื่อง : ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'ยี่ห้อ : ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'รุ่น : ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'ผู้ผลิต : ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'ขนาดเครื่อง : ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'สภาพการใช้งาน : ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'อายุการใช้งาน : ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'ตำเเหน่งที่ตั้ง : ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'ใช้ในการ : ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'วันเปิดใช้งาน : ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'วันที่ปรับปรุงล่าสุด : ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'วันที่สิ้นสุดงาน : ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'หมายเหตุ : ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                ),
              ]),
            ),
          ),
        ));
  }
}
