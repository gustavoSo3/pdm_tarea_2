import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _is_male = true;
  final _weight_controller = TextEditingController();
  final _height_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcular IMC'),
        actions: [
          IconButton(
            onPressed: () {
              _weight_controller.clear();
              _height_controller.clear();

              FocusScope.of(context).unfocus();
            },
            icon: Icon(Icons.delete_forever),
          )
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  Text("Ingrese sus datos para calcular el IMC"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _is_male = false;
                            });
                          },
                          icon: Icon(
                            Icons.female,
                            color: !_is_male ? Colors.blue : Colors.black,
                          )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _is_male = true;
                            });
                          },
                          icon: Icon(
                            Icons.male,
                            color: _is_male ? Colors.blue : Colors.black,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.square_foot),
              title: TextFormField(
                controller: _height_controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ingresa altura (m eje: 1.84)",
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.monitor_weight),
              title: TextFormField(
                controller: _weight_controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ingresa peso (kg eje: 89)",
                ),
              ),
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  if (_weight_controller.text == "" ||
                      _height_controller.text == "") {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text("Te faltan datos"),
                      ));
                    return;
                  }
                  double _weight = double.parse(_weight_controller.text);
                  double _height = double.parse(_height_controller.text);
                  double _IMC = _weight / (_height * _height);
                  print(_IMC.round());
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Tu IMC: ${_IMC.round()}"),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Tabla de IMC para ${_is_male ? "hombres" : "mujeres"}"),
                          Text("Edad \tIMC Ideal"),
                          Text("16-17 \t${_is_male ? "xx-xx" : "xx-xx"}"),
                          Text("18-18 \t${_is_male ? "xx-xx" : "xx-xx"}"),
                          Text("19-24 \t${_is_male ? "xx-xx" : "xx-xx"}"),
                          Text("25-34 \t${_is_male ? "xx-xx" : "xx-xx"}"),
                          Text("35-44 \t${_is_male ? "xx-xx" : "xx-xx"}")
                        ],
                      ),
                    ),
                  );
                },
                child: Text("Calcular"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
