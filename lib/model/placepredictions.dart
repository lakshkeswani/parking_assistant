class PlacePredictions {
  String secondary_test;
  String main_text;
  String place_id;

  PlacePredictions({this.secondary_test, this.main_text, this.place_id});

  PlacePredictions.fromJson(Map<String, dynamic> json) {
    place_id = json["place_id"];
  }
}
