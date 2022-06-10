

// ignore_for_file: non_constant_identifier_names

class Track {
  String? Track_ID;
  String? Brand;
  String? Generation;
  String? Menufacturer;
  String? Size;
  int? Age_of_use;
  String? Location;
  String? Work_for;
  String? Start_Enable_Date;
  String? Last_Improve_Date;
  int? Count_Improve;
  String? End_Date;
  String? Note;
  String? Working_Condition;
  String? Status;

  Track(
      {this.Track_ID,
      this.Brand,
      this.Generation,
      this.Menufacturer,
      this.Size,
      this.Age_of_use,
      this.Location,
      this.Work_for,
      this.Start_Enable_Date,
      this.Last_Improve_Date,
      this.Count_Improve,
      this.End_Date,
      this.Note,
      this.Working_Condition,
      this.Status});
  Track.fromSnapshot(result) {
    Track_ID = result['Track_ID'];
  }
}
