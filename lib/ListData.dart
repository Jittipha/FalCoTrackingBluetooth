// ignore_for_file: file_names, prefer_final_fields, non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trackingbluetooth/Background/Bg-detail.dart';
import 'package:trackingbluetooth/Detail.dart';
import 'package:trackingbluetooth/EditTrack.dart';
import 'package:trackingbluetooth/model/track.dart';
import 'package:http/http.dart ' as http;
import 'package:trackingbluetooth/repairhistory.dart';

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
    var res = await http.get(Uri.parse('http://192.168.1.192:3000/tracks'));
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
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 18, 95, 116),
            title: const Center(
              child: Text(
                "อุปกรณ์ทั้งหมด",
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
                    height: 50,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: _resultList.length,
                        itemBuilder: ((BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
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
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                // const EdgeInsets.only(bottom: 20.0),
                                title: Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  'รหัสเครื่อง : ' +
                                      _resultList[index]['Track_ID'],
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
                                                  builder: (context) =>

                                                      repairhistory(trackid:  _resultList[index]['Track_ID'],)),
                                            );
                                          },
                                          
                                          child: const Icon(
                                            Icons.build,
                                            color: Colors.black,
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                      // height: 10,
                                    ),
                                    GestureDetector(
                                         onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                        EditTrack(
                                                        result:
                                                            _resultList[index],
                                                      )),
                                            );
                                          },
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        )),
                                        const SizedBox(
                                      width: 20,
                                      // height: 10,
                                    ),
                                        GestureDetector(
                                        onTap: () {
                                          showAlertDialog(
                                              context,
                                              _resultList[index]['Track_ID'],
                                              index);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                        
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Detail(
                                              result: _resultList[index],
                                            )),
                                  );
                                },
                              ),
                            ),
                          );
                        })),
                  )
                ]),
              ),
            ),
          ),
        ));
  }

  showAlertDialog(BuildContext context, String Track_id, index) {
    // set up the button
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
        child: const Text("OK"),
        onPressed: () async {
          var response = await http.delete(
              Uri.parse('http://192.168.1.192:3000/track'),
              body: {'Track_ID': Track_id});
          if (response.statusCode == 200) {
            _resultList.remove(_resultList[index]);
            Navigator.pop(context);
            setState(() {});
          } else {
            return print("Delete Fail!");
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
