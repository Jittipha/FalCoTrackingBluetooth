import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

class RepairList extends StatefulWidget {
  const RepairList({Key? key}) : super(key: key);

  @override
  State<RepairList> createState() => _RepairListState();
}

class _RepairListState extends State<RepairList> {
  bool asTabs = false;
  String? selectedValueSingleDialog;
  List<DropdownMenuItem<String>> test = [];
  List h = ['nanine', 'nanon', 'nagarn', 'nanick', 'nahee'];

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
    String dropdownvalue = 'Item 1';

    // List of items in our dropdown menu
    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];

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
                              side: BorderSide(
                                color: Color.fromARGB(255, 26, 1, 1),
                                width: 1.0,
                              ),
                            ),
                            margin: EdgeInsets.all(20),
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
            DropdownButton(
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
