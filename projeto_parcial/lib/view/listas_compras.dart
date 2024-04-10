import 'package:flutter/material.dart';
import 'package:projeto_parcial/model/modelo_listas.dart';
import 'package:projeto_parcial/view/lista_itens.dart';

class Listas extends StatefulWidget {
  @override
  _ListasState createState() => _ListasState();
}

class _ListasState extends State<Listas> {
  final TextEditingController nome_lista = TextEditingController();
  List<ModeloListas> listasDeCompras = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 21, 21, 21),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 21, 21, 21),
        automaticallyImplyLeading: true, 
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.blue.shade900,
        ),
        title: Row(
          children: [
            Text(
              'Listas de Compras',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.shopping_cart,
              color: Colors.blue.shade900,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Color.fromARGB(255, 255, 255, 255),
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Criar Nova Lista',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      style: TextStyle(color: const Color.fromARGB(255, 21, 21, 21), fontSize: 25),
                      controller: nome_lista,
                      decoration: InputDecoration(
                        labelText: 'Nome da Lista',
                        labelStyle: TextStyle(color: const Color.fromARGB(255, 21, 21, 21), fontSize: 25),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 32, 4, 175),
                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () {
                        criarLista(nome_lista.text);
                      },
                      child: Text('Criar Lista'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Suas Listas:',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: listasDeCompras.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(listasDeCompras[index].nome),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            editarLista(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            excluirLista(index);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListaItens(listasDeCompras[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void criarLista(String nomeLista) {
    if (nomeLista.isNotEmpty) {
      setState(() {
        listasDeCompras.add(ModeloListas(nome: nomeLista, itens: []));
        nome_lista.clear();
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Nome da Lista Vazio',
              style: TextStyle(color: Color.fromARGB(255, 21, 21, 21)),
            ),
            content: Text(
              'Insira um nome para a lista.',
              style: TextStyle(color: Color.fromARGB(255, 21, 21, 21), fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void editarLista(int index) {
    TextEditingController novoNome = TextEditingController(text: listasDeCompras[index].nome);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Editar Nome da Lista',
            style: TextStyle(color: Color.fromARGB(255, 21, 21, 21)),
          ),
          content: TextField(
            style: TextStyle(color: const Color.fromARGB(255, 21, 21, 21), fontSize: 20),
            controller: novoNome,
            decoration: InputDecoration(
              labelText: 'Novo Nome',
              labelStyle: TextStyle(color: const Color.fromARGB(255, 21, 21, 21), fontSize: 20),
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  listasDeCompras[index] = ModeloListas(nome: novoNome.text, itens: listasDeCompras[index].itens);
                });
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void excluirLista(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Excluir Lista',
            style: TextStyle(color: Color.fromARGB(255, 21, 21, 21)),
          ),
          content: Text(
            'Deseja excluir esta lista?',
            style: TextStyle(color: Color.fromARGB(255, 21, 21, 21), fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  listasDeCompras.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Sim'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Não'),
            ),
          ],
        );
      },
    );
  }
}
