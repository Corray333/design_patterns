# Variant 2
# Дан целочисленный массив. Необходимо найти индекс минимального элемента.

def find_min_index(arr)
  return nil  if arr.empty?
  min = arr[0]
  min_index = 0

  arr.each_index do |i|
    if arr[i] < min
      min = arr[i]
      min_index = i
    end
  end

  return min_index

end

# Дан целочисленный массив и интервал a..b. Необходимо найти количество элементов в этом интервале.

def count_elements_in_interval(arr, a, b)
  count = 0
  arr.each_index do |i|
    count += 1 if arr[i] > a and arr[i] < b
  end
  return count
end

# Дан целочисленный массив. Необходимо найти количество элементов между первым и последним минимальным.

def count_elements_between_min(arr)
  return nil  if arr.empty?
  min = arr[0]
  min_index = 0
  
  arr.each_index do |i|
    if arr[i] < min
      min = arr[i]
      min_index = i
    end
  end

  first_min_index = min_index
  last_min_index = min_index
  
  arr.each_index do |i|
    first_min_index = i if arr[i] == min
  end
  return last_min_index - first_min_index
end

# Дан целочисленный массив и отрезок a..b. Необходимо найти количество элементов, значение которых принадлежит этому отрезку.

def count_elements_in_segment(arr, a, b)
  count = 0
  arr.each_index do |i|
    count += 1 if arr[i] >= a and arr[i] <= b
  end
  return count
end

# Для двух введенных списков L1 и L2 построить новый список, состоящий из элементов, встречающихся только в одном из этих списков и не повторяющихся в них.

def unique_elements(l1, l2)
  result = []
  l1.each_index do |i|
    result.push(l1[i]) if not l2.include?(l1[i])
  end
  l2.each_index do |i|
    result.push(l2[i]) if not l1.include?(l2[i])
  end
  return result
end


def main()
  print("Какой из методов выполнить?\n1. Найти индекс минимального элемента\n2. Найти количество элементо в интервале (a,b)\n3. Найти количество элементов между первым и последним минимальным\n4. Найти количество элементов в отрезке [a,b]\n5. Построить новый список из уникальных элементов\n")
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