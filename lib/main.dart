
import 'dart:async';
import 'package:flutter/material.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cronômetro Flutter'),
        ),
        body: Cronometro(),
      ),
    );
  }
}

class Cronometro extends StatefulWidget {
  @override
  _CronometroState createState() => _CronometroState();
}
// cronometro
class _CronometroState extends State<Cronometro> {
  TextEditingController tempoController = TextEditingController();
  int tempoRestante = 0;
  bool emExecucao = false;

  Timer? _timer;

  void iniciarCronometro() {
    setState(() {
      tempoRestante = int.tryParse(tempoController.text) ?? 0;
      emExecucao = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (tempoRestante > 0) {
          tempoRestante--;
        } else {
          emExecucao = false;
          _timer?.cancel();
          _timer = null;
          _exibirAlerta(context);
        }
      });
    });
  }



//função alert
  void _exibirAlerta(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alerta'),
        content: Text('Acabou o tempo!'),
        actions: <Widget>[
          TextButton(
            child: Text('ok'),
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o alerta
            },
          ),
        ],
      );
    }
  );
}

//exibir componets na tela
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: tempoController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Digite o tempo em segundos',
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: emExecucao ? null : iniciarCronometro,
          child:const Icon(Icons.add_alarm), 
        ),
        Text(
          '*Clique no botão para iniciar o cronômetro!',
          style:TextStyle(color:Colors.red,fontSize:15)
        ),
        SizedBox(height: 20),
        Text(
          'Tempo Restante: $tempoRestante',
          style:TextStyle(color:Colors.blue,fontSize:30)
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    tempoController.dispose();
    super.dispose();
  }
}
