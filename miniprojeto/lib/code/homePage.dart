import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';

class BookStoreHomePage extends StatefulWidget {
  @override
  _BookStoreHomePageState createState() => _BookStoreHomePageState();
}

class _BookStoreHomePageState extends State<BookStoreHomePage> {
  List<dynamic> books = [];

  Future<void> fetchBooks() async {
    final response = await http.get(Uri.https(
      'www.googleapis.com',
      '/books/v1/volumes',
      {'q': 'romance',
      'key': 'AIzaSyA5jvZzwUztQ4NT1c7YicLnOKTcUFQmutA'}
    ));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        books = data['items'];
      });
    } else {
      print('Failed to fetch books');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade200, Colors.white],
          ),
        ),
        child: GridView.builder(
          padding: EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.75,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            final title = book['volumeInfo']['title'];
            final authors = book['volumeInfo']['authors'] != null
                ? book['volumeInfo']['authors'].join(', ')
                : 'Unknown';
            final thumbnail = book['volumeInfo']['imageLinks'] != null
                ? book['volumeInfo']['imageLinks']['thumbnail']
                : 'https://via.placeholder.com/150';

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(thumbnail,
                      fit: BoxFit.cover)
                      // imageUrl: thumbnail,
                      // fit: BoxFit.cover,
                      // placeholder: (context, url) =>
                      //     CircularProgressIndicator(),
                      // errorWidget: (context, url, error) => Icon(Icons.error),
                    // ),
                  ),
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}