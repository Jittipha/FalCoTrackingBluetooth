// ignore_for_file: file_names

import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trackingbluetooth/EditTrack.dart';
import 'package:trackingbluetooth/model/track.dart';
import 'package:http/http.dart ' as http;

class Listdata extends StatefulWidget {
  const Listdata({Key? key}) : super(key: key);

  @override
  State<Listdata> createState() => _ListdataState();
}

class _ListdataState extends State<Listdata> {
  TextEditingController _searchController = TextEditingController();
  //ลิสทั้งหมดที่มัี
  List _allresult = [];
  //ลิสที่ค้นหาได้
  List _resultList = [];
  late Future resultsLoaded;
  //เม็ดตอธทำงานก่อน widget build
  @override
  void initState() {
    super.initState();
    setState(() {});
    // Getdata();
    // getheightforlength();
    _searchController.addListener((_onSearchChanged));
  }

//เม็ดตอธทำงานก่อน widget build
  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

//เม็ดตอธทำงานก่อน widget build
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //resultloaded เท่ากันค่าที่เม็ดตอธ getdata return มา
    //ซึ่งเท่ากับ complete
    resultsLoaded = Getdata();
  }

//ดึงข้อมูลทั้งหมดมาเก็บใน allresult
  Getdata() async {
    var res = await http.get(Uri.parse('http://localhost:3000/tracks'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      setState(() {
        _allresult = jsonData;
      });
    }
    searchResultList();

    return 'Complete';
  }

  _onSearchChanged() {
    searchResultList();
  }

  searchResultList() {
    var showResult = [];
    //ในกล่อง Search มีค่า?
    if (_searchController.text != "") {
      for (var Snapshot in _allresult) {
        var Track_id = Track.fromSnapshot(Snapshot).Track_ID!.toLowerCase();
        //เช็คตัวแปร Name ของ event ทั้งหมดว่ามีส่วนประกอยของข้อความที่ใส่ไปรึป่าว
        //เช่น ในtext คือ p แล้วเอา p ไปเช็คกับชื่อ event ทั้งหมด
        if (Track_id.contains(_searchController.text.toLowerCase())) {
          showResult.add(Snapshot);
        }
      }
      //ในกล่อง Search ไม่ได้ใส่อะไร
    } else {
      //ให้ showresult เท่ากับ allresult คือ ถ้าไม่มีค่าในกล่อง search ให้โชว์event ทั้งหมด
      showResult = List.from(_allresult);
    }
    setState(() {
      //เอาค่าที่ได้มาใส่ใน resultlist
      _resultList = showResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 800,
              height: 500,
              color: const Color(0x003A94FB),
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Column(children: <Widget>[
                const Text(
                  "อุปกรณ์ทั้งหมด",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autofocus: false,
                  controller: _searchController,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                      hintText: 'ค้นหาด้วยรหัสอุปกรณ์..... '),
                ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: _resultList.length,
                      itemBuilder: ((BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4,
                                offset: Offset(2, 4), // Shadow position
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            title: Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'รหัสเครื่อง : ' + _resultList[index]['Track_ID'],
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                            ),
                            subtitle: Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'ตำเเหน่งที่ตั้ง : ' +
                                  _resultList[index]['Location'],
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditTrack(
                                                    result: _resultList[index],
                                                  )),
                                        );
                                      },
                                      child: const Icon(Icons.edit)),
                                ),
                                const SizedBox(
                                  width: 20,
                                  // height: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      showAlertDialog(context,
                                          _resultList[index]['Track_ID']);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                    ))
                              ],
                            ),
                            onTap: () {},
                          ),
                        );
                      })),
                )
              ]),
            ),
          ),
        ));
  }

  showAlertDialog(BuildContext context, String Track_id) {
    // set up the button
    Widget okButton = FlatButton(
        child: const Text("OK"),
        onPressed: () async {
          var response = await http.delete(
              Uri.parse('http://localhost:3000/track'),
              body: {'Track_ID': Track_id});
          if (response.statusCode == 200) {
            setState(() {
              Navigator.pop(context);
            });
          } else {
            return print("Delete Fail!");
          }
        });

    Widget cancleButton = FlatButton(
      child: const Text("CANCLE"),
      onPressed: () {
        Navigator.pop(context, 'Cancel');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete This Track !"),
      content: const Text("Are you sure?"),
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
