import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trackingbluetooth/Background/Bg-detail.dart';
import 'package:http/http.dart ' as http;
import 'package:trackingbluetooth/DetailRepair.dart';

class repairhistory extends StatefulWidget {
  const repairhistory({Key? key}) : super(key: key);

  @override
  State<repairhistory> createState() => _repairhistoryState();
}

class _repairhistoryState extends State<repairhistory> {
  TextEditingController _searchController = TextEditingController();
  //ลิสทั้งหมดที่มัี
  List _allresult = [];
  //ลิสที่ค้นหาได้
  List _resultList = [];
  late Future resultsLoaded;
  @override
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //resultloaded เท่ากันค่าที่เม็ดตอธ getdata return มา
    //ซึ่งเท่ากับ complete
    resultsLoaded = Getdata();
  }

  Getdata() async {
    var res = await http.get(Uri.parse('http://192.168.1.192:3000/tracks'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      setState(() {
        _allresult = jsonData;
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
                "ประวัติการซ่อม",
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
                                                      DetailRepair(
                                                          // result:
                                                          //     _resultList[index],
                                                          )),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.settings,
                                            color: Colors.black,
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                      // height: 10,
                                    ),
                                  ],
                                ),
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
