// ignore_for_file: file_names, prefer_const_constructors, avoid_print, non_constant_identifier_names, prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:trackingbluetooth/Background/Bg-detail.dart';
import 'package:http/http.dart ' as http;
import 'model/track.dart';

class CreateTrack extends StatefulWidget {
  const CreateTrack({Key? key}) : super(key: key);

  @override
  State<CreateTrack> createState() => _CreateTrackState();
}

class _CreateTrackState extends State<CreateTrack> {
  late FToast fToast;
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
      firstDate: DateTime(2000),
      // firstDate: DateTime.utc(yyyy, mm, dd),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;
    String stDate = DateFormat('dd/MM/yyyy').format(newDate);

    setState(() {
      track.Start_Enable_Date = stDate;
    });
  }

  String dropdownvalue = 'กำลังใช้งาน';

  // List of items in our dropdown menu
  var status = [
    'กำลังใช้งาน',
    'กำลังซ่อม',
    'อยู่ระหว่างการดูแลรักษา',
    'กำลังเปลี่ยนชิ้นส่วน',
    'เครื่องปิด',
    'เครื่องเสีย'
  ];
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 251, 251),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 18, 95, 116),
          title: const Center(
            child: Text(
              "สร้างอุปกรณ์",
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
                  "https://images.pexels.com/photos/7135058/pexels-photo-7135058.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 200, right: 200, top: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Padding(padding: EdgeInsets.all(16.16)),
                        const Expanded(
                          child: Text(
                            "รหัสเครื่อง",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        const Expanded(
                          child: Text("ยี่ห้อ"),
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
                              hintText: 'กรอกรหัสเครื่อง'),
                          initialValue: track.Track_ID,
                          maxLength: 50,
                          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          // keyboardType: TextInputType.number,
                          validator: RequiredValidator(
                              errorText: "กรุณากรอกรหัสเครื่อง"),
                          onSaved: (value) {
                            setState(
                                () => track.Track_ID = value?.toUpperCase());
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
                          initialValue: track.Brand,
                          maxLength: 50,
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
                        const Padding(padding: EdgeInsets.all(16.16)),
                        const Expanded(
                          child: Text(
                            "รุ่น",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        const Expanded(
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
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: 'รุ่นของเครื่อง'),
                          initialValue: track.Generation,
                          maxLength: 20,
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
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: 'บริษัทผู้ผลิต'),
                          initialValue: track.Menufacturer,
                          maxLength: 30,
                          validator: RequiredValidator(
                              errorText: "กรุณากรอกชื่อ บริษัท"),
                          onSaved: (value) {
                            setState(() => track.Menufacturer = value);
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Padding(padding: EdgeInsets.all(16.16)),
                        const Expanded(
                          child: Text(
                            "ขนาดเครื่อง ( หน่วยเป็น cm เช่น 70*50 )",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        const Expanded(
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
                          initialValue: track.Size,
                          maxLength: 50,
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
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: 'สภาพการใช้งานของเครื่อง'),
                          initialValue: track.Working_Condition,
                          maxLength: 50,
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
                        const Padding(padding: EdgeInsets.all(16.16)),
                        const Expanded(
                          child: Text(
                            "ตำแหน่งที่ตั้ง",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        const Expanded(
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
                          initialValue: track.Location,
                          maxLength: 100,
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
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: 'ใช้ในการ'),
                          initialValue: track.Work_for,
                          maxLength: 100,
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
                        const Padding(padding: EdgeInsets.all(16.16)),
                        const Expanded(
                          child: Text(
                            "อายุการใช้งาน (ปี)",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        const Expanded(
                          child: Text("หมายเหตุ"),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Padding(padding: EdgeInsets.all(16.16)),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          flex: 1,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                hintText: 'อายุการใช้งานของเครื่อง'),
                            maxLength: 5,
                            validator: RequiredValidator(
                                errorText: "กรุณาระบุอายุการใช้งานของเครื่อง"),
                            onSaved: (value) {
                              int Age = int.parse(value!);
                              setState(() => track.Age_of_use = Age);
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
                                hintText: 'หมายเหตุ'),
                            maxLines: 3,
                            maxLength: 500,
                            initialValue: track.Note,
                            onSaved: (value) {
                              setState(() => track.Note = value);
                            },
                          ),
                        ),
                      ]),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(padding: EdgeInsets.all(16.16)),
                        const Expanded(
                          child: Text(
                            "วันที่เปิดใช้งาน",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        //       Expanded(
                        //         child: Text(
                        //           "สถานะการทำงาน",
                        //           style: TextStyle(fontSize: 15),
                        //         ),
                        //       ),
                      ]),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
                    const Padding(padding: EdgeInsets.fromLTRB(32, 0, 0, 0)),
                    Container(
                      width: 250,
                      child: Expanded(
                        flex: 1,
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
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 9, 58, 126)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(width: 0.1),
                            ))),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // ignore: non_constant_identifier_names

                            int Count_Improve = 0;
                            print(track.Track_ID);
                            print(track.Brand);
                            print(track.Generation);
                            print(track.Menufacturer);
                            print(track.Size);
                            print(track.Working_Condition);
                            print(track.Location);
                            print(track.Age_of_use);
                            print(track.Work_for);
                            print(track.Start_Enable_Date);
                            print(track.Note);
                            print(track.Status);

                            print(Count_Improve);
                            var res = await http.post(
                                Uri.parse('http://192.168.1.192:3000/track'),
                                body: {
                                  'Track_ID': track.Track_ID,
                                  'Brand': track.Brand,
                                  'Size': track.Size,
                                  'Location': track.Location,
                                  'Start_Enable_Date': track.Start_Enable_Date,
                                  'Working_Condition': track.Working_Condition,
                                  'Generation': track.Generation,
                                  'Menufacturer': track.Menufacturer,
                                  'Age_of_use': track.Age_of_use.toString(),
                                  'Work_for': track.Work_for,
                                  'Note': track.Note ?? '',
                                  'Count_Improve': Count_Improve.toString(),
                                  'Status': "กำลังใช้งาน",
                                });
                            // ignore: unused_local_variable
                            var data = res.body;
                            if (res.statusCode == 200) {
                              print("true");
                              Fluttertoast.showToast(
                                  msg: "เพิ่มอุปกรณ์แล้ว!",
                                  gravity: ToastGravity.CENTER);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: const Text("ยืนยัน",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 248, 245, 245)),
                            textAlign: TextAlign.center),
                      )),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            )),
      )),
    );
  }
}
