# 1.2 Дан целочисленный массив. Необходимо найти индекс минимального элемента.
def find_min_index(arr)
  return arr.index(arr.min)
end

# 1.14 Дан целочисленный массив и интервал a..b. Необходимо найти количество элементов в этом интервале.
def count_elements_in_interval(arr, a, b)
  return arr.count { |x| x > a && x < b }
end

# Дан целочисленный массив. Необходимо найти количество элементов между первым и последним минимальным.
def count_elements_between_min(arr)
  min_value = arr.min
  first_min_index = arr.index(min_value)
  last_min_index = arr.rindex(min_value)
  return last_min_index - first_min_index - 1
end

# Дан целочисленный массив и отрезок a..b. Необходимо найти количество элементов, значение которых принадлежит этому отрезку.
def count_elements_in_range(arr, a, b)
  return arr.count { |x| x >= a && x <= b }
end

# Для двух введенных списков L1 и L2 построить новый список, состоящий из элементов, встречающихся только в одном из этих списков и не повторяющихся в них.
def unique_elements(l1, l2)
  combined = l1 + l2
  return combined.select { |x| combined.count(x) == 1 }
end
