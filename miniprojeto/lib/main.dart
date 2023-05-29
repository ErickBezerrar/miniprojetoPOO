import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'code/homePage.dart';
import 'code/newAccount.dart';
import 'code/descripition.dart';
import 'code/cartPage.dart';

void main() => runApp(MyApp());



void main() {
  runApp(MyApp());
}
>>>>>>> 0d3defc01eb84a8e364bb6acd579916354b37169

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
<<<<<<< HEAD
    BookStoreHomePage(), // Tela da página inicial
    CartPageContent(), // Tela do carrinho de compras
=======
    HomePageContent(),
    CartPageContent(),
>>>>>>> 0d3defc01eb84a8e364bb6acd579916354b37169
    MyForm(), // Tela do formulário
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(149, 206, 207, 1.0),
<<<<<<< HEAD
        title: Text('BookStore'),
        leading: _currentIndex != 0
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            )
          : null,
=======
        title: Text('Menu Inicial'),
        leading: _currentIndex != 0
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              )
            : null,
>>>>>>> 0d3defc01eb84a8e364bb6acd579916354b37169
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
<<<<<<< HEAD
      ),
    );
  }
}

class CartPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(206, 252, 252, 1.0),
            Colors.white,
          ],
        ),
      ),
      child: Center(
        child: Text('Esta é a tela do carrinho de compras'),
=======
>>>>>>> 0d3defc01eb84a8e364bb6acd579916354b37169
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(206, 252, 252, 1.0),
            Colors.white,
          ],
        ),
      ),
      child: Center(
        child: Text('Conteúdo da Tela Principal'),
      ),
    );
  }
}

// class ProfilePageContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Color.fromRGBO(206, 252, 252, 1.0),
//             Colors.white,
//           ],
//         ),
//       ),
//       child: Center(
//         child: MyForm(),
//       ),
//     );
//   }
// }

class CartPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(206, 252, 252, 1.0),
            Colors.white,
          ],
        ),
      ),
      child: Center(
        child: Text('Esta é a tela do carrinho de compras'),
      ),
    );
  }
}