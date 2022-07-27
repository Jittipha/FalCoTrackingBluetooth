// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';
import 'dart:html';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trackingbluetooth/MainMenu.dart';

import 'package:trackingbluetooth/saveformrepair.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:intl/intl.dart';

import 'Background/Bg-Edit.dart';

class RoomEquipment extends StatefulWidget {
  RoomEquipment({required this.Device});
  List Device = [];
  @override
  State<RoomEquipment> createState() => _RoomEquipmentState();
}

class _RoomEquipmentState extends State<RoomEquipment> {
  late IO.Socket socket = IO.io("http://192.168.1.192:8000", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });
  List<SalesData> listtemp = [];
  List<SalesData> listbatt = [];
  List<SalesData> listhum = [];
  dynamic updateiot;
  List<String> Day = [];
  List Data = ['', '', '', '', '', '', ''];
  List test = [];

  var mac;

  int check = 0;
  bool onlyonce1 = false;
  bool onlyonce2 = false;
  var messagedayandmac;

  @override
  void initState() {
    if (socket.connected == true) {
      socket.disconnect();
    } else {
      socket.connect();
    }
    setfirstmac();
    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  void setfirstmac() {
    if (selectedIndex == 0) {
      mac = widget.Device[0]['mac'];
    }
    setState(() {});
  }

  void addlistday() {
    for (int a = -7; a < 0; a++) {
      String day = DateFormat("yyyy-MM-dd")
          .format(DateTime.now().add(Duration(days: a)));
      Day.add(day);
    }

    messagedayandmac = {
      'day1': Day[0],
      'day2': Day[1],
      'day3': Day[2],
      'day4': Day[3],
      'day5': Day[4],
      'day6': Day[5],
      'day7': Day[6],
      'mac': mac
    };
  }

  Future connectsocket() async {
    // socket.onConnect((data) {
    //   print("Connected");
    // });
    addlistday();
    List Dayshow = [];

    var list;
    String? splitdt;
    String? convertstringtemp;
    String? convertstringbat;
    String? convertstringhum;
    var temp;
    var batt;
    var hum;
    String? check;

    print('mac >>>> $mac ------ $onlyonce1 -----${socket.connected}');
// Future.delayed(const Duration(milliseconds: 300), () {});
    socket.emit('selectmac', mac);

    socket.on("message", (msg) {
      if (!onlyonce1) {
        print(msg);
        if (msg[0]['mac'] == mac && msg != null) {
          updateiot = {
            'temp': msg[0]["temperature"],
            'batt': msg[0]["battery"],
            'hum': msg[0]["humidity"]
          };
        } else {
          socket.emit('selectmac', mac);
          socket.on("message", (msg) {
            print(msg);

            updateiot = {
              'temp': msg[0]["temperature"],
              'batt': msg[0]["battery"],
              'hum': msg[0]["humidity"]
            };
            
          });
        }
        print(' messagedayandmac  ==$messagedayandmac');
        socket.emit('Temp', messagedayandmac);
        socket.on(
            'restemp',
            (data) => {
                  list = data[0]['dt_create'].split(' '),
                  splitdt = list[0],
                  if (check != splitdt)
                    {
                      check = splitdt,
                      convertstringtemp =
                          data[0]['AVG(temperature)'].toStringAsFixed(2),
                      temp = double.parse(convertstringtemp!),
                      convertstringbat =
                          data[0]['AVG(battery)'].toStringAsFixed(2),
                      batt = double.parse(convertstringbat!),
                      convertstringhum =
                          data[0]['AVG(humidity)'].toStringAsFixed(2),
                      hum = double.parse(convertstringhum!),
                      print('temp == $temp ,baat == $batt , humidity == $hum '),
                      listtemp.add(SalesData(splitdt!, temp)),
                      listbatt.add(SalesData(splitdt!, batt)),
                      listhum.add(SalesData(splitdt!, hum)),
                      //       }
                      //   },
                      if (this.mounted) {setState(() {})}
                    }
                });

        if (this.mounted) {
          setState(() {});
        }

        onlyonce1 = true;
      }
    });

    return updateiot;
  }


  int selectedIndex = 0;
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
              Container(
                height: 550,
                child: ListView.builder(
                    itemCount: widget.Device.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        selected: selectedIndex == index,
                        leading: const Icon(
                          Icons.devices,
                        ),
                        title: Text(widget.Device[index]['mac']),
                        onTap: () async {
                          mac = widget.Device[index]['mac'];
                          selectedIndex = index;
                          onlyonce1 = false;
                          listtemp = [];
                          listbatt = [];
                          listhum = [];
                          print(mac);
                          setState(() {});

                          Navigator.pop(context);
                        },
                      );
                    }),
              ),
              ListTile(
                leading: const Icon(Icons.arrow_back_sharp),
                title: const Text('Back to Mainmenu'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const mainmenu()),
                  // );
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
                  Text("รหัสอุปกรณ์ : " + mac),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                      future: connectsocket(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CircularPercentIndicator(
                                radius: 45,
                                lineWidth: 4.0,
                                percent: textforpercent(
                                    snapshot.data['temp'].toString()),
                                center: Text(
                                    snapshot.data['temp'].toString() + '°C'),
                                progressColor: Colors.pinkAccent,
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
                                percent: textforpercent(
                                    snapshot.data['batt'].toString()),
                                center: Text(
                                    snapshot.data['batt'].toString() + '%'),
                                progressColor: Colors.blue,
                                animation: true,
                                animationDuration: 900,
                                footer: const SizedBox(
                                    height: 20,
                                    width: 54,
                                    child: Text('แบตเตอรี่')),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              CircularPercentIndicator(
                                radius: 45.0,
                                lineWidth: 4.0,
                                percent: textforpercent(
                                    snapshot.data['hum'].toString()),
                                center:
                                    Text(snapshot.data['hum'].toString() + '%'),
                                progressColor: Colors.yellow,
                                animation: true,
                                animationDuration: 900,
                                footer: const SizedBox(
                                    height: 20,
                                    width: 54,
                                    child: Text('ความชื้น')),
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
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                  const SizedBox(
                    height: 28,
                  ),
                  // const BarChartSample2(),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  series: <LineSeries<SalesData, String>>[
                                LineSeries<SalesData, String>(
                                    // Bind data source
                                    dataSource: listtemp,
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true),
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.year,
                                    yValueMapper: (SalesData sales, _) =>
                                        sales.sales),
                                LineSeries<SalesData, String>(
                                    // Bind data source
                                    dataSource: listbatt,
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true),
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.year,
                                    yValueMapper: (SalesData sales, _) =>
                                        sales.sales),
                                LineSeries<SalesData, String>(
                                    // Bind data source
                                    dataSource: listhum,
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true),
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.year,
                                    yValueMapper: (SalesData sales, _) =>
                                        sales.sales)
                              ])),
                          const SizedBox(height: 20),
                          Center(
                            child: Row(
                              children: [
                                Row(
                                  children: const [
                                    SizedBox(
                                        width: 70, child: Text('อุณหภูมิ')),
                                    Icon(
                                      Icons.square,
                                      color: Colors.blue,
                                      size: 24.0,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 15),
                                Row(
                                  children: const [
                                    SizedBox(
                                        width: 70, child: Text('แบตเตอรี่')),
                                    Icon(
                                      Icons.square,
                                      color: Colors.purple,
                                      size: 24.0,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 15),
                                Row(
                                  children: const [
                                    SizedBox(
                                        width: 70, child: Text('ความชื้น')),
                                    Icon(
                                      Icons.square,
                                      color: Colors.pink,
                                      size: 24.0,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        )));
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
