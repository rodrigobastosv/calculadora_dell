import 'package:flutter/material.dart';

class MinhaCalculadora extends StatefulWidget {
  @override
  _MinhaCalculadoraState createState() => _MinhaCalculadoraState();
}

class _MinhaCalculadoraState extends State<MinhaCalculadora> {
  int primeiroOperando;
  int segundoOperando;
  String operador;

  Function(int) onTapNumeroUm;
  Function(int) onTapNumeroDois;
  Function(String) onTapOperador;

  @override
  void initState() {
    onTapNumeroUm = (numero) {
      setState(() {
        primeiroOperando = numero;
      });
    };
    onTapNumeroDois = (numero) {
      setState(() {
        segundoOperando = numero;
      });
    };
    onTapOperador = (op) {
      setState(() {
        operador = op;
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Calculadora'),
        centerTitle: true,
        leading: Icon(Icons.filter_9_plus),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Visor(
              primeiroOperando: primeiroOperando,
              operador: operador,
              segundoOperando: segundoOperando,
            ),
            SizedBox(height: 24),
            Numeros(onTap: onTapNumeroUm),
            Operadores(onTap: onTapOperador),
            SizedBox(height: 24),
            Numeros(onTap: onTapNumeroDois),
            SizedBox(height: 36),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                setState(() {
                  primeiroOperando = null;
                  operador = null;
                  segundoOperando = null;
                });
              },
              child: Text(
                'LIMPAR',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Operadores extends StatelessWidget {
  Operadores({this.onTap});

  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            onTap('+');
          },
          child: Container(
            height: 40,
            width: 40,
            child: Center(
              child: Text('+'),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            onTap('-');
          },
          child: Container(
            height: 40,
            width: 40,
            child: Center(
              child: Text('-'),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            onTap('*');
          },
          child: Container(
            height: 40,
            width: 40,
            child: Center(
              child: Text('*'),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            onTap('/');
          },
          child: Container(
            height: 40,
            width: 40,
            child: Center(
              child: Text('/'),
            ),
          ),
        ),
      ],
    );
  }
}

class Visor extends StatelessWidget {
  Visor({
    this.primeiroOperando,
    this.segundoOperando,
    this.operador,
  });

  final int primeiroOperando;
  final int segundoOperando;
  final String operador;

  String calculaOperacao() {
    if (operador == '+') {
      return (primeiroOperando + segundoOperando).toString();
    } else if (operador == '-') {
      return (primeiroOperando - segundoOperando).toString();
    } else if (operador == '*') {
      return (primeiroOperando * segundoOperando).toString();
    } else if (operador == '/') {
      return (primeiroOperando / segundoOperando).toString();
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.grey[300],
      child: Row(
        children: <Widget>[
          Text(
            primeiroOperando != null ? primeiroOperando.toString() : '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            operador != null ? operador : '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            segundoOperando != null ? segundoOperando.toString() : '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            (primeiroOperando != null &&
                    operador != null &&
                    segundoOperando != null)
                ? ' = ${calculaOperacao()}'
                : '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class Numeros extends StatelessWidget {
  Numeros({this.onTap});

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
      itemBuilder: (_, i) => GestureDetector(
        onTap: () {
          onTap(i);
        },
        child: Container(
          height: 40,
          width: 40,
          child: Text(i.toString()),
        ),
      ),
      itemCount: 10,
    );
  }
}
