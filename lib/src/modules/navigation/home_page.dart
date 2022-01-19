import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_test/src/modules/data_services/data_service.dart';
import 'package:mobile_test/src/modules/models/country_model.dart';
import 'package:mobile_test/src/modules/navigation/country_details/country_details_page.dart';
import 'package:mobile_test/src/modules/navigation/drawer.dart';
import 'package:mobile_test/src/widgets/search_widget.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _rowsPerPage = 10;

  Future<List<Country>> setQuery([String value, String searchType]) async{
    if(value !=null && searchType != null){
      return DataService().customQuery(value, searchType);
    } else {
      return DataService().chargeAllCountries();
    }
  }

  Future<List<Country>> query;

  @override
  void initState() {
    super.initState();

    setState(() {
      query = setQuery();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Atos'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SearchWidget(
                onSearch: (value, searchType){
                  setState(() {
                    query = setQuery(value, searchType);
                  });
                },
              ),
              FutureBuilder(
                future: query,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data.length == 0) return Container(
                    width: double.infinity,
                    height: 616,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 15,),
                        Text('Cargando', style: Theme.of(context).textTheme.subtitle1,)
                      ],
                    ),
                  );

                  List<Country> countries = snapshot.data;

                  return PaginatedDataTable(
                    columns: [
                      DataColumn(label: Text('Oficial name')),
                      DataColumn(label: Text('Capital')),
                      DataColumn(label: Text('Region')),
                      DataColumn(label: Text('Population')),
                      DataColumn(label: Text('Flag')),
                    ],
                    source: _CountriesDTS(context,
                    countries: countries,
                        dataCells: (index) => [
                              DataCell(Text(countries[index].name)),
                              DataCell(Text(countries[index].capital)),
                              DataCell(Text(countries[index].region)),
                              DataCell(Text('${countries[index].population}')),
                              DataCell(
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  width: 100,
                                  child: CachedNetworkImage(
                                    imageUrl: countries[index].flags,))),
                            ]),
                    onRowsPerPageChanged: (value) {
                      setState(() {
                        _rowsPerPage = value ?? 10;
                      });
                    },
                    rowsPerPage: _rowsPerPage,
                    showCheckboxColumn: false,
                    onSelectAll: null,
                    availableRowsPerPage: [5,10,20,50,100],
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }

  
}

class _CountriesDTS extends DataTableSource {
  final List<DataCell> Function(int index) dataCells;
  final BuildContext context;
  final List<Country> countries;

  _CountriesDTS(this.context, {@required this.countries, @required this.dataCells});

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
        index: index,
        cells: dataCells(index),
        onSelectChanged: (value){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>CountryDetailsPage(
            country: countries[index].name,
          )));
        }
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => countries.length;

  @override
  int get selectedRowCount => 0;
}