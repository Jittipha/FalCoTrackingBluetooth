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
  final _formKey = GlobalKey<FormState>();
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
          padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                    Padding(padding: EdgeInsets.all(16.16)),
                    Expanded(
                      child: Text(
                        "รหัสเครื่อง",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
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
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'กรอกรหัสเครื่อง'),
                      validator: (Value) {
                        if (Value == null || Value.isEmpty) {
                          return 'กรุณากรอกรหัสเครื่อง';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'ระบุยี่ห้อ'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                    Padding(padding: EdgeInsets.all(16.16)),
                    Expanded(
                      child: Text(
                        "รุ่น",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Expanded(
                      child: Text("ผู้ผลิต"),
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.all(16.16)),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                          hintText: 'รุ่นของเครื่อง'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'บริษัทผู้ผลิต'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                    Padding(padding: EdgeInsets.all(16.16)),
                    Expanded(
                      child: Text(
                        "ขนาดเครื่อง",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Expanded(
                      child: Text("สภาพการใช้งาน"),
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.all(16.16)),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'ขนาดของเครื่อง'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'สภาพการใช้งานของเครื่อง'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                    Padding(padding: EdgeInsets.all(16.16)),
                    Expanded(
                      child: Text(
                        "ตำแหน่งที่ตั้ง",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Expanded(
                      child: Text("ใช้ในการ"),
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.all(16.16)),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'ตำแหน่งของเครื่อง'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'ใช้ในการ'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
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
                    const Padding(padding: EdgeInsets.all(16.16)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.07,
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
                            primary: const Color.fromARGB(255, 250, 248, 248),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        icon: const Icon(
                          Icons.calendar_month_rounded,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.225,
                    ),
                    Expanded(
                      // optional flex property if flex is 1 because the default flex is 1
                      flex: 1,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: 'หมายเหตุ'),
                        maxLines: 5,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                  ]),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 4, 211, 225)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(width: 2),
                        ))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
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
