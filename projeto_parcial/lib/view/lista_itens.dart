import 'package:flutter/material.dart';
import 'package:projeto_parcial/model/modelo_listas.dart';

class ListaItens extends StatefulWidget {
  final ModeloListas modelolistas;

  ListaItens(this.modelolistas);

  @override
  _ListaItensState createState() => _ListaItensState();
}

class _ListaItensState extends State<ListaItens> {
  final TextEditingController nome_item = TextEditingController();
  List<int> quantidade = [];
  List<bool> itensPegos = [];
  String filtro = '';

  void adicionarItem(String nomeItem) {
    setState(() {
      widget.modelolistas.itens.add(nomeItem);
      quantidade.add(0);
      itensPegos.add(false);
      nome_item.clear();
    });
  }

  void editarNomeItem(int index) {
    TextEditingController novoNome = TextEditingController(text: widget.modelolistas.itens[index]);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Editar Nome do Item',
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
                  widget.modelolistas.itens[index] = novoNome.text;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 21, 21, 21),
      appBar: AppBar(
        title: Text(
          widget.modelolistas.nome,
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 25),
              TextField(
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 25),
                controller: nome_item,
                decoration: InputDecoration(
                  labelText: 'Nome do Item',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 25),
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
                  adicionarItem(nome_item.text);
                },
                child: Text(
                  'Adicionar Item',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Itens na Lista:',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              TextField(
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 25),
                onChanged: (value) {
                  setState(() {
                    filtro = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Pesquisar Item',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 25),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Text(
                  'Arraste a lista para excluir',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.modelolistas.itens.length,
                  itemBuilder: (context, index) {
                    if (filtro.isEmpty || widget.modelolistas.itens[index].contains(filtro)) {
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          setState(() {
                            widget.modelolistas.itens.removeAt(index);
                            quantidade.removeAt(index);
                            itensPegos.removeAt(index);
                          });
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                Checkbox(
                                  value: itensPegos[index],
                                  onChanged: (value) {
                                    setState(() {
                                      itensPegos[index] = value!;
                                    });
                                  },
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    editarNomeItem(index);
                                  },
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(widget.modelolistas.itens[index]),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  quantidade[index].toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      quantidade[index]++;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (quantidade[index] > 0) {
                                        quantidade[index]--;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
