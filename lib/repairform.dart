import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:trackingbluetooth/model/track.dart';

class RepairList extends StatefulWidget {
  const RepairList({Key? key}) : super(key: key);

  @override
  State<RepairList> createState() => _RepairListState();
}

class _RepairListState extends State<RepairList> {
  bool asTabs = false;
  Track track = Track();
  String? selectedValueSingleDialog;
  List<DropdownMenuItem<String>> test = [];
  List h = ['nanine', 'nanon', 'nagarn', 'nanick', 'nahee'];
  String dropdownValue = 'One';
  final _formKey = GlobalKey<FormState>();
  final updateTrack = GlobalKey<FormState>();

  @override
  void initState() {
    // ignore: unused_local_variable
    String wordPair = "";
    // ignore: avoid_function_literals_in_foreach_calls
    h.forEach((element) {
      test.add(DropdownMenuItem(
        // ignore: sort_child_properties_last
        child: Text(element),
        value: element,
      ));
    });

    super.initState();
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text('รหัสเครื่องที่ต้องการซ่อม',
                  style: TextStyle(fontSize: 20)),
              Column(
                children: widgets
                    .map(
                      (k, v) {
                        return (MapEntry(
                            k,
                            Center(
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
                            ))));
                      },
                    )
                    .values
                    .toList(),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  const Text('สถานะการทำงาน', style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: DropdownButton<String>(
                                  value: track.Status,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
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
                                    'อยู่ระหว่างการดูแลรักษา',
                                    'กำลังเปลี่ยนชิ้นส่วน',
                                    'เครื่องปิด',
                                    'เครื่องเสีย'
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  const Text('รายระเอียดการซ่อม',
                      style: TextStyle(fontSize: 20)),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 300, right: 300, top: 10, bottom: 50),
                          child: TextFormField(
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
                            maxLines: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('ชื่อบริษัทที่รับซ่อม',
                  style: TextStyle(fontSize: 20)),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 300, right: 300, top: 10, bottom: 50),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(),
                      ),
                      initialValue: track.Company_Repair,
                      onSaved: (value) {
                        setState(() => track.Company_Repair = value);
                      },
                      maxLength: 500,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 40,
                      width: 130,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 243, 33, 33)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ))),
                        onPressed: () async {},
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
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 66, 66, 67)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
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
    );
  }
}
