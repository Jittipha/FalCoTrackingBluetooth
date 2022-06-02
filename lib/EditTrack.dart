import 'package:flutter/material.dart';

class EditTrack extends StatefulWidget {
  const EditTrack({Key? key}) : super(key: key);

  @override
  State<EditTrack> createState() => _EditTrackState();
}

class _EditTrackState extends State<EditTrack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(100, 50, 35, 0),
            child: Column(
              children: [
                const Text(
                  'เเก้ไขข้อมูลอุปกรณ์',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(100, 50, 35, 0),
            child: Column(
              children: [
                const Text(
                  'สภาพการใช้งาน',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(100, 5, 100, 0),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(100, 50, 35, 0),
            child: Column(
              children: [
                const Text(
                  'ตำเเหน่งที่ตั้ง',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(100, 5, 100, 0),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(100, 50, 35, 0),
            child: Column(
              children: [
                const Text(
                  'หมายเหตุ',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(100, 5, 100, 0),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                ),
              ),
              maxLines: 4,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(800, 0, 0, 0),
            child: Row(
              children: [
                SizedBox(
                    height: 40,
                    width: 130,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(width: 2),
                          ))),
                      onPressed: () {},
                      child: const Text("ยืนยัน",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          textAlign: TextAlign.center),
                    )),
                SizedBox(
                  width: 30,
                ),
                SizedBox(
                    height: 40,
                    width: 130,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.redAccent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(width: 2),
                          ))),
                      onPressed: () {},
                      child: const Text("ยกเลิก",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          textAlign: TextAlign.center),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
