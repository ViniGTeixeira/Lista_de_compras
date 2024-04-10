import 'package:flutter/material.dart';

class Registrar extends StatefulWidget {
  const Registrar({Key? key}) : super(key: key);

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  //Chave para o formulário
  var formKey = GlobalKey<FormState>();
  var status = false;

  //Controladores para os Campos de Texto
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 21, 21, 21),
      body: Center(
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 120,
                  color: Colors.blue.shade900,
                ),

                SizedBox(height: 25),
                Text(
                  'Cadastrar',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),

                SizedBox(height: 25),
                TextFormField(
                  controller: txtNome,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Color.fromARGB(255, 224, 34, 21), fontSize: 20),
                    labelText: "Nome",
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira seu nome.';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),
                TextFormField(
                  controller: txtEmail,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Color.fromARGB(255, 224, 34, 21), fontSize: 20),
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira seu email.';
                    }
                    if (!value.contains('@')) {
                      return 'Insira um email válido.';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),
                TextFormField(
                  controller: txtSenha,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.white, fontSize: 25),          
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Color.fromARGB(255, 224, 34, 21), fontSize: 20),
                    labelText: "Senha",
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira sua senha.';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // cadastrar o usuário
                    }
                  },
                  child: Text('Cadastrar', style: TextStyle(fontSize: 30, color: Colors.blue.shade900)),
                ),

                SizedBox(height: 25),
                TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor:Color.fromARGB(255, 32, 4, 175),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Voltar", style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 255, 255, 255)),),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

