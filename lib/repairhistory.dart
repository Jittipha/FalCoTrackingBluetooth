import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trackingbluetooth/Background/Bg-detail.dart';
import 'package:http/http.dart ' as http;
import 'package:trackingbluetooth/Detail.dart';
import 'package:trackingbluetooth/DetailRepair.dart';
import 'package:trackingbluetooth/EditTrack.dart';

class repairhistory extends StatefulWidget {
  repairhistory({Key? key, required this.trackid}) : super(key: key);
  String? trackid;

  @override
  State<repairhistory> createState() => _repairhistoryState();
}

class _repairhistoryState extends State<repairhistory> {
  //ลิสที่ค้นหาได้
  List _allresult = [];

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
        print(_allresult.length);
      });
    }

    return 'Complete';
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 18, 95, 116),
            title: const Center(
              child: Text(
                "ประวัติการซ่อม/ยืนยันการซ่อม",
                style: TextStyle(fontSize: 30),
              ),
            ),
            titleSpacing: 300),
        body: Background(
          child: Align(
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
                                color: Color.fromARGB(255, 252, 249, 249),
                                fontSize: 30,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _allresult.length,
                            itemBuilder: ((BuildContext context, int index) {
                              return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                                                _allresult[index]["Day"],
                                                _allresult[index]["Month"],
                                                _allresult[index]["Year"]),
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                      subtitle: Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        'สถานะ : ' +
                                            _allresult[index]['Status'],
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),

                                      //
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailRepair(
                                                    result: _allresult[index],
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
          ),
        ));
  }

  String textfordate(String day, month, year) {
    String Date = "$day/$month/$year";
    return Date;
  }
}
