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
