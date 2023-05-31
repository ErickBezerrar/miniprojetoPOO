import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoritesBooksPage extends StatefulWidget {
  @override
  _FavoritesBooksPageState createState() => _FavoritesBooksPageState();
}

class _FavoritesBooksPageState extends State<FavoritesBooksPage> {
  List<dynamic> books = [];
  // change([], status: RxStatus.loading());

  Future<void> fetchBooks() async {
    final response = await http.get(Uri.https(
      'www.googleapis.com',
      '/books/v1/volumes',
      {'q': 'romance+terms',
      'key': 'AIzaSyA5jvZzwUztQ4NT1c7YicLnOKTcUFQmutA'}
    ));

    // try {
    //   if (response.statusCode == 200) {
    //     final data = jsonDecode(response.body);
    //     setState(() {
    //       books = data['items'];
    //     });
    //     change(dados, status: RxStatus.success());
    //   }
    // } catch (e) {
    //   change([], status: RxStatus.error('Erro ao buscar usuários'));
    // }

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        books = data['items'];
      });
    } else {
        print("Erro to fetch books");
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
      backgroundColor: Color.fromRGBO(206, 252, 252, 1.0),
      body: Container(
        child: GridView.builder(
          padding: EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
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
                    child: CachedNetworkImage(
                      imageUrl: thumbnail,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                        CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
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