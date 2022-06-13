import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:search_choices/search_choices.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  static final navKey = new GlobalKey<NavigatorState>();

  const MyApp({Key? navKey}) : super(key: navKey);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  @override
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
    );
  }
}
