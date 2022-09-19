# Iron-Water-Studio
Test task by Iron-Water-Studio

Алгоритмическая задачка:
Версия приложения может быть представлена набором целых неотрицательных чисел, разделенных точкой.
Необходимо реализовать функцию, которая будет принимать 2 строки, содержащие версию приложения и возвращать результат их сравнения. Учесть тот факт, что "1.0" и "1" это равные версии, однако "01.234.56" меньше, чем "2.0.0".
Необходимо реализовать алгоритм покомпонентного сравнения строк, содержащую версию приложения.
Код должен принимать такой вход:
● числа могут быть за пределами Int
● “.0” (должно понимать как 0.0)
● “.” (должно понимать как 0.0)
● “..0.1” (должно понимать как 0.0.0.1)
Решение задачи должно опираться на языковые возможности сравнения строк (посмотрите, что возвращают системные методы сравнения) и возвращать соответствующий результат. Не приветствуется создание дополнительных методов.
Решение задачи должно содержать:
● код демонстрации вызова метода
● демонстрация обработки недопустимого ввода
