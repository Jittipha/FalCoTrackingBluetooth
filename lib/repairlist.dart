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
    return Column(
      children: [
        Scaffold(
           backgroundColor: Colors.lightBlue[100],
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 18, 95, 116),
                title:  const Center(
                  child:Text(
                    "ประวัติการซ่อม",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
        ),
   body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                children: widgets
                    .map((k, v) {
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
                    })
                    .values
                    .toList()
                ),
          ),
        ),
      ],
    );
  }
}