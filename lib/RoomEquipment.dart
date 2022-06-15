import 'package:flutter/material.dart';

import 'Background/Bg-Edit.dart';

class RoomEquipment extends StatefulWidget {
  const RoomEquipment({Key? key}) : super(key: key);

  @override
  State<RoomEquipment> createState() => _RoomEquipmentState();
}

class _RoomEquipmentState extends State<RoomEquipment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 250, 251, 251),
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 18, 95, 116),
            title: const Center(
              child: Text(
                "อุปกรณ์ในห้อง",
                style: TextStyle(fontSize: 30),
              ),
            ),
            titleSpacing: 300),
        body: Background(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://images.pexels.com/photos/7135058/pexels-photo-7135058.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                    fit: BoxFit.cover),
              )),
        ));
  }
}
