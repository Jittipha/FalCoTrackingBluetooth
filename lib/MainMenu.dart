// ignore_for_file: file_names, camel_case_types, prefer_const_literals_to_create_immutables, unnecessary_const

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:trackingbluetooth/Background/Bg.dart';
import 'package:trackingbluetooth/CreateTrack.dart';
import 'package:trackingbluetooth/ListData.dart';
import 'package:trackingbluetooth/repairform.dart';
import 'package:http/http.dart ' as http;
import 'RoomEquipment.dart';
import 'RoomEquipment.dart';

class mainmenu extends StatefulWidget {
  const mainmenu({Key? key}) : super(key: key);

  @override
  State<mainmenu> createState() => _mainmenuState();
}

class _mainmenuState extends State<mainmenu> {
  List Device = [];
  getmacdeive() async {
    var jsonData;
    var res = await http.get(Uri.parse('http://192.168.1.192:3000/iot/device'));
    if (res.statusCode == 200) {
      jsonData = jsonDecode(res.body);
      setState(() {
        Device = jsonData;
      });
    }
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 179, 229, 252),
      body: Background(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1622547748225-3fc4abd2cca0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1332&q=80"),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateTrack()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: const Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: const Align(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          'เพิ่มอุปกรณ์',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Listdata()));
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: const Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: const Align(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          'จัดการอุปกรณ์',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RepairList()));
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: const Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: const Align(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          'แจ้งซ่อม',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    await getmacdeive();
                    print(Device);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RoomEquipment(
                                  Device: Device,
                                )));
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: const Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: const Align(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          'อุปกรณ์ในห้อง',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
