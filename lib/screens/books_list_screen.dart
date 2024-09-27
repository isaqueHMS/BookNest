import 'package:flutter/material.dart';

class BooksListScreen extends StatelessWidget {
  final List<String> books;

  BooksListScreen({required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Livros Cadastrados'),
      ),
      body: books.isEmpty
          ? Center(child: Text('Nenhum livro cadastrado.'))
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(books[index]),
                );
              },
            ),
    );
  }
}
