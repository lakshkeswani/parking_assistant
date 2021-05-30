class PlacePredictions {
  String secondary_text;
  String main_text;
  String place_id;

  PlacePredictions({this.secondary_text, this.main_text, this.place_id});

  PlacePredictions.fromJson(Map<String, dynamic> json) {
    secondary_text = json["structured_formatting"]["secondary_text"];
    place_id = json["structured_formatting"]["place_id"];
    main_text = json["structured_formatting"]["main_text"];
  }
}
