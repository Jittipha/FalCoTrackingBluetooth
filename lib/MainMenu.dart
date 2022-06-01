import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:trackingbluetooth/CreateTrack.dart';
import 'package:trackingbluetooth/ListData.dart';

class mainmenu extends StatefulWidget {
  const mainmenu({Key? key}) : super(key: key);

  @override
  State<mainmenu> createState() => _mainmenuState();
}

class _mainmenuState extends State<mainmenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Center(
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
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(4, 8), // Shadow position
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
                    MaterialPageRoute(builder: (context) => const Listdata()));
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(4, 8), // Shadow position
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
            )
          ],
        ),
      ),
    );
  }
}
