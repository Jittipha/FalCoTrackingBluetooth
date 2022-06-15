// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Background/Bg-detail copy.dart';

// ignore: must_be_immutable
class DetailRepair extends StatefulWidget {
  DetailRepair({Key? key, required this.result}) : super(key: key);
  Map<String, dynamic> result;

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
        body: Background(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient:
        
                            //  LinearGradient(colors: [Color.fromARGB(255, 230, 246, 214), Color.fromARGB(255, 120, 187, 242)]),
                            const LinearGradient(
                                begin: Alignment(-1, -1),
                                end: Alignment(2, 0),
                                colors: [
                              Color.fromARGB(255, 245, 246, 247),
                              Color.fromARGB(255, 248, 246, 247)
                            ])),
        
                    //        decoration: BoxDecoration(
        
                    // borderRadius: BorderRadius.circular(10),
                    // color: const Color.fromARGB(250, 255, 255, 255),
                    // ),
                    width: 400,
                    height: 500,
                
                
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: ListView(children: <Widget>[
                  Text(
                    'รหัสเครื่อง : ' + widget.result['Track_ID'],
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    // ignore: prefer_interpolation_to_compose_strings
                    'สถานะการใช้งาน :' + widget.result['Status'],
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    // ignore: prefer_interpolation_to_compose_strings
                    'บริษัท : ' + widget.result['Company_Repair'],
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    // ignore: prefer_interpolation_to_compose_strings
                    'วันที่ดำเนินการ : ' +
                        textfordate(widget.result['Day'], widget.result['Month'],
                            widget.result['Year']),
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    // ignore: prefer_interpolation_to_compose_strings
                    'เวลาที่ซ่อม : ' + widget.result['Time'],
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    // ignore: prefer_interpolation_to_compose_strings
                    'รายละเอียด : ' + widget.result['Repair_Description'],
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ]),
              ),
            ),
          ),
        ));
  }

  String textfordate(String day, month, year) {
    String Date = "$day/$month/$year";
    return Date;
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
