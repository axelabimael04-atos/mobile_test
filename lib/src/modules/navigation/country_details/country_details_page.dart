import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_test/src/modules/data_services/data_service.dart';
import 'package:mobile_test/src/modules/models/country_deails.dart';
import 'package:mobile_test/src/modules/navigation/country_details/maps_location_page.dart';

class CountryDetailsPage extends StatelessWidget {

  final String country;

  const CountryDetailsPage({Key key, @required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DataService().countryDetails(this.country),
      builder: (context, snapshot) {
        if(!snapshot.hasData || snapshot.data == null) return Scaffold();
        CountryDetails details = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            title: Text(country),
          ),
          body: Column(
            children: [
              AspectRatio(
                aspectRatio: 16/9,
                child: CachedNetworkImage(
                    imageUrl: details.originalimage,
                    fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(details.title, style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Colors.black
                    ),),
                    Text(details.description, style: Theme.of(context).textTheme.subtitle1,),
                    SizedBox(height: 15,),
                    Text(details.extract)
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: details.coordinates != null
          ? FloatingActionButton.extended(
            label: Text('Go to Maps'),
            icon: Icon(Icons.map_sharp),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> MapsLocationPage(
                coords: details.coordinates,
                countryName: details.title,
              )));
          }) : null,
        );
      }
    );
  }

  
}