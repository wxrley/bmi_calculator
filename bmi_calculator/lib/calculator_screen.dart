import 'package:bmi_calculator/bmi_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  // Função para mostrar mensagens de erro ou resultado em um diálogo
  void showMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void calculate() {
    // Validação de campos vazios
    if (weightController.text.isEmpty || heightController.text.isEmpty) {
      showMessage('Erro', 'Por favor, preencha todos os campos!');
      return;
    }

    final weight = double.parse(weightController.text.replaceAll(',', '.'));
    final height = double.parse(heightController.text.replaceAll(',', '.'));

    // Validação de valores positivos
    if (weight <= 0 || height <= 0) {
      showMessage('Erro', 'Os valores devem ser maiores que zero!');
      return;
    }

    // Validação de valores razoáveis
    if (height > 3) {
      showMessage('Erro', 'Altura muito alta! Digite em metros (ex: 1.75)');
      return;
    }

    if (weight > 500) {
      showMessage('Erro', 'Peso muito alto! Verifique o valor.');
      return;
    }

    // Calcula IMC e mostra resultado
    final bmi = BmiCalculator.calculate(weight, height);
    final classification = BmiCalculator.classify(bmi);

    showMessage(
      'Resultado',
      'Seu IMC é ${bmi.toStringAsFixed(2)}\nClassificação: $classification',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon by Freepik from Flaticon (https://www.flaticon.com/)
            Image.asset('assets/images/bmi.png', width: 100, height: 100),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    // Regex para permitir apenas números com até 2 casas decimais
                    RegExp(r'^\d*[.,]?\d{0,2}'),
                  ),
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Peso (kg)',
                  hintText: 'Ex: 70.5',
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 250,
              child: TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*[.,]?\d{0,2}'),
                  ),
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Altura (m)',
                  hintText: 'Ex: 1.75',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
              ),
              child: const Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }
}
