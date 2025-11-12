import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'model/tarefa_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Tarefa> tarefas = [];
  //Controlador para o campo de texto
  late TextEditingController controllerDescricao;
  late TextEditingController controllerTitulo;
  //Inicializa o controlador
  @override
  void initState() {
    controllerDescricao = TextEditingController();
    controllerTitulo = TextEditingController();
    _getTarefas();
    super.initState();
  }

  Future<void> _getTarefas() async {
    var dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 30),
        baseUrl: 'https://6912660c52a60f10c82189ce.mockapi.io/api/v1',
      ),
    );
    var response = await dio.get('/tarefa');
    var listData = response.data;
    for (var data in listData) {
      var tarefa = Tarefa(
        titulo: data['titulo'],
        descricao: data['descricao'],
      );
      setState(() {
        tarefas.add(tarefa);
      });
    }
  }

  //economiza memoria
  @override
  void dispose() {
    controllerDescricao.dispose();
    controllerTitulo.dispose();
    super.dispose();
  }

  //Constrói a interface do usuário
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Row(children: [Text(widget.title), const SizedBox(width: 8)]),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controllerTitulo,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite uma titulo para a tarefa',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controllerDescricao,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite uma descricao para a tarefa',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(tarefas[index].titulo),
                  subtitle: Text(tarefas[index].descricao),
                  trailing: Icon(Icons.arrow_right_alt_outlined),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adsonarTarefa,
        child: Icon(Icons.add),
      ),
    );
  }

  void _adsonarTarefa() {
    var titulotarefa = controllerTitulo.text;
    var descricaotarefa = controllerDescricao.text;
    if (titulotarefa.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Voce precisa digitar uma tarefa!')),
      );
      return;
    }
    if (descricaotarefa.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Voce precisa digitar uma descricao!')),
      );
      return;
    }
    var tarefa = Tarefa(descricao: descricaotarefa, titulo: titulotarefa);
    setState(() {
      tarefas.add(tarefa);
    });
    controllerTitulo.clear();
    controllerDescricao.clear();
  }
}