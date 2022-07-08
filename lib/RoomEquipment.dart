// ignore_for_file: avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:intl/intl.dart';
import 'package:http/http.dart ' as http;

class RoomEquipment extends StatefulWidget {
  const RoomEquipment({Key? key}) : super(key: key);

  @override
  State<RoomEquipment> createState() => _RoomEquipmentState();
}

class _RoomEquipmentState extends State<RoomEquipment> {
  late IO.Socket socket = IO.io("http://192.168.1.192:8000", <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false,
  });
  final List<SalesData> listtemp = [];
  final List<SalesData> listbatt = [];
  List<SalesData> listhum = [];
  dynamic updateiot;
  List<String> Day = [];
  List Data = [];
  List test = [];
  List Device = [];
  bool _justfirst = false;
  int check = 0;
  var messagedayandmac;
  @override
  void initState() {
    // getmacdeive();
    addlistday();
    Sock();

    addlisttemp();
    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
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
      'mac': 'AC233FA2148E'
    };
  }

  // void getmacdeive() async {
  //   var res = await http.get(Uri.parse('http://192.168.1.192:3000/iot/device'));
  //   if (res.statusCode == 200) {
  //     var jsonData = jsonDecode(res.body);

  //     setState(() {
  //       Device = jsonData;
  //     });
  //   }
  // }

  void Sock() async {
    // MessageModel messageModel = MessageModel(sourceId: widget.sourceChat.id.toString(),targetId: );
    socket.connect();
    // if (socket.connected == true) {
    //   socket.disconnect();
    //   socket.connect();
    // } else {
    //   socket.connect();
    // }

    // socket.disconnect();
  }

  Future connectsocket() async {
    // socket.onConnect((data) {
    //   print("Connected");
    // });
    socket.emit('reqiotnow', '');
    socket.on("message", (msg) {
      print(msg);

      updateiot = {
        'temp': msg[0]["temperature"],
        'batt': msg[0]["battery"],
        'hum': msg[0]["humidity"]
      };

      if (this.mounted) {
        setState(() {});
      }

      // for (int a = 0; a < Day.length; a++) {
      //   var message = {'day': Day[a], 'mac': 'AC233FA2148E'};
      //   socket.emit('day', message);
      // }
      // socket.on('data', (data) => {Data.add(data), setState(() {})});
    });
    return updateiot;
  }

  addlisttemp() async {
    print(_justfirst);
    if (_justfirst == false) {
      List Dayshow = [];
      Data = ['', '', '', '', '', '', ''];
      var list;
      String? splitdt;
      String? convertstringtemp;
      String? convertstringbat;
      String? convertstringhum;
      var temp;
      var batt;
      var hum;
      socket.emit('Temp', messagedayandmac);
      socket.on(
          'restemp',
          (data) => {
                print(data),
                list = data[0]['dt_create'].split(' '),
                splitdt = list[0],
                if (splitdt == Day[0])
                  {Data[0] = data[0]}
                else if (splitdt == Day[1])
                  {Data[1] = data[0]}
                else if (splitdt == Day[2])
                  {Data[2] = data[0]}
                else if (splitdt == Day[3])
                  {Data[3] = data[0]}
                else if (splitdt == Day[4])
                  {Data[4] = data[0]}
                else if (splitdt == Day[5])
                  {Data[5] = data[0]}
                else if (splitdt == Day[6])
                  {Data[6] = data[0]},
                for (int a = 0; a < Data.length; a++)
                  {
                    if (Data[a] != '')
                      {
                        convertstringtemp =
                            Data[a]['AVG(temperature)'].toStringAsFixed(2),
                        temp = double.parse(convertstringtemp!),
                        convertstringbat =
                            Data[a]['AVG(battery)'].toStringAsFixed(2),
                        batt = double.parse(convertstringbat!),
                        convertstringhum =
                            Data[a]['AVG(humidity)'].toStringAsFixed(2),
                        hum = double.parse(convertstringhum!),
                        print(
                            'temp == $temp ,baat == $batt , humidity == $hum '),
                        listtemp.add(SalesData(Day[a], temp)),
                        listbatt.add(SalesData(Day[a], batt)),
                        listhum.add(SalesData(Day[a], hum)),
                      }
                  },
                print('data >>>> ${Data.length}'),
                _justfirst = true,
                if (this.mounted) {setState(() {})}
              });
    }
    print('num ==== $check');
  }

  charttemp() {
    return listtemp;
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
              Container(
                height: 100,
                child: Expanded(
                  child: ListView.builder(
                      itemCount: Device.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: const Icon(
                            Icons.devices,
                          ),
                          title: Text(Device[index]['mac']),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        );
                      }),
                ),
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
                  const Text("รหัสอุปกรณ์:xxxxxxxxxxxxxx"),
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
                                    updateiot['temp'].toString()),
                                center:
                                    Text(updateiot['temp'].toString() + '°C'),
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
                                    updateiot['batt'].toString()),
                                center:
                                    Text(updateiot['batt'].toString() + '%'),
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
                                percent:
                                    textforpercent(updateiot['hum'].toString()),
                                center: Text(updateiot['hum'].toString() + '%'),
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
