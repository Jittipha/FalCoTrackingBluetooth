import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:trackingbluetooth/model/track.dart';

class RepairList extends StatefulWidget {
  const RepairList({Key? key}) : super(key: key);

  @override
  State<RepairList> createState() => _RepairListState();
}

class _RepairListState extends State<RepairList> {
  bool asTabs = false;
  Track track = Track();
  DateTime? dateTime;
  DateTime date = DateTime(2022, 01, 01);
  String? selectedValueSingleDialog;
  List<DropdownMenuItem<String>> test = [];
  List h = ['nanine', 'nanon', 'nagarn', 'nanick', 'nahee'];
  String dropdownValue = 'One';

  String getTextDate() {
    if (track.Start_Enable_Date == null) {
      return "Select Date";
    } else {
      return track.Start_Enable_Date!;
    }
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: dateTime ?? initialDate,
      firstDate: DateTime(2000),
      // firstDate: DateTime.utc(yyyy, mm, dd),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;
    String stDate = DateFormat('dd/MM/yyyy').format(newDate);

    setState(() {
      track.Start_Enable_Date = stDate;
    });
  }

  @override
  void initState() {
    String wordPair = "";
    h.forEach((element) {
      test.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    Map<String, Widget> widgets;
    widgets = {
      "เครื่องที่ต้องการแจ้งซ่อม": SearchChoices.single(
        items: test,
        value: selectedValueSingleDialog,
        hint: "เลือกเครื่องที่ต้องการซ่อม",
        searchHint: "เลือกเครื่อง",
        onChanged: (value) {
          setState(() {
            selectedValueSingleDialog = value;
          });
        },
        isExpanded: true,
      ),
    };
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 95, 116),
        title: const Center(
          child: Text(
            "ประวัติการซ่อม",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Column(
              children: widgets
                  .map(
                    (k, v) {
                      return (MapEntry(
                          k,
                          Center(
                              child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 26, 1, 1),
                                width: 1.0,
                              ),
                            ),
                            margin: const EdgeInsets.all(20),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: <Widget>[
                                  Text("$k:"),
                                  v,
                                ],
                              ),
                            ),
                          ))));
                    },
                  )
                  .values
                  .toList(),
            ),
            SizedBox(height: 50,),
            Container(
             padding: EdgeInsets.fromLTRB(600, 0, 0, 0),

              child: Row(
                children: [
                  Row(
                    children: [
                      Container(
                        
                        // alignment: Alignment.centerRight,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Center(
                          
                          child: DropdownButton<String>(
                            
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 13, 13, 13)),
                            // underline: Container(
                            //   height: 2,
                            //   // width: 100,
                            //   color: const Color.fromARGB(255, 13, 13, 13),
                            // ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['One', 'Two', 'Free', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Padding(padding: EdgeInsets.all(16.16)),
                        Container(
                          width: 200,
                          child: Expanded(
                            flex: 1,
                            child: ElevatedButton.icon(
                              onPressed: () => pickDate(context),
                              label: Text(
                                getTextDate(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  primary: const Color.fromARGB(255, 250, 248, 248),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              icon: const Icon(
                                Icons.calendar_month_rounded,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                       
                      ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
