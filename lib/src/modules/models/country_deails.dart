// Generated by https://quicktype.io

class CountryDetails {
  String title;
  String thumbnail;
  String originalimage;
  String description;
  Coordinates coordinates;
  String extract;

  CountryDetails({
    this.title,
    this.thumbnail,
    this.originalimage,
    this.description,
    this.coordinates,
    this.extract,
  });

  factory CountryDetails.fromJson(Map<String, dynamic> details) =>CountryDetails(
    title: details['title'],
    thumbnail: details['thumbnail']['source'],
    originalimage: details['originalimage'] != null ? details['originalimage']['source'] : '',
    description: details['description'],
    coordinates: details['coordinates'] != null ? Coordinates.fromJson(details['coordinates']) : null,
    extract: details['extract']
  );
}

class Coordinates {
  double lat;
  double lon;

  Coordinates({
    this.lat,
    this.lon,
  });

  factory Coordinates.fromJson(Map<String, dynamic> coords) =>Coordinates(
    lat: double.parse(coords['lat'].toString()),
    lon: double.parse(coords['lon'].toString())
  );
}
