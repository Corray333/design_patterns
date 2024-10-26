require "./no_loops"


def read_array_from_file(file_path)
  File.read(file_path).split.map(&:to_i)
end

def read_array_from_console
  p("Enter array elements separated by spaces:")
  gets.chomp.split.map(&:to_i)
end

def request_array()
  p("Choose input method:")
  p("1. From file")
  p("2. From console")
  input_method = gets.chomp.to_i

  arr = case input_method
  when 1
    p("Enter file path:")
    file_path = gets.chomp
    read_array_from_file(file_path)
  when 2
    read_array_from_console
  else
    p("Invalid input method")
    return
  end

  return arr
end

def main()
  p("Choose function:")
  p("1. Find min index")
  p("2. Count elements in interval")
  p("3. Count elements between mins")
  p("4. Count elements in range")
  p("5. Unique elements")
  function_pick = gets.chomp.to_i

  array = request_array()
  p(array)

  case function_pick
  when 1
    p(find_min_index(array))
  when 2
    p("Enter a: ")
    a = gets.chomp.to_i
    p("Enter b: ")
    b = gets.chomp.to_i
    p(count_elements_in_interval(array, a, b))
  when 3
    p(count_elements_between_mins(array))
  when 4
    p("Enter a: ")
    a = gets.chomp.to_i
    p("Enter b: ")
    b = gets.chomp.to_i
    p(count_elements_in_range(array, a, b))
  when 5
    array2 = request_array()
    p(unique_elements(array, array2))
  end
end

main()