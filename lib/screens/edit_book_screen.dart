import 'package:flutter/material.dart';

class EditBookScreen extends StatefulWidget {
  final String currentTitle;
  final Function(String) onEditBook;

  EditBookScreen({required this.currentTitle, required this.onEditBook});

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  late TextEditingController _bookController;

  @override
  void initState() {
    super.initState();
    _bookController = TextEditingController(text: widget.currentTitle);
  }

  void _submit() {
    final newTitle = _bookController.text;
    if (newTitle.isNotEmpty) {
      widget.onEditBook(newTitle); // Edita o livro na lista
      Navigator.pop(context); // Volta para a tela anterior
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
      appBar: AppBar(title: Text('Editar Livro')),
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
              onPressed: _submit,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
