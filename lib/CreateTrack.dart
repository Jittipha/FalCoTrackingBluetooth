import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
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
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 200, right: 200, top: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
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
                        initialValue: track.Track_ID,
                        validator: RequiredValidator(
                            errorText: "กรุณากรอกรหัสเครื่อง"),
                        onSaved: (value) {
                          setState(() => track.Track_ID = value);
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
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            hintText: 'ระบุยี่ห้อ'),
                        initialValue: track.Brand,
                        validator:
                            RequiredValidator(errorText: "กรุณาระบุยี่ห้อ"),
                        onSaved: (value) {
                          setState(() => track.Brand = value);
                        },
                      ),
                    ),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
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
                        initialValue: track.Generation,
                        validator: RequiredValidator(
                            errorText: "กรุณากรอกรุ่นของเครื่อง"),
                        onSaved: (value) {
                          setState(() => track.Generation = value);
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
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            hintText: 'บริษัทผู้ผลิต'),
                        initialValue: track.Menufacurer,
                        validator: RequiredValidator(
                            errorText: "กรุณากรอกชื่อ บริษัท"),
                        onSaved: (value) {
                          setState(() => track.Menufacurer = value);
                        },
                      ),
                    ),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
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
                        initialValue: track.Size,
                        validator: RequiredValidator(
                            errorText: "กรุณากรอกขนาดของเครื่อง"),
                        onSaved: (value) {
                          setState(() => track.Size = value);
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
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            hintText: 'สภาพการใช้งานของเครื่อง'),
                        initialValue: track.Working_Condition,
                        validator: RequiredValidator(
                            errorText: "กรุณากรอกสภาพการใช้งาน"),
                        onSaved: (value) {
                          setState(() => track.Working_Condition = value);
                        },
                      ),
                    ),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
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
                        initialValue: track.Location,
                        validator: RequiredValidator(
                            errorText: "กรุณาระบุตำแหน่งของเครื่อง"),
                        onSaved: (value) {
                          setState(() => track.Location = value);
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
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            hintText: 'ใช้ในการ'),
                        initialValue: track.Work_for,
                        validator: RequiredValidator(
                            errorText: "กรุณาระบุว่าเครื่องใช้ทำอะไร"),
                        onSaved: (value) {
                          setState(() => track.Work_for = value);
                        },
                      ),
                    ),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.26,
                      ),
                      Expanded(
                        // optional flex property if flex is 1 because the default flex is 1
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: const OutlineInputBorder(),
                              hintText: 'หมายเหตุ'),
                          maxLines: 5,
                          initialValue: track.Note,
                          validator:
                              RequiredValidator(errorText: "กรุณาระบุหมายเหตุ"),
                          onSaved: (value) {
                            setState(() => track.Note = value);
                          },
                        ),
                      ),
                    ]),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.2,
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          print(track.Track_ID);
                          print(track.Brand);
                          print(track.Generation);
                          print(track.Menufacurer);
                          print(track.Size);
                          print(track.Working_Condition);
                          print(track.Location);
                          print(track.Work_for);
                          print(track.Start_Enable_Date);
                          print(track.Note);
                        }
                      },
                      child: const Text("ยืนยัน",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          textAlign: TextAlign.center),
                    )),
              ],
            ),
          )),
    );
  }
}
