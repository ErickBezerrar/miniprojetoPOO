import "package:flutter/material.dart";
import 'package:flutter_hooks/flutter_hooks.dart';

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
