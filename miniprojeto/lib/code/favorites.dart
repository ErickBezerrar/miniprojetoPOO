import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'description.dart';
import 'globals.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(206, 252, 252, 1.0),
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Color.fromRGBO(149, 206, 207, 1.0),
        title: Text('Favorites', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: favoriteBooks.isNotEmpty
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: favoriteBooks.length,
              itemBuilder: (context, index) {
                final book = favoriteBooks[index];
                final title = book['volumeInfo']['title'];
                final thumbnail = book['volumeInfo']['imageLinks'] != null
                    ? book['volumeInfo']['imageLinks']['thumbnail']
                    : 'https://via.placeholder.com/150';

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Navegar para a página de descrição do livro
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            thumbnail,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                "Nenhum livro favorito.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
