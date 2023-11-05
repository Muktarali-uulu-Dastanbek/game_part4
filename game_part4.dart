import 'dart:io';
import 'dart:math';

void main() {
  start_game();
}

start_game() {
  print("Выберите режим игры: 1 или 2 или 3");
  print("1-режим. Угадывать будете вы.");
  print("2-режим. Угадывать будет компьютер");
  print("3-режим. По очереди будете загадывать а второй отгадывать");

  String gameMode = stdin.readLineSync()!; // gameMode - режим игры

  if (gameMode == '1') {
    int randomChislo = 1 + Random().nextInt(100);
    computer(randomChislo); //загадывать будет компьютер
  } else if (gameMode == '2') {
    print("Загадайте число в диапазоне[0-100) и затем");
    computerModeHelper(); //загадывать будет пользователь
  } else if (gameMode == "3") {
    computerAndUser(); //3-режим, по очереди
  } else {
    start_game();
  }
}

void computerAndUser() {
  print("Введите количество раундов[1-10]:");
  String numberOfRounds = stdin.readLineSync()!;
  if (numberOfRounds == "") {
    numberOfRounds = "3";
  }
  print(
      "Кто начнет с загадывания? Введите 1 - если компьютер начнет загадывать число, 2 - если наоборот.");

  String userAnswer = stdin.readLineSync()!;
  int ochkiUser = 0;
  int ochkiComp = 0;

  for (int i = 1; i <= int.parse(numberOfRounds); i++) {
    print("--------------------------------------------------------");
    print("Round - $i");
    int comp = 0, user = 0;

    if (userAnswer == "1") {
      print("1-этап: компьютер начнет с загадывания");
      int randomChislo = 1 + Random().nextInt(100);
      user = computer(randomChislo);
      print("Теперь загадывать число будете вы.");
      comp = computerModeHelper();
    } else if (userAnswer == "2") {
      print("1-этап: вы начнете с загадывания");
      comp = computerModeHelper();
      print("Теперь загадывать число будет компьютер.");
      int randomChislo = 1 + Random().nextInt(100);
      user = computer(randomChislo);
    } else {
      print("Error\n Введите 1 или 2.");
      computerAndUser();
    }

    if (user < comp) {
      ochkiUser++;
    } else if (comp < user) {
      ochkiComp++;
    }
  }

  if (ochkiComp > ochkiUser) {
    print("Выиграл компьютер c очками - [$ochkiComp-$ochkiUser]");
  } else if (ochkiComp < ochkiUser) {
    print("Выиграли вы c очками - [$ochkiUser-$ochkiComp]");
  } else {
    print("Результат игры - Ничья");
  }
}

int computerModeHelper() {
  print("Выбирайте способ угадывания:");
  print("1-режим. Рандомный метод.");
  print("2-режим. Бинарный метод");

  String a = stdin.readLineSync()!;

  if (a == '1') {
    return random_search();
  } else if (a == '2') {
    return binary_search();
  } else {
    computerModeHelper();
  }
  return -1;
}

int computer(int chislo) {
  int count = 0;
  int a = -1;

  print("Отгадайте число которое загадал компьютер:");

  while (a != chislo) {
    print("-------------------------------");
    try {
      a = int.parse(stdin.readLineSync()!);
    } catch (e) {
      print("error = $e");
      print("Введите правильный формат");
      a = int.parse(stdin.readLineSync()!);
    }
    if (a > 0 && a <= 100) {
      count++;
      print("Попытка ------ $count");

      if (a > chislo) {
        print("greater ----- ваше число больше");
      } else if (a < chislo) {
        print("less ----- ваше число меньше");
      }
    } else {
      print("Введите числа в диапазоне[1:100]");
    }
  }

  print("yes");
  print("Вы нашли загаданное число компа за $count попыток");
  return count;
}

int random_search() {
  int counter = 0;
  int min = 0;
  int max = 100;
  int randomChislo = -1;
  String userAnswer = "";

  while (userAnswer != "=") {
    counter++;
    randomChislo = min + Random().nextInt(max - min);
    print("vashe chislo -$randomChislo?");
    userAnswer = stdin.readLineSync()!;

    if (userAnswer == "+") {
      min = randomChislo + 1;
    } else if (userAnswer == "-") {
      max = randomChislo;
    } else if (userAnswer != "=") {
      counter--;
      print('Ответьте символами "+" и "-"');
    }
  }
  print("vashe chislo - $randomChislo.");
  print("kolichestvo popytok(rondom_search)=$counter");

  return counter;
}

int binary_search() {
  int count = 0;
  int min = 0;
  int max = 100;
  int mid = -1;
  String userAnswer = "";

  while (userAnswer != "=") {
    mid = (min + max) ~/ 2;
    count++;
    print("vashe chislo -$mid?");

    userAnswer = stdin.readLineSync()!;

    if (userAnswer == "+") {
      min = mid;
    } else if (userAnswer == "-") {
      max = mid;
    } else if (userAnswer != "=") {
      count--;
      print('Ответьте символами "+" и "-"');
    }
  }

  print("vashe chislo - $mid.");
  print("kolichestvo popytok(rondom_search)=$count");

  return count;
}
