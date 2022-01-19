import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final Function(String value, String searchType) onSearch;

  const SearchWidget({Key key, this.onSearch}) : super(key: key);
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String typeOfSearch;
  String query = '';
  TextEditingController _controller = TextEditingController();
  List searchOptions = [
    {'title': 'Oficial name', 'value': 'name'},
    {'title': 'Capital', 'value': 'capital'},
    {'title': 'Region', 'value': 'region'},
    {'title': 'Population', 'value': 'population'},
  ];

  @override
  void initState() {
    super.initState();

    setState(() {
      typeOfSearch = searchOptions[0]['value'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    controller: _controller,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: InputDecoration(
                      hintText: searchOptions.where((element) => element['value'] == typeOfSearch).first['title'],
                      hintStyle: TextStyle(color: Colors.black45),
                      helperStyle: TextStyle(color: Colors.black45),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 15, top: 15, right: 15),
                      suffixIcon: Visibility(
                        visible: query != '',
                        child: IconButton(onPressed: (){
                          setState(() {
                            widget.onSearch(null, null);
                            _controller.text = '';
                            query = '';
                          });
                        }, icon: Icon(Icons.cancel_rounded)),
                      )
                    ),
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                height: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Theme.of(context).colorScheme.primary),
                  child: Icon(Icons.search),
                  onPressed: () {
                    widget.onSearch(query, typeOfSearch);
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: DropdownButton(
            style: Theme.of(context).textTheme.bodyText2,
            isDense: true,
            value: typeOfSearch,
            items: searchOptions.map((type) => DropdownMenuItem(child: Text(type['title']), value: type['value'])).toList(),
            onChanged: (value) {
              setState(() {
                typeOfSearch = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
