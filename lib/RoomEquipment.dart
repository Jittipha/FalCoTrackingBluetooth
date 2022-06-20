import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:trackingbluetooth/chart2.dart';
import 'package:trackingbluetooth/saveformrepair.dart';

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PieChartSample2()),
                  );
                }),
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
          child: Column(
            children: [
              // PieChartSample(),
              // Row(children: [
              //   Container(
              //     width: 300,
              //     height: 300,
              //     color: Colors.red,
              //   ),
              //   Container(
              //     width: 200,
              //     height: 300,
              //     color: Colors.yellow,
              //   )
              // ]),
            ],
          ),
        ),
      ),
    );
  }
}

// class PieChartSample extends StatefulWidget {
//   const PieChartSample({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => PieChart2State();
// }

// class PieChart2State extends State {
 

//   @override
//   Widget build(BuildContext context) {
//     return Container(
   
      
//       child: Row(
//         children: [
//           AspectRatio(
//             aspectRatio: 1.3,
//             child: Row(
//               children: <Widget>[
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.start,
                   
//                   children: <Widget>[
//                     CircularPercentIndicator(
//                       radius: 45,
//                       lineWidth: 4.0,
//                       percent: 0.30,
//                       center: const Text("10%"),
//                       progressColor: Colors.red,
//                       animation: true,
//                       animationDuration: 900,
//                     ),
//                     // new Padding(
//                     //   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                     // ),
//                     const SizedBox(
//                       height: 4,
//                     ),
//                     // new Padding(
//                     //       padding: EdgeInsets.symmetric(horizontal: 10.0),
//                     //     ),
//                      CircularPercentIndicator(
//                       radius: 45.0,
//                       lineWidth: 4.0,
//                       percent: 0.30,
//                       center:  const Text("30%"),
//                       progressColor: Colors.orange,
//                       animation: true,
//                       animationDuration: 900,
//                     ),
//                     // new Padding(
//                     //   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                     // ),
//                     CircularPercentIndicator(
//                       radius: 45.0,
//                       lineWidth: 4.0,
//                       percent: 0.60,
//                       center: const Text("60%"),
//                       progressColor: Colors.yellow,
//                       animation: true,
//                       animationDuration: 900,
//                     ),
//                     // new Padding(
//                     //   padding: EdgeInsets.symmetric(horizontal: 10.0),
//                     // ),
//                     CircularPercentIndicator(
//                       radius: 45.0,
//                       lineWidth: 4.0,
//                       percent: 0.90,
//                       center: const Text("90%"),
//                       progressColor: Colors.green,
//                       animation: true,
//                       animationDuration: 900,
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   width: 28,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

