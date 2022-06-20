import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1.3,
            child: Row(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                   
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 45,
                      lineWidth: 30.0,
                      percent: 0.10,
                      center: const Text("10%"),
                      progressColor: Colors.red,
                      animation: true,
                      animationDuration: 900,
                    ),
                    
                    const SizedBox(
                      height: 20,
                      width: 30,
                    ),
                   
                     CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 30.0,
                      percent: 0.30,
                      center:  const Text("30%"),
                      progressColor: Colors.orange,
                      animation: true,
                      animationDuration: 900,
                    ),
                      const SizedBox(
                      height: 20,
                      width: 30,
                    ),
                    CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 30.0,
                      percent: 0.60,
                      center: const Text("60%"),
                      progressColor: Colors.yellow,
                      animation: true,
                      animationDuration: 900,
                    ),
                      const SizedBox(
                      height: 20,
                      width: 30,
                    ),
                    CircularPercentIndicator(
                      radius: 45.0,
                      lineWidth: 30.0,
                      percent: 0.50,
                      center: const Text("50%"),
                      progressColor: Colors.green,
                      animation: true,
                      animationDuration: 900,
                    )
                  ],
                ),
                  const SizedBox(
                      height: 20,
                      width: 30,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
