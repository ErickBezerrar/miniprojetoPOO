import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'homePage.dart';
import 'description.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  void search(BuildContext context) {
    final String searchTerm = _searchController.text.trim();
    if (searchTerm.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultPage(searchTerm: searchTerm),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(149, 206, 207, 1.0),
        title: Text(
          'Search book',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Color.fromRGBO(206, 252, 252, 1.0),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Write the title of the book',
              ),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(315, 66)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic)),
                  ),
                  onPressed: () => search(context),
                  child: Text('Search'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchResultPage extends StatefulWidget {
  final String searchTerm;

  SearchResultPage({required this.searchTerm});

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  TableStatus status = TableStatus.loading;
  List<dynamic> dataObjects = [];

  @override
  void initState() {
    super.initState();
    carregarBooks();
  }

  void carregarBooks() async {
    var booksUri = Uri(
      scheme: 'https',
      host: 'www.googleapis.com',
      path: '/books/v1/volumes',
      queryParameters: {'q': widget.searchTerm},
    );

    http.read(booksUri).then((jsonString) {
      var booksJson = jsonDecode(jsonString);
      setState(() {
        status = TableStatus.ready;
        dataObjects = booksJson['items'];
      });
    }).catchError((error) {
      setState(() {
        status = TableStatus.error;
        dataObjects = [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(149, 206, 207, 1.0),
        title: Text(
          'Search book',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Color.fromRGBO(206, 252, 252, 1.0),
      body: ValueListenableBuilder(
        valueListenable: dataService.tableStateNotifier,
        builder: (_, value, __) {
          switch (status) {
            case TableStatus.loading:
              return Center(child: CircularProgressIndicator());
            case TableStatus.ready:
              return ContainerBooks(jsonObjects: dataObjects);
            case TableStatus.error:
              return Center(
                child: Text(
                  "An error occurred while loading the data. Please check your internet connection and try again.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              return Text("...");
          }
        },
      ),
    );
  }
}
