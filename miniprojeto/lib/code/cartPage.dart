import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CartPageContent extends StatefulWidget {
  @override
  _CartPageContentState createState() => _CartPageContentState();
}

class _CartPageContentState extends State<CartPageContent> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2068AE),
            Color(0xFF4AADD6),
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: double.infinity,
                  height: 120, // Altura reduzida do container
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Nome do Livro',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'R\$ ${(29.90 * quantity).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: decrementQuantity,
                            icon: Icon(Icons.arrow_downward),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            onPressed: incrementQuantity,
                            icon: Icon(Icons.arrow_upward),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            // Delete product
                          });
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          // Containers adicionais na parte inferior
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(315, 66)),
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(218, 109, 143, 1.0)),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
                ),
              ),
              onPressed: () {
                // Ação do botão Fechar Pedido
              },
              child: Text("Fechar Pedido"),
            ),
          ),
          // Replicação de mais containers de produtos
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                height: 120, // Altura reduzida do container
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Nome do Livro',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'R\$ ${(29.90 * quantity).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: decrementQuantity,
                          icon: Icon(Icons.arrow_downward),
                        ),
                        Text(
                          quantity.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                          onPressed: incrementQuantity,
                          icon: Icon(Icons.arrow_upward),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          // Delete product
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: double.infinity,
                height: 120, // Altura reduzida do container
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Nome do Livro',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'R\$ ${(29.90 * quantity).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: decrementQuantity,
                          icon: Icon(Icons.arrow_downward),
                        ),
                        Text(
                          quantity.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                          onPressed: incrementQuantity,
                          icon: Icon(Icons.arrow_upward),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          // Delete product
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
