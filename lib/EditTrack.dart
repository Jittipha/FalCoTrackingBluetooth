// ignore_for_file: file_names

import 'package:flutter/material.dart';

class EditTrack extends StatefulWidget {
  const EditTrack({Key? key}) : super(key: key);

  @override
  State<EditTrack> createState() => _EditTrackState();
}

class _EditTrackState extends State<EditTrack> {
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: const SingleChildScrollView());
  }
}
