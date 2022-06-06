
// ignore_for_file: file_names

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/track.dart';

class CreateTrack extends StatefulWidget {
  const CreateTrack({Key? key}) : super(key: key);

  @override
  State<CreateTrack> createState() => _CreateTrackState();
}

class _CreateTrackState extends State<CreateTrack> {
  Track track = Track();
  DateTime date = DateTime(2022, 01, 01);
  DateTime? dateTime;
  //DateTime? newDate;
  String getTextDate() {
    if (track.Start_Enable_Date == null) {
      return "Select Date";
    } else {
      return track.Start_Enable_Date!;
    }
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime ?? initialDate,
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      // firstDate: DateTime.utc(yyyy, mm, dd),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;
    String stDate = DateFormat('dd/MM/yyyy').format(newDate);

    setState(() {
      track.Start_Enable_Date = stDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
       appBar: AppBar(
            title: const Text(
              "สร้างอุปกรณ์",
              style: TextStyle(fontSize: 25),
            ),
            titleSpacing: 300),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(200, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "สร้างอุปกรณ์",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(16.16)),
                    Expanded(
                      child: Text(
                        "รหัสเครื่อง",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(width: 0.0),
                    Expanded(
                      child: Text("ยี่ห้อ"),
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(16.16)),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          hintText: 'กรอกรหัสเครื่อง'),
                    ),
                  ),
                  SizedBox(width: 300.0),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          hintText: 'ระบุยี่ห้อ'),
                    ),
                  ),
                  SizedBox(width: 300.0),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(16.16)),
                    Expanded(
                      child: Text(
                        "รุ่น",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(width: 0.0),
                    Expanded(
                      child: Text("ผู้ผลิต"),
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(16.16)),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          hintText: 'รุ่นของเครื่อง'),
                    ),
                  ),
                  SizedBox(width: 300.0),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          hintText: 'บริษัทผู้ผลิต'),
                    ),
                  ),
                  SizedBox(width: 300.0),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(16.16)),
                    Expanded(
                      child: Text(
                        "ขนาดเครื่อง",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(width: 0.0),
                    Expanded(
                      child: Text("สภาพการใช้งาน"),
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(16.16)),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          hintText: 'ขนาดของเครื่อง'),
                    ),
                  ),
                  SizedBox(width: 300.0),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          hintText: 'สภาพการใช้งานของเครื่อง'),
                    ),
                  ),
                  SizedBox(width: 300.0),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(16.16)),
                    Expanded(
                      child: Text(
                        "ตำแหน่งที่ตั้ง",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(width: 0.0),
                    Expanded(
                      child: Text("ใช้ในการ"),
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(16.16)),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          hintText: 'ตำแหน่งของเครื่อง'),
                    ),
                  ),
                  SizedBox(width: 300.0),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          hintText: 'ใช้ในการ'),
                    ),
                  ),
                  SizedBox(width: 300.0),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(16.16)),
                    Expanded(
                      child: Text(
                        "วันเปิดใช้งาน",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Expanded(
                      child: Text("หมายเหตุ"),
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(16.16)),
                    SizedBox(
                      height: 45,
                      width: 300,
                      child: ElevatedButton.icon(
                        onPressed: () => pickDate(context),
                        label: Text(
                          getTextDate(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 250, 248, 248),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        icon: Icon(
                          Icons.calendar_month_rounded,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(width: 300.0),
                    Expanded(
                      // optional flex property if flex is 1 because the default flex is 1
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            hintText: 'หมายเหตุ'),
                      ),
                    ),
                    SizedBox(
                      width: 300.0,
                      height: 50,
                    ),
                  ]),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                  height: 40,
                  width: 130,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 4, 211, 225)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(width: 2),
                        ))),
                    onPressed: () {},
                    child: const Text("ยืนยัน",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        textAlign: TextAlign.center),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
