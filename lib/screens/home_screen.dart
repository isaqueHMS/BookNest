import 'package:flutter/material.dart';
import 'add_book_screen.dart'; // Tela para adicionar um livro
import 'edit_book_screen.dart'; // Tela para editar um livro
import 'books_list_screen.dart'; // Tela para listar livros cadastrados

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _books = []; // Lista de livros

  @override
  void initState() {
    super.initState();
    _loadBooks(); // Carrega os livros ao iniciar a tela
  }

  Future<void> _loadBooks() async {
    // Aqui você pode carregar os livros da memória ou de um banco de dados
    setState(() {
      _books = []; // Inicializa a lista de livros
    });
  }

  void _addBook(String book) {
    setState(() {
      _books.add(book);
    });
    _showSnackBar('Livro adicionado!');
  }

  void _editBook(String newTitle, int index) {
    setState(() {
      _books[index] = newTitle;
    });
    _showSnackBar('Livro editado!');
  }

  void _deleteBook(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar Exclusão'),
          content: Text('Você tem certeza que deseja excluir este livro?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _books.removeAt(index);
                });
                _showSnackBar('Livro excluído!');
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Biblioteca'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Campo de pesquisa
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Pesquisar Livros',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Aqui você pode implementar a lógica de busca
              },
            ),
          ),
          Expanded(
            child: _books.isEmpty
                ? Center(child: Text('Nenhum livro cadastrado.'))
                : ListView.builder(
                    itemCount: _books.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(_books[index]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditBookScreen(
                                        currentTitle: _books[index],
                                        onEditBook: (newTitle) => _editBook(newTitle, index),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _deleteBook(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBookScreen(onAddBook: _addBook),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Adicionar Livro',
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                print('Tela Principal pressionada!'); // Apenas para verificação
              },
              child: Text('Tela Principal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BooksListScreen(books: _books),
                  ),
                );
              },
              child: Text('Ver Livros Cadastrados'),
            ),
          ],
        ),
      ),
    );
  }
}
