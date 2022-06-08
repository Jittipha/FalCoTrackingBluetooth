// ignore_for_file: file_names
// ignore: avoid_web_libraries_in_flutter, unused_import
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
// ignore: unused_import
import 'package:http/http.dart ' as http;
import 'package:trackingbluetooth/ListData.dart';
import 'model/track.dart';

// ignore: must_be_immutable
class EditTrack extends StatefulWidget {
  EditTrack({Key? key, required this.result}) : super(key: key);
  Map<String, dynamic> result;

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
    if (widget.result['Last_Improve_Date'] == null ||
        widget.result['Last_Improve_Date'] == '') {
      return "Select Date";
    } else {
      return widget.result['Last_Improve_Date']!;
    }
  }

  String getTextDateLast() {
    if (widget.result['End_Date'] == "" || widget.result['End_Date'] == null) {
      return "Select Date";
    } else {
      return widget.result['End_Date']!;
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
      widget.result['Last_Improve_Date'] = stDate;
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
      widget.result['End_Date'] = stDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
            title: const Center(
              child: Text(
                "เเก้ไขข้อมูลอุปกรณ์",
                style: TextStyle(fontSize: 25),
              ),
            ),
            titleSpacing: 300),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 300, right: 300, top: 30),
          child: Form(
            key: updateTrack,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // const Text(
              //   'เเก้ไขข้อมูลอุปกFรณ์',
              //   style: TextStyle(fontSize: 25),
              // ),
              const SizedBox(
                height: 50,
              ),
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
                initialValue: widget.result['Working_Condition'],
                validator:
                    RequiredValidator(errorText: "กรุณาใส่สภาพการใช้งาน!"),
                onSaved: (value) {
                  setState(() => widget.result['Working_Condition'] = value);
                },
                maxLength: 50,
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
                initialValue: widget.result['Location'],
                validator:
                    RequiredValidator(errorText: "กรุณาใส่ตำเเหน่งที่ตั้ง!"),
                onSaved: (value) {
                  setState(() => widget.result['Location'] = value);
                },
                maxLength: 100,
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
                        width: MediaQuery.of(context).size.width * 0.168,
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
                    width: MediaQuery.of(context).size.width * 0.020,
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
                        width: MediaQuery.of(context).size.width * 0.168,
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
                initialValue: widget.result['Note'],
                onSaved: (value) {
                  setState(() => widget.result['Note'] = value);
                },
                maxLength: 500,
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
                        onPressed: () async {
                          if (updateTrack.currentState!.validate()) {
                            updateTrack.currentState!.save();
                            showAlertDialog(context);
                          }
                        },
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
        child: const Text("OK"),
        onPressed: () async {
          print(widget.result['Count_Improve']);
          int Count_Improve = widget.result['Count_Improve'];
          
          Count_Improve = Count_Improve + 1;
          print(Count_Improve);
        
          var res =
              await http.put(Uri.parse('http://localhost:3000/track'), body: {
            'Track_ID': widget.result['Track_ID'],
            'Location': widget.result['Location'],
            'Working_Condition': widget.result['Working_Condition'],
            'Last_Improve_Date': widget.result['Last_Improve_Date'],
            'Count_Improve': Count_Improve.toString(),
            'End_Date': widget.result['End_Date'],
            'Note': widget.result['Note'],
          });
          if (res.statusCode == 200) {
            print("true");
             Navigator.pop(context);
          // ignore: use_build_context_synchronously
          Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>const Listdata(
                                                    
                                                  )),
                                        );
          }
         
        });

    Widget cancleButton = FlatButton(
      child: const Text("CANCLE"),
      onPressed: () {
        Navigator.pop(context, 'Cancel');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Do you want to change?"),
      content: const Text("sure?"),
      actions: [cancleButton, okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
