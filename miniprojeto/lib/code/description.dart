import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'homePage.dart';
import 'favorites.dart';
import 'globals.dart';

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

  final FavoritesPage favoritesPage = FavoritesPage();

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
        if (favoriteBooks.contains(widget.book)) {
          favoriteBooks.remove(widget.book);
          isBookFavorited = false;
        } else {
          favoriteBooks.add(widget.book);
          isBookFavorited = true;
        }
      });
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(206, 252, 252, 1.0),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Color.fromRGBO(149, 206, 207, 1.0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Para retornar à página anterior
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isBookFavorited ? Icons.favorite : Icons.favorite,
              color: isBookFavorited ? Colors.pink : null,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: Container(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: 800,
            padding: EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
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
                final categories = book['volumeInfo']['categories'] != null
                    ? book['volumeInfo']['categories'][0]
                    : 'Unknown';
                final pageCount = book['volumeInfo']['pageCount'];
                final language = book['volumeInfo']['language'];
                final description = book['volumeInfo']['description'] != null
                    ? book['volumeInfo']['description'] 
                    : 'Unknown';

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 8.0),
                      Column(
                        children: [
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
                      ]),                   
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
                      SizedBox(height: 15.0),
                      Container(
                        width: 450,
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(206, 252, 252, 1.0).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Category: $categories',
                              style: TextStyle(fontWeight: FontWeight.bold,),
                            ),
                            Text(
                              'Pages: $pageCount',
                              style: TextStyle(fontWeight: FontWeight.bold,),
                            ),
                            Text(
                              'Language: $language',
                              style: TextStyle(fontWeight: FontWeight.bold,),
                            ),
                          ],
                        ),                                                  
                      ),   
                      SizedBox(height: 15.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Description: $description',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),                  
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
