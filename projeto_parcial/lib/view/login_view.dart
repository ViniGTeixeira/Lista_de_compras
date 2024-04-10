import 'package:flutter/material.dart';
import 'package:projeto_parcial/view/listas_compras.dart';
import 'package:projeto_parcial/view/registrar_view.dart';
import 'package:projeto_parcial/view/sobre.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Chave para o formulário
  var formKey = GlobalKey<FormState>();
  var status = false;

  //Controladores para os Campos de Texto
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 21, 21, 21),
      body: Column(
        children: [
          Container(
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    Text(
                      'BEM VINDO',
                      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 30),
                    ),
                    Image.asset(
                        'lib/images/compras.png',
                        width: 250,
                        height: 175,
                    ),
                    Text("Login", style: TextStyle(fontSize: 30, color: Colors.white),),

                    SizedBox(height: 20),
                    TextFormField(
                      controller: txtEmail,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        errorStyle: TextStyle(color: Color.fromARGB(255, 224, 34, 21), fontSize: 20),
                        labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Você precisa digitar um email';
                        }
                        if (!value.contains('@') || !value.contains('.com')) {
                          return 'Você precisa digitar um email valido';
                        }
                        
                        return null ;
                      },
                      
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      controller: txtSenha,
                      autofocus: true,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Senha",
                        errorStyle: TextStyle(color: Color.fromARGB(255, 224, 34, 21), fontSize: 20),
                        labelStyle: TextStyle(color: Colors.white, fontSize: 20)
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Você precisa digitar uma senha';
                        }
                        return null;
                      },
                    ),


                    SizedBox(height: 30),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 32, 4, 175),
                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (txtEmail.text == "admin@.com" && txtSenha.text == "admin") {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Listas()),
                            );
                          }
                          else{
                            showDialog(context: context, builder: (BuildContext context) 
                             {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text('Email ou senha Invalido', style: TextStyle(color: Color.fromARGB(255, 21, 21, 21)),),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Fecha o diálogo
                                      },
                                    child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      child: Text(
                        'ENTRAR',
                        style: TextStyle(fontSize: 30, ),
                      )
                    ),
                  
                    SizedBox(height: 30),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 17, 39, 201),
                      ),
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Registrar()),
                        );
                      },
                      child: Text("Cadastrar", style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 255, 255, 255)),),
                    ),

                    SizedBox(height: 15),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 17, 39, 201),
                      ),
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Sobre()),
                        );
                      },
                      child: Text("Sobre o criador", style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 255, 255, 255)),),
                    )
                  ],
                ),
              ),
            ),
          )  
        ]

      
      ),
      
    );
  }
}