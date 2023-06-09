import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miniprojeto/code/search.dart';
import 'dart:convert';
import 'description.dart';

enum TableStatus{idle, loading, ready, error}
class DataService {
  final ValueNotifier<Map<String,dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': null
  });

  void carregar(index) {
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': null
    };
    carregarBooks();
  }

  void carregarBooks() async {
    var booksUri = Uri(
      scheme: 'https',
      host: 'www.googleapis.com',
      path: '/books/v1/volumes',
      queryParameters: {'q': 'romance+terms'}); 

      http.read(booksUri).then((jsonString) {
      var booksJson = jsonDecode(jsonString);
      tableStateNotifier.value = {
        'status': TableStatus.ready,
        'dataObjects': booksJson
      };
    }).catchError((error) {
      tableStateNotifier.value = {
        'status': TableStatus.error,
        'dataObjects': [],
      };
    });
  }
}
final dataService = DataService();

class BookStoreHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(206, 252, 252, 1.0),
      body: ValueListenableBuilder(
        valueListenable: dataService.tableStateNotifier,
        builder: (_, value, __) {
          switch (value['status']) {
            case TableStatus.idle:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      "Clique em um dos botões abaixo para visualizar informações",
                      style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              );
            case TableStatus.loading:
              return Center(child: CircularProgressIndicator());
            case TableStatus.ready:
              return ContainerBooks(jsonObjects: value['dataObjects']['items']);
            case TableStatus.error:
              return Center(
                child: Text(
                  "Um erro ocorreu ao carregar os dados. Por favor verifique sua conexão de internet e tente novamente.",
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

class ContainerBooks extends StatelessWidget {
  final dynamic jsonObjects;

  ContainerBooks({
    required this.jsonObjects
  });

  @override
  Widget build(BuildContext context) {
    return Container (
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.75,
          ),
          itemCount: jsonObjects.length,
          itemBuilder: (context, index) {
            final book = jsonObjects[index];
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DescriptionBookPage(book: book),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: thumbnail,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
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
        ),
      );
  }
}


