import 'package:flutter/material.dart';

class TarefaFormPage extends StatefulWidget {
  const TarefaFormPage({super.key});

  @override
  State<TarefaFormPage> createState() => _TarefaFormPageState();
}

class _TarefaFormPageState extends State<TarefaFormPage> {

  //Controlador para o campo de texto
  late TextEditingController controllerDescricao;
  late TextEditingController controllerTitulo;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  @override
  void initState(){
    controllerDescricao = TextEditingController();
    controllerTitulo = TextEditingController();
    super.initState();
  }

  //economiza memoria
  @override
  void dispose() {
    controllerDescricao.dispose();
    controllerTitulo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Cadastrar Tarefa"),),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controllerTitulo,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Digite uma titulo para a tarefa',
                ),
                validator: (value) => _validaCampoTitulo(),
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
                validator: (value) => _validaCampoDescricao(),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _salvarTarefa,
              label: Text("Salvar Tarefa"),
              icon: Icon(Icons.save_alt_outlined),
              )
            ],
                    ),
          ),
    );


  }
    String? _validaCampoDescricao() 
    {
      var descricaotarefa = controllerDescricao.text;

      if (descricaotarefa.trim().isEmpty) {
        return "Voce precisa digitar uma descrição";
      }
      
      return null;
    }

     String? _validaCampoTitulo() 
    {
      var descricaotarefa = controllerDescricao.text;

      if (descricaotarefa.trim().isEmpty) {
        return "Voce precisa digitar uma titulo";
      }
      
      return null;
    }

    Future<void> _salvarTarefa() async {
      var titulotarefa = controllerTitulo.text;
      var descricaotarefa = controllerDescricao.text;
    
    if (formKey.currentState?.validate() == true) {
      //Salvar
    }
  }
}