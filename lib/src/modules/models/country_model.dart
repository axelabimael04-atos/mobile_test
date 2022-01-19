

class Country {
  String name;
  String capital;
  String region;
  Coords latlng;
  Maps maps;
  int population;
  String flags;

  Country({
    this.name,
    this.capital,
    this.region,
    this.latlng,
    this.maps,
    this.population,
    this.flags,
  });

  factory Country.fromJson(Map<String, dynamic> country){

    return Country(
      name: country['name']['common'],
      capital: country["capital"] != null ? country["capital"][0] : '',
      region: country["region"],
      latlng: Coords.fromJson(country["latlng"]),
      maps: Maps.fromJson(country['maps']),
      population: country["population"],
      flags: country['flags']['png'],
    );
  }
}

class Maps {
  String googleMaps;
  String openStreetMaps;

  Maps({
    this.googleMaps,
    this.openStreetMaps,
  });

  factory Maps.fromJson(Map<String, dynamic> maps) => Maps(
    googleMaps: maps['googleMaps'],
    openStreetMaps: maps['openStreetMaps']
  );
}

class Coords {
  double lat;
  double lon;

  Coords({
    this.lat,
    this.lon,
  });

  factory Coords.fromJson(List coords) =>Coords(
    lat: coords[0],
    lon: coords[1]
  );
}
