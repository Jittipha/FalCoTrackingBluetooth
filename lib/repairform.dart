import 'dart:convert';
import 'dart:developer';
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
        await http.get(Uri.parse('http://192.168.1.192:3000/track/trackid'));
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
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
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
                                validator: RequiredValidator(
                                    errorText: "กรุณาใส่ชื่อบริษัท!"),
                                onSaved: (value) {
                                  setState(() => track.Company_Repair = value);
                                },
                                maxLength: 100,
                                maxLines: 2),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 250,
                        child: Column(
                          children: [
                            const Text('รายละเอียดการซ่อม',
                                style: TextStyle(fontSize: 20)),
                            TextFormField(
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(),
                              ),
                              initialValue: track.Repairdetail,
                              validator: RequiredValidator(
                                  errorText: "กรุณาใส่รายละเอียด!"),
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
                                if (selectedValueSingleDialog != null) {
                                  int? count;
                                  String? status;
                                  _allresult.forEach(((element) => {
                                        if (element['Track_ID'] ==
                                            selectedValueSingleDialog)
                                          {
                                            count = element["Count_Improve"],
                                            status = element["Status"],
                                          }
                                      }));
                                  if (status == "กำลังซ่อม") {
                                    Fluttertoast.showToast(
                                        msg: "อยู่ระหว่างการซ่อมแซมอยู่!",
                                        gravity: ToastGravity.CENTER);
                                  } else {
                                    // int C = int.parse(count);
                                    count = count! + 1;

                                    print(selectedValueSingleDialog);

                                    print(track.Repairdetail);
                                    print(track.Company_Repair);
                                    print(count);

                                    var res = await http.post(
                                        Uri.parse(
                                            'http://192.168.1.192:3000/history'),
                                        body: {
                                          'Track_ID': selectedValueSingleDialog,
                                          'Status': "กำลังซ่อม",
                                          'Day': day,
                                          'Month': month,
                                          'Year': year,
                                          'Time': Timerepair,
                                          'Repair_Description':
                                              track.Repairdetail,
                                          'Company_Repair':
                                              track.Company_Repair,
                                          'Count_Improve': count.toString(),
                                        });
                                    var data = res.body;
                                    if (res.statusCode == 200) {
                                      print("true");
                                      Fluttertoast.showToast(
                                          msg: "แจ้งซ่อมสำเร็จ!",
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
