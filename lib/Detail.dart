// ignore_for_file: file_names, avoid_unnecessary_containers

import 'dart:convert';
import 'package:flutter/material.dart';
import 'Background/Bg-detail copy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart ' as http;

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  Detail({Key? key, required this.trackid}) : super(key: key);
  String? trackid;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late dynamic _allresult;

  @override
  void initState() {
    super.initState();
    Getdata();
  }

  Future<dynamic> Getdata() async {
    var res = await http
        .get(Uri.parse('http://192.168.1.192:3000/track/${widget.trackid}'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      _allresult = jsonData;
    }

    return _allresult;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 18, 95, 116),
            title: const Center(
              child: Text(
                "รายละเอียดอุปกรณ์",
                style: TextStyle(fontSize: 30),
              ),
            ),
            titleSpacing: 300),
        body: FutureBuilder(
            future: Getdata(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Background(
                  child: Container(
                    // height: double.infinity,
                    // width: double.infinity,
                    // decoration: const BoxDecoration(
                    //   image: DecorationImage(
                    //       image: NetworkImage(
                    //           // "https://images.unsplash.com/photo-1606230535080-45fdf9d56512?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1331&q=80"
                    //           "https://images.unsplash.com/photo-1614851099175-e5b30eb6f696?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
                    //       fit: BoxFit.cover),
                    // ),
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
                              // ignore: prefer_interpolation_to_compose_strings
                              'รหัสเครื่อง : ' + _allresult['Track_ID'],
                              style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'ยี่ห้อ : ' + _allresult['Brand'],
                              style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'รุ่น : ' + _allresult['Generation'],
                              style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'ผู้ผลิต : ' + _allresult['Menufacturer'],
                              style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'ขนาดเครื่อง : ' + _allresult['Size'],
                              style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'สภาพการใช้งาน : ' +
                                  _allresult['Working_Condition'],
                              style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'อายุการใช้งาน : ' +
                                  _allresult['Age_of_use'].toString() +
                                  ' ปี ',
                              style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'ตำเเหน่งที่ตั้ง : ' + _allresult['Location'],
                              style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'ใช้ในการ : ' + _allresult['Work_for'],
                              style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'วันเปิดใช้งาน : ' +
                                  _allresult['Start_Enable_Date'],
                              style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'สถานะของเครื่อง : ' + _allresult['Status'],
                              style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'จำนวนครั้งที่ซ่อม : ' +
                                  (_allresult['Count_Improve'].toString()),
                              style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'วันที่ปรับปรุงล่าสุด : ' +
                                  (_allresult['Last_Improve_Date'] ?? '- - -'),
                              style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'วันที่สิ้นสุดงาน : ' +
                                  (_allresult['End_Date'] ?? '- - -'),
                              style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'หมายเหตุ : ' + (_allresult['Note'] ?? '- - -'),
                              style: GoogleFonts.alike(
                                  textStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
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
