import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:trackingbluetooth/Background/Bg-detail%20copy.dart';
import 'package:trackingbluetooth/model/track.dart';
import 'package:http/http.dart ' as http;

class RepairList extends StatefulWidget {
  const RepairList({Key? key}) : super(key: key);

  @override
  State<RepairList> createState() => _RepairListState();
}

class _RepairListState extends State<RepairList> {
  late FToast fToast;
  bool asTabs = false;
  Track track = Track();
  String? selectedValueSingleDialog;
  List<DropdownMenuItem<String>> test = [];
  List h = [];
  String dropdownValue = 'One';
  final _formKey = GlobalKey<FormState>();
  final updateTrack = GlobalKey<FormState>();
  List _allresult = [];

  String day = DateFormat("dd").format(DateTime.now());
  String month = DateFormat("MM").format(DateTime.now());
  String year = DateFormat("yyyy").format(DateTime.now());
  
  // ignore: non_constant_identifier_names
  String Timerepair = DateFormat("HH:mm").format(DateTime.now());

  @override
  void initState() {
    super.initState();
    getdata();
    print(test);
  }

  getdata() async {
    var res =
        await http.get(Uri.parse('http://192.168.1.192:3000/tracks/trackid'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      _allresult = jsonData;
      _allresult.forEach((element) => {h.add(element['Track_ID'])});

      h.forEach((element) {
        test.add(DropdownMenuItem(
          // ignore: sort_child_properties_last
          child: Text(element),
          value: element,
        ));
      });
      setState(() {});
    }
    ;

    return 'Complete';
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> widgets;
    widgets = {
      "เครื่องที่ต้องการแจ้งซ่อม": SearchChoices.single(
        items: test,
        value: selectedValueSingleDialog,
        hint: "เลือกเครื่องที่ต้องการซ่อม",
        searchHint: "เลือกเครื่อง",
        onChanged: (value) {
          setState(() {
            selectedValueSingleDialog = value;
          });
        },
        isExpanded: true,
      ),
    };

    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 95, 116),
        title: const Center(
          child: Text(
            "แจ้งซ่อม",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
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
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text('รหัสเครื่องที่ต้องการซ่อม',
                      style: TextStyle(fontSize: 20)),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: widgets
                        .map(
                          (k, v) {
                            return (MapEntry(
                                k,
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 300,
                                    right: 300,
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: Color.fromARGB(255, 26, 1, 1),
                                        width: 1.0,
                                      ),
                                    ),
                                    margin: const EdgeInsets.all(20),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Column(
                                        children: <Widget>[
                                          Text("$k:"),
                                          v,
                                        ],
                                      ),
                                    ),
                                  ),
                                ))));
                          },
                        )
                        .values
                        .toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      const Text('สถานะการทำงาน',
                          style: TextStyle(fontSize: 20)),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: track.Status,
                                  icon: const Icon(Icons.arrow_downward),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 13, 13, 13)),
                                  hint: const Text(
                                    "   " + "เลือกสถานะการทำงานของเครื่อง",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      track.Status = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'กำลังใช้งาน',
                                    'กำลังซ่อม',
                                  ].map<DropdownMenuItem<String>>(
                                      (String status) {
                                    return DropdownMenuItem<String>(
                                      value: status,
                                      // ignore: prefer_interpolation_to_compose_strings
                                      child: Text('   ' + status),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        child: Column(
                          children: [
                            const Text('ชื่อบริษัทที่รับซ่อม',
                                style: TextStyle(fontSize: 20)),
                            TextFormField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(),
                                ),
                                initialValue: track.Company_Repair,
                                onSaved: (value) {
                                  setState(() => track.Company_Repair = value);
                                },
                                maxLength: 100,
                                maxLines: 2),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 250,
                        child: Column(
                          children: [
                            const Text('รายระเอียดการซ่อม',
                                style: TextStyle(fontSize: 20)),
                            TextFormField(
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(),
                              ),
                              initialValue: track.Repairdetail,
                              onSaved: (value) {
                                setState(() => track.Repairdetail = value);
                              },
                              maxLength: 500,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),


                  SizedBox(
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
                                        const Color.fromARGB(255, 243, 33, 33)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ))),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // ignore: non_constant_identifier_names
                                if (track.Status != null &&
                                    selectedValueSingleDialog != null) {
                                  print(selectedValueSingleDialog);
                                  print(track.Status);
                                  print(track.Repairdetail);
                                  print(track.Company_Repair);

                                  var res = await http.post(
                                      Uri.parse(
                                          'http://192.168.1.192:3000/history'),
                                      body: {
                                        'Track_ID': selectedValueSingleDialog,
                                        'Day': day,
                                        'Month': month,
                                        'Year': year,
                                        'Time': Timerepair,
                                        'Repair_Description':
                                            track.Repairdetail,
                                        'Status': track.Status,
                                        'Company_Repair': track.Company_Repair,
                                      });
                                  var data = res.body;
                                  if (res.statusCode == 200) {
                                    print("true");
                                    Fluttertoast.showToast(
                                        msg: "เพิ่มอุปกรณ์แล้ว!",
                                        gravity: ToastGravity.CENTER);
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    // }
                                    print("posted");
                                  } else {
                                    fToast.showToast(
                                        child: toast,
                                        gravity: ToastGravity.TOP_RIGHT);
                                  }
                                }
                              }
                            },
                            child: const Text("ยืนยัน",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 254, 253, 253)),
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
                                        const Color.fromARGB(255, 66, 66, 67)),
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
                                    color: Color.fromARGB(255, 254, 253, 253)),
                                textAlign: TextAlign.center),
                          )),
                    ],
                  ),
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.redAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(
          Icons.cancel_outlined,
          color: Colors.white,
          size: 25,
        ),
        SizedBox(
          width: 12.0,
        ),
        Text(
          "กรุณาใส่สถานะการทำงาน !",
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}
