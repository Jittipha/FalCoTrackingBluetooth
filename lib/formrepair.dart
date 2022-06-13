import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trackingbluetooth/Background/Bg-detail%20copy.dart';
import 'package:trackingbluetooth/model/track.dart';
import 'package:http/http.dart ' as http;

class formrepair extends StatefulWidget {
  const formrepair({Key? key}) : super(key: key);

  @override
  State<formrepair> createState() => _formrepairState();
}

class _formrepairState extends State<formrepair> {
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

  final repairform = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 179, 229, 252),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 95, 116),
        title: const Center(
            child: Text(
          "แจ้งซ่อม",
          style: TextStyle(fontSize: 30),
        )),
        titleSpacing: 300,
      ),
      body: Background(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://images.unsplash.com/photo-1508614999368-9260051292e5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 300, right: 300, top: 30, bottom: 30),
          child: Form(
            key: repairform,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [const Text('data')],
            ),
          ),
        ),
      )),
    );
  }
}
