class BmiCalculator {
  static double calculate(double weight, double height) {
    return weight / (height * height);
  }

  static String classify(double bmi) {
    if (bmi < 18.5) {
      return 'Abaixo do peso';
    } else if (bmi < 25) {
      return 'Peso ideal (Parabéns!)';
    } else if (bmi < 30) {
      return 'Levemente acima do peso';
    } else if (bmi < 35) {
      return 'Obesidade grau I';
    } else if (bmi < 40) {
      return 'Obesidade grau II';
    } else {
      return 'Obesidade grau III';
    }
  }
}