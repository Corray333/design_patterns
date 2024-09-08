# Task 1: Написать методы, которые находят минимальный, элементы, номер первого положительного элемента. Каждая операция в отдельном методе. Решить задачу с помощью циклов(for и while).

def find_min(arr)
  return nil  if arr.empty?
  min = arr[0]
  for i in 1...arr.length
    min = arr[i] if arr[i] < min
  end
  return min
end

def find_first_positive(arr)
  for i in 0...arr.length
    return i if arr[i] > 0
  end
  return nil
end

def read_array_from_file(file_name)
  arr = []
  file = File.open(file_name, "r") do |file|
    file.each_line do |line|
      line.split(" ").each do |number|
        arr.push(number.to_i)
      end
    end
  end 
  return arr
end

# Написать программу, которая принимает как аргумент два значения. Первое значение говорит, какой из методов задачи 1 выполнить, второй говорит о том, откуда читать список аргументом должен быть написан адрес файла. Далее необходимо прочитать массив и выполнить метод.

def main()
  print("Какой из методов выполнить?\n1. Найти минимальный элемент\n2. Найти первый положительный элемент\n")
  option = gets.chomp

  while 
    case option
    when "1"
      print("Введите название файла: ")
      file_name = gets.chomp
      arr = read_array_from_file(file_name)
      print("Минимальный элемент = ", find_min(arr), "\n")
      return
    when "2"
      print("Введите название файла: ")
      file_name = gets.chomp
      arr = read_array_from_file(file_name)
      print("Индекс первого положительного элемента = ", find_first_positive(arr), "\n")
      return
    when "exit"
      return
    else
      print("Выберете одну из функций\n")
      continue
    end
  end
end

main()