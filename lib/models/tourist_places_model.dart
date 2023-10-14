// ignore_for_file: public_member_api_docs, sort_constructors_first
class TouristPlacesModel {
  final String name;
  final String image;
  TouristPlacesModel({
    required this.name,
    required this.image,
  });
}

List<TouristPlacesModel> touristPlaces = [
  TouristPlacesModel(name: "Mountain", image: "images/icons/mountain.png"),
  TouristPlacesModel(name: "Beach", image: "images/icons/beach.png"),
  TouristPlacesModel(name: "Forest", image: "images/icons/forest.png"),
  TouristPlacesModel(name: "City", image: "images/icons/city.png"),
  TouristPlacesModel(name: "Desert", image: "images/icons/desert.png"),
];
