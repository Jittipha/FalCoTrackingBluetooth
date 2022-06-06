// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';

import 'model/track.dart';

class EditTrack extends StatefulWidget {
  const EditTrack({Key? key}) : super(key: key);

  @override
  State<EditTrack> createState() => _EditTrackState();
}

class _EditTrackState extends State<EditTrack> {
  final updateTrack = GlobalKey<FormState>();
  Track track = Track();
  DateTime date = DateTime(2022, 01, 01);
  DateTime? dateTime;
  //DateTime? newDate;
  String getTextDateStart() {
    if (track.Last_Improve_Date == null) {
      return "Select Date";
    } else {
      return track.Last_Improve_Date!;
    }
  }

  String getTextDateLast() {
    if (track.End_Date == null) {
      return "Select Date";
    } else {
      return track.End_Date!;
    }
  }

  Future pickDateStart(BuildContext context) async {
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
      
      track.Last_Improve_Date = stDate;
    });
  }

  Future pickDateLast(BuildContext context) async {
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
      track.End_Date = stDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
            title: const Text(
              "เเก้ไขข้อมูลอุปกรณ์",
              style: TextStyle(fontSize: 25),
            ),
            titleSpacing: 300),
        body: Padding(
          padding: const EdgeInsets.only(left: 300, right: 300, top: 30),
          child: Form(
            key: updateTrack,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // const Text(
              //   'เเก้ไขข้อมูลอุปกรณ์',
              //   style: TextStyle(fontSize: 25),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              const Text(
                'สภาพการใช้งาน',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(),
                ),
                initialValue: track.Working_Condition,
                validator:
                    RequiredValidator(errorText: "กรุณาใส่สภาพการใช้งาน!"),
                onSaved: (value) {
                  setState(() => track.Working_Condition = value);
                },
                maxLines: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'ตำเเหน่งที่ตั้ง',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(),
                ),
                 initialValue: track.Location,
                validator:
                    RequiredValidator(errorText: "กรุณาใส่ตำเเหน่งที่ตั้ง!"),
                onSaved: (value) {
                   setState(() => track.Location = value);
                },
                maxLines: 2,
              ),
              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text('วันที่ปรับปรุงล่าสุด',
                          style: TextStyle(fontSize: 20)),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.175,
                        child: ElevatedButton.icon(
                          onPressed: () => pickDateStart(context),
                          label: Text(
                            getTextDateStart(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          icon: const Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.025,
                  ),
                  Column(
                    children: [
                      const Text('วันที่สิ้นสุด',
                          style: TextStyle(fontSize: 20)),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.175,
                        child: ElevatedButton.icon(
                          onPressed: () => pickDateLast(context),
                          label: Text(
                            getTextDateLast(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          icon: const Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'หมายเหตุ',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(),
                ),
                
                onSaved: (value) {
                  setState(() => track.Note = value);
                },
                maxLines: 5,
              ),
              const SizedBox(
                height: 50,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 40,
                      width: 130,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ))),
                        onPressed: () {
                          if (updateTrack.currentState!.validate()) {
        updateTrack.currentState!.save();
                          print(track.Location);
                         } },
                        child: const Text("ยืนยัน",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            textAlign: TextAlign.center),
                      )),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                      height: 40,
                      width: 130,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              //side: const BorderSide(width: 2),
                            ))),
                        onPressed: () {},
                        child: const Text("ยกเลิก",
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            textAlign: TextAlign.center),
                      )),
                ],
              ),
              //      Container(
              //        child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: <Widget>[
              //           Padding(padding: EdgeInsets.all(16.16)),
              //           SizedBox(
              //             height: 45,
              //             width: 300,
              //             child: ElevatedButton.icon(
              //               onPressed: () => pickDate(context),
              //               label: Text(
              //                 getTextDate(),
              //                 style: const TextStyle(
              //                   fontSize: 18,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //               style: ElevatedButton.styleFrom(
              //                   primary: Color.fromARGB(255, 250, 248, 248),
              //                   shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(15))),
              //               icon: Icon(
              //                 Icons.calendar_month_rounded,
              //                 color: Colors.black,
              //                 size: 30,
              //               ),
              //             ),

              //        )],
              // ),
              //      ),
            ]),
          ),
        ) //        )],
        // ),
        //      ),

        );
  }
}
