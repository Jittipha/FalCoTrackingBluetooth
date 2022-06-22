// ignore_for_file: avoid_unnecessary_containers

import 'dart:html';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trackingbluetooth/chart.dart';
import 'package:trackingbluetooth/chart2.dart';
import 'package:trackingbluetooth/saveformrepair.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'Background/Bg-Edit.dart';

class RoomEquipment extends StatefulWidget {
  const RoomEquipment({Key? key}) : super(key: key);

  @override
  State<RoomEquipment> createState() => _RoomEquipmentState();
}

class _RoomEquipmentState extends State<RoomEquipment> {
  late IO.Socket socket;
  String? Temp;
  String? bat;
  String? hum;
  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() async {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket = IO.io("http://192.168.1.192:8000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        setState(() {
          Temp = msg[0]["temperature"];
          bat = msg[0]["battery"];
          hum = msg[0]["humidity"];
          print(Temp);
          print(bat);
          print(hum);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'อุปกรณ์ในห้อง',
        ),
        backgroundColor: const Color.fromARGB(255, 18, 95, 116),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                // <-- SEE HERE
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 18, 95, 116),
                ),
                child: Center(
                    child: Text(
                  'รหัสอุปกรณ์ในห้อง',
                  style: TextStyle(color: Colors.white),
                ))),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://images.pexels.com/photos/7135058/pexels-photo-7135058.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("รหัสอุปกรณ์:xxxxxxxxxxxxxx"),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularPercentIndicator(
                        radius: 45,
                        lineWidth: 4.0,
                        percent: textforpercent(Temp.toString()),
                        center: Text(Temp.toString() + '°C'),
                        progressColor: Colors.red,
                        animation: true,
                        animationDuration: 900,
                        footer: const Text('อุณหภูมิเครื่อง'),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 4.0,
                        percent: textforpercent(bat.toString()),
                        center: Text(bat.toString() + '%'),
                        progressColor: Colors.blue,
                        animation: true,
                        animationDuration: 900,
                        footer: const SizedBox(
                            height: 20, width: 54, child: Text('แบตเตอรี่')),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 4.0,
                        percent: textforpercent(hum.toString()),
                        center: Text(hum.toString() + '%'),
                        progressColor: Colors.yellow,
                        animation: true,
                        animationDuration: 900,
                        footer: const SizedBox(
                            height: 20, width: 54, child: Text('ความชื้น')),
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 8.0),
                      // ),
                      // CircularPercentIndicator(
                      //   radius: 45.0,
                      //   lineWidth: 4.0,
                      //   percent: 0.90,
                      //   center: const Text("90%"),
                      //   progressColor: Colors.green,
                      //   animation: true,
                      //   animationDuration: 900,
                      // )
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  // const BarChartSample2(),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: const [
                                  SizedBox(width: 70, child: Text('อุณหภูมิ')),
                                  Icon(
                                    Icons.square,
                                    color: Colors.red,
                                    size: 24.0,
                                  ),
                                ],
                              ),
                              Row(
                                children: const [
                                  SizedBox(width: 70, child: Text('แบตเตอรี่')),
                                  Icon(
                                    Icons.square,
                                    color: Colors.blue,
                                    size: 24.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  series: <LineSeries<SalesData, String>>[
                                LineSeries<SalesData, String>(
                                    // Bind data source
                                    dataSource: <SalesData>[
                                      SalesData('Jan', 10),
                                      SalesData('Feb', 60),
                                      SalesData('Mar', 30),
                                      SalesData('Apr', 50),
                                      SalesData('May', 50),
                                      SalesData('Jun', 34),
                                      SalesData('Jul', 70),
                                      SalesData('Aug', 80),
                                      SalesData('Sep', 90),
                                      SalesData('Oct', 100),
                                      SalesData('Nov', 20),
                                      SalesData('Dec', 30),
                                    ],
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true),
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.year,
                                    yValueMapper: (SalesData sales, _) =>
                                        sales.sales),
                                LineSeries<SalesData, String>(
                                    // Bind data source
                                    dataSource: <SalesData>[
                                      SalesData('Jan', 12),
                                      SalesData('Feb', 40),
                                      SalesData('Mar', 70),
                                      SalesData('Apr', 80),
                                      SalesData('May', 50),
                                      SalesData('Jun', 50),
                                      SalesData('Jul', 20),
                                      SalesData('Aug', 10),
                                      SalesData('Sep', 90),
                                      SalesData('Oct', 60),
                                      SalesData('Nov', 50),
                                      SalesData('Dec', 100),
                                    ],
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true),
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.year,
                                    yValueMapper: (SalesData sales, _) =>
                                        sales.sales)
                              ])),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  textforpercent(String Temp) {
    double a = double.parse(Temp);
    a = a / 100;
    a = a.abs();
    return a;
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
