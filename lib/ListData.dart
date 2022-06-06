// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Listdata extends StatefulWidget {
  const Listdata({Key? key}) : super(key: key);

  @override
  State<Listdata> createState() => _ListdataState();
}

class _ListdataState extends State<Listdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 800,
              height: 500,
              color: Color(0x003A94FB),
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
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: 'ค้นหาด้วยรหัสอุปกรณ์..... '),
                  ),
                  const SizedBox(
                  height: 30,
                ),
                Card(
                  color: Colors.white,
                  child: ListTile(
                    title: const Text(
                      'รหัสเครื่อง : ',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    subtitle: const Text(
                      'ตำเเหน่งที่ตั้ง : ',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {}, child: const Icon(Icons.edit)),
                        const SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.delete,
                            ))
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
