// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackingbluetooth/Background/Bg-detail.dart';
import 'package:http/http.dart ' as http;
import 'package:trackingbluetooth/DetailRepair.dart';

class repairhistory extends StatefulWidget {
  repairhistory({Key? key, required this.trackid, required this.Count_Improve})
      : super(key: key);
  String? trackid;
  int? Count_Improve;

  @override
  State<repairhistory> createState() => _repairhistoryState();
}

class _repairhistoryState extends State<repairhistory> {
  //ลิสที่ค้นหาได้
  List _allresult = [];
  bool _alreadyconfirm = false;
  bool _checkfirstlist = false;

  void updateconfirm() {
    _alreadyconfirm = true;
  }

  void updatecheckfirstlist() {
    _checkfirstlist = true;
  }

  @override
  void initState() {
    super.initState();
    Getdata();
  }

  Getdata() async {
    var res = await http
        .get(Uri.parse('http://192.168.1.192:3000/history/${widget.trackid}'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      setState(() {
        _allresult = jsonData;
      });
    }

    return _allresult;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 18, 95, 116),
            title: const Center(
              child: Text(
                "ประวัติการซ่อม / ยืนยันการซ่อม",
                style: TextStyle(fontSize: 30),
              ),
            ),
            titleSpacing: 300),
        body: Background(
          child: FutureBuilder(
              future: Getdata(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://images.unsplash.com/photo-1651147538420-06f5e0d3f1d9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
                            fit: BoxFit.cover),
                      ),
                      padding: const EdgeInsets.only(
                        left: 400,
                        right: 400,
                        top: 70,
                      ),
                      child: Container(
                        width: 1000,
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                        child: Column(children: <Widget>[
                          const SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: _allresult.isEmpty
                                ? const Center(
                                    child: Text(
                                      "ไม่มีประวัติการซ่อม",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 252, 249, 249),
                                        fontSize: 30,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: _allresult.length,
                                    itemBuilder:
                                        ((BuildContext context, int index) {
                                      return Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                              // boxShadow: const [
                                              //   BoxShadow(
                                              //     color: Colors.grey,
                                              //     blurRadius: 100,
                                              //     offset: Offset(20, 10),
                                              //      // Shadow position
                                              //   ),
                                              // ],
                                            ),
                                            child: ListTile(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20.0),
                                              // const EdgeInsets.only(bottom: 20.0),
                                              title: Text(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                'วันที่ดำเนินการ : ' +
                                                    textfordate(
                                                        _allresult[index]
                                                            ["Day"],
                                                        _allresult[index]
                                                            ["Month"],
                                                        _allresult[index]
                                                            ["Year"],
                                                        _allresult[index]
                                                            ["Time"]),

                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              subtitle: Text(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                'สถานะ : ' +
                                                    _allresult[index]['Status'],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              trailing: trailng(
                                                  _allresult[index]["Status"],
                                                  _allresult[index],
                                                  index),

                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailRepair(
                                                            result: _allresult[
                                                                index],
                                                          )),
                                                );
                                              },
                                            ),
                                          ));
                                      // }return Container();
                                    })),
                          )
                        ]),
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }

  String textfordate(String day, month, year, time) {
    String Date = "$day/$month/$year  |  $time น.";
    return Date;
  }

  Widget trailng(String Status, Map<String, dynamic> result, int index) {
    print('already === $_alreadyconfirm');
    if (index == 0) {
      if (Status == 'กำลังซ่อม') {
        return Container(
            child: FlatButton(
          // ignore: sort_child_properties_last
          child: const Text('ซ่อมเสร็จสิ้น'),
          color: Colors.greenAccent,
          textColor: Colors.white,
          onPressed: () {
            showAlertDialog(context, result);
          },
        ));
      } else {
        return const Text("");
      }
    } else {
      if (Status == 'กำลังซ่อม') {
        return const Text(
          "กดใช้งานแล้ว",
          style: TextStyle(fontSize: 16, color: Colors.blueGrey),
        );
      } else {
        return const Text("");
      }
    }
  }

  showAlertDialog(BuildContext context, result) {
    // set up the button
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
        child: const Text("OK"),
        onPressed: () async {
          String day = DateFormat("dd").format(DateTime.now());
          String month = DateFormat("MM").format(DateTime.now());
          String year = DateFormat("yyyy").format(DateTime.now());
          String Timerepair = DateFormat("HH:mm").format(DateTime.now());
          var response = await http
              .post(Uri.parse('http://192.168.1.192:3000/history'), body: {
            'Track_ID': result["Track_ID"],
            'Day': day,
            'Month': month,
            'Year': year,
            'Time': Timerepair,
            'Repair_Description': result["Repair_Description"],
            'Status': "กำลังใช้งาน",
            'Company_Repair': result["Company_Repair"],
            'Count_Improve': widget.Count_Improve.toString()
          });
          if (response.statusCode == 200) {
            Navigator.pop(context);
            setState(() {
              Getdata();
            });
          } else {
            return print("Change Failed");
          }

          setState(() {});
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
      title: const Text("อุปกรณ์นี้พร้อมใช้งานแล้ว!"),
      content: const Text("คุณแน่ใจหรือป่าว?"),
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
