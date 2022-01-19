import 'dart:convert';
import 'package:http/http.dart';
import 'package:mobile_test/src/modules/models/country_deails.dart';
import 'package:mobile_test/src/modules/models/country_model.dart';

class DataService {
  
  Future<CountryDetails> countryDetails(String country)  async {
    try {
      Response resp = await get(
        Uri.parse(
            'https://en.wikipedia.org/api/rest_v1/page/summary/$country'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if ((resp.statusCode == 200 || resp.statusCode == 201)) {
        return CountryDetails.fromJson(jsonDecode(resp.body));
      } else {
        return null;
      }
    } 
    catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Country>> chargeAllCountries() async {
    try {
      Response resp = await get(
        Uri.parse(
            'https://restcountries.com/v3.1/all'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if ((resp.statusCode == 200 || resp.statusCode == 201)) {
        List<Country> countries = [];
        jsonDecode(resp.body).forEach((country)=> countries.add(Country.fromJson(country)));
        countries.sort((a, b) => a.name.compareTo(b.name));
        return countries;
      } else {
        return [];
      }
    } 
    catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Country>> customQuery(String value, String searchType) async {
    try {
      Response resp = await get(
        Uri.parse(
            'https://restcountries.com/v3.1/all'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if ((resp.statusCode == 200 || resp.statusCode == 201)) {
        List<Country> countries = [];
        jsonDecode(resp.body).forEach((country)=> countries.add(Country.fromJson(country)));
        countries.sort((a, b) => a.name.compareTo(b.name));
        countries = countries.where((element){
          switch (searchType) {
            case 'name':
              return element.name.toLowerCase().startsWith(value);
              break;
            case 'capital':
              return element.capital.toLowerCase().startsWith(value);
              break;
            case 'region':
              return element.region.toLowerCase().startsWith(value);
              break;
            case 'population':
              return element.population.toString().startsWith(value);
              break;
            default:
            return element.name.toLowerCase().startsWith(value);
          }
        }).toList(growable: false)
                    ..sort((a, b)=> a.name.compareTo(b.name));
        return countries;
      } else {
        return [];
      }
    } 
    catch (e) {
      print(e);
      return [];
    }
  }
}