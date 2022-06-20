// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, non_constant_identifier_names, avoid_print, use_build_context_synchronously, duplicate_ignore
// ignore: avoid_web_libraries_in_flutter, unused_import
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
// ignore: unused_import
import 'package:http/http.dart ' as http;
import 'package:trackingbluetooth/ListData.dart';
import 'Background/Bg-Edit.dart';
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
  String? Status;
  
 

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
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
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
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      // firstDate: DateTime.utc(yyyy, mm, dd),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;
    String stDate = DateFormat('dd/MM/yyyy').format(newDate);

    setState(() {
      widget.result['End_Date'] = stDate;
    });
  }

  String dropdownvalue = 'กำลังใช้งาน';
  var status = [
    'เครื่องปิด',
    'เครื่องเสีย'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 18, 95, 116),
            title: const Center(
              child: Text(
                "เเก้ไขข้อมูลอุปกรณ์",
                style: TextStyle(fontSize: 30),
              ),
            ),
            titleSpacing: 300),
        body: Background(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1508614999368-9260051292e5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
                    fit: BoxFit.cover),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    left: 300, right: 300, top: 30, bottom: 50),
                child: Form(
                  key: updateTrack,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Text(
                        //   'เเก้ไขข้อมูลอุปกFรณ์',
                        //   style: TextStyle(fontSize: 25),
                        // ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          'สภาพการใช้งาน',
                          style: TextStyle(fontSize: 18),
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
                          validator: RequiredValidator(
                              errorText: "กรุณาใส่สภาพการใช้งาน!"),
                          onSaved: (value) {
                            setState(() =>
                                widget.result['Working_Condition'] = value);
                          },
                          maxLength: 50,
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'ตำเเหน่งที่ตั้ง',
                          style: TextStyle(fontSize: 18),
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
                          validator: RequiredValidator(
                              errorText: "กรุณาใส่ตำเเหน่งที่ตั้ง!"),
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
                                const Text('สถานะการทำงาน',
                                    style: TextStyle(fontSize: 20)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(),
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      // Initial Value
                                      value: track.Status,
                                      // Down Arrow Icon
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      hint: Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        "   " +
                                            (Status ??
                                                widget.result['Status']),
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      // Array list of items
                                      items: status.map((String status) {
                                        return DropdownMenuItem(
                                          value: status,
                                          child: Text('   ' + status),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          Status = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                )
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
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                  255, 243, 33, 33)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ))),
                                  onPressed: () async {
                                    if (updateTrack.currentState!.validate()) {
                                      updateTrack.currentState!.save();
                                      if (widget.result['Status'] != "กำลังซ่อม" ) {
                                      showAlertDialog(context);
                                      } else {

                                        Fluttertoast.showToast(
                                            timeInSecForIosWeb: 4,
                                            msg: "อุปกรณ์นี้กำลังซ่อมอยู่ ไม่สามารถเเก้ไขสถานะได้ !",
                                            textColor: Colors.white,
                                            backgroundColor: Colors.redAccent,
                                            gravity: ToastGravity.CENTER);
                                      }
                                    }
                                  },
                                  child: const Text("ยืนยัน",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              255, 254, 253, 253)),
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
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                  255, 66, 66, 67)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: const BorderSide(width: 0.1),
                                        //side: const BorderSide(width: 2),
                                      ))),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("ยกเลิก",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              255, 254, 253, 253)),
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
              )),
        ) //        )],
        // ),
        //      ),

        );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
        child: const Text("OK"),
        onPressed: () async {
           String? Date;
           if (
            Status =="เครื่องปิด"
           ) {
            Date = DateFormat("dd/MM/yyyy").format(DateTime.now());
           }
           
          var res = await http
              .put(Uri.parse('http://192.168.1.192:3000/track'), body: {
            'Track_ID': widget.result['Track_ID'],
            'Location': widget.result['Location'],
            'Working_Condition': widget.result['Working_Condition'],
            'Last_Improve_Date':'',
            'End_Date': Date ?? '',
            'Note': widget.result['Note'] ?? '',
            'Status': Status,
          });
          if (res.statusCode == 200) {
            print("true");
            Navigator.pop(context);
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Listdata()),
            );
          }
        });

    // ignore: deprecated_member_use
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
