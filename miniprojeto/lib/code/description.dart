import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'homePage.dart';

class DescriptionBookPage extends StatefulWidget {
  final Map<String, dynamic> book;

  DescriptionBookPage({required this.book});

  @override
  _DescriptionBookState createState() => _DescriptionBookState();
}

class _DescriptionBookState extends State<DescriptionBookPage> {
  List<dynamic> books = [];
  bool isBookFavorited =
      false; // Estado feito para controlar se o livro está favoritado ou não

  Future<void> fetchBooks() async {
    setState(() {
      books = [widget.book]; // Passando apenas o livro como parâmetro
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  void toggleFavorite() {
    setState(() {
      isBookFavorited = !isBookFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Para retornar à página anterior
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isBookFavorited ? Icons.star : Icons.star_border,
              color: isBookFavorited ? Colors.yellow : null,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade200, Colors.white],
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: 800,
            padding: EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 100.0,
                mainAxisSpacing: 30.0,
                childAspectRatio: 0.75,
              ),
              itemCount: 1,
              itemBuilder: (context, index) {
                final book = widget.book;
                final title = book['volumeInfo']['title'];
                final authors = book['volumeInfo']['authors'] != null
                    ? book['volumeInfo']['authors'].join(', ')
                    : 'Unknown';
                final thumbnail = book['volumeInfo']['imageLinks'] != null
                    ? book['volumeInfo']['imageLinks']['thumbnail']
                    : 'https://via.placeholder.com/150';
                final categories = book['volumeInfo']['categories'];
                final pageCount = book['volumeInfo']['pageCount'];
                final language = book['volumeInfo']['language'];
                final searchInfo = book['volumeInfo']['searchInfo'];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(authors),
                      ),
                      SizedBox(height: 8.0),
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: thumbnail,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: searchInfo != null
                            ? Text(searchInfo)
                            : Text('No search information available'),
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        padding: EdgeInsets.all(12.0),
                        color: Colors.blue.shade200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Category: $categories',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Pages: $pageCount',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Language: $language',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 35),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(200, 66)),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.pink),
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                  TextStyle(
                                      fontSize: 12.0,
                                      fontStyle: FontStyle.italic)),
                            ),
                            onPressed: () {
                              // Ação do botão "Buy now for $19.00"
                            },
                            child: Text("Buy now for 19.00 dollars"),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
