import 'package:dio/dio.dart';
import 'package:first_app/pages/tarefa_form_page.dart';
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
  
  bool isLoading = true;

  //Inicializa o controlador
  @override
  void initState() {
    
    _getTarefas();
    super.initState();
  }

  Future<void> _getTarefas() async {

    setState(() {
      isLoading = true;
    });

    var dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 30),
        baseUrl: 'https://6912660c52a60f10c82189ce.mockapi.io/api/v1',
      ),
    );
    var response = await dio.get('/tarefa');

    await Future.delayed(Duration(seconds: 2));

    var listData = response.data;
    for (var data in listData) {
      var tarefa = Tarefa(
        titulo: data['titulo'],
        descricao: data['descricao'],
      );
      tarefas.add(tarefa);
    }

          setState(() {
        isLoading = true;
      });
  }

  //economiza memoria
  @override
  void dispose() {
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
          isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adsonarTarefa,
        child: Icon(Icons.add),
      ),
    );
  }

  void _adsonarTarefa() {

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return TarefaFormPage();
        },
      ),
    );
    
    // var tarefa = Tarefa(descricao: descricaotarefa, titulo: titulotarefa);
    // setState(() {
    //   tarefas.add(tarefa);
    // });
    // controllerTitulo.clear();
    // controllerDescricao.clear();
  }
}