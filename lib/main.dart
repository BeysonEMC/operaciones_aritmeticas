import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Operaciones Aritméticas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Operaciones Aritméticas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNumberController = TextEditingController();
  final _secondNumberController = TextEditingController();
  String _result = "";
  String _selectedOperation = "Suma";

  void _calculateResult() {
    if (_formKey.currentState!.validate()) {
      double firstNumber = double.parse(_firstNumberController.text);
      double secondNumber = double.parse(_secondNumberController.text);

      setState(() {
        _result = _getOperationResult(firstNumber, secondNumber);
      });
    }
  }

  String _getOperationResult(double firstNumber, double secondNumber) {
    switch (_selectedOperation) {
      case "Suma":
        return (firstNumber + secondNumber).toString();
      case "Resta":
        return (firstNumber - secondNumber).toString();
      case "Multiplicación":
        return (firstNumber * secondNumber).toString();
      case "División":
        if (secondNumber == 0) {
          return "Error: División por cero";
        } else {
          return (firstNumber / secondNumber).toString();
        }
      default:
        return "";
    }
  }

  void _resetFields() {
    setState(() {
      _firstNumberController.clear();
      _secondNumberController.clear();
      _result = "";
      _selectedOperation = "Suma";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Primer Valor
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Primer Valor',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _firstNumberController,
                          decoration: InputDecoration(
                            hintText: 'Ingrese un número',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingrese un número';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  // Segundo Valor
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Segundo Valor',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _secondNumberController,
                          decoration: InputDecoration(
                            hintText: 'Ingrese un número',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingrese un número';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  // Operación
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Operación',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        DropdownButton<String>(
                          value: _selectedOperation,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedOperation = newValue!;
                            });
                          },
                          items: <String>['Suma', 'Resta', 'Multiplicación', 'División']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Total
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Total',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Resultado',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          controller: TextEditingController(text: _result),
                        ),
                      ],
                    ),
                  ),

                  // Botones
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _calculateResult,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            backgroundColor: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                          child: Icon(
                            Icons.play_arrow,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _resetFields,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                          child: Icon(
                            Icons.refresh,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}