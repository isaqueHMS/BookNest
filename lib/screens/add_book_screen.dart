import 'package:flutter/material.dart';

class AddBookScreen extends StatelessWidget {
  final Function(String) onAddBook;

  AddBookScreen({required this.onAddBook});

  final TextEditingController _bookController = TextEditingController();

  void _submit(BuildContext context) {
    final bookTitle = _bookController.text;
    if (bookTitle.isNotEmpty) {
      onAddBook(bookTitle);
      Navigator.pop(context);
    } else {
      // Exibe um erro se o título estiver vazio
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('O título do livro não pode estar vazio.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Livro')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _bookController,
              decoration: InputDecoration(labelText: 'Título do Livro'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _submit(context),
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
