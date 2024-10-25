require "./no_loops"
require "./array_processor"

class Test
  attr_reader :name
  def initialize(name, func)
    @name = name
  end

  def passed?()
    raise NotImplementedError, "Test function is not implemented"
  end

  def print_result()
    if passed?() 
      print("Test #{@name} passed\n")
    else 
      print("Test #{@name} failed\n")
    end
  end
end

def run_tests(tests)
  tests.each do |test|
    test.print_result()
  end
end

tests = []

class TestFindMinIndex < Test
  def initialize()
    @name = "find_min_index"
  end

  def passed?()
    arr = [4, 5, 6, 7, 1, 8, 9, 1]
    return find_min_index(arr) == 4
  end
end

TestFindMinIndex.new().print_result()

class TestCountElementsInInterval < Test
  def initialize()
    @name = "count_elements_in_interval"
  end

  def passed?()
    arr = [4, 5, 6, 7, 1, 8, 9, 1]
    a = 2
    b = 8
    return count_elements_in_interval(arr, a, b) == 4
  end
end

class TestCountElementsBetweenMin < Test
  def initialize()
    @name = "count_elements_between_min"
  end

  def passed?()
    arr = [1, 2, 3, 4, 5, 6, 7, 1, 8, 9, 1]
    return count_elements_between_min(arr) == 6
  end
end

class TestCountElementsInRange < Test
  def initialize()
    @name = "count_elements_in_range"
  end

  def passed?()
    arr = [1, 2, 3, 4, 5, 6, 7]
    a = 2
    b = 5
    return count_elements_in_range(arr, a, b) == 4
  end
end

class TestUniqueElements < Test
  def initialize()
    @name = "unique_elements"
  end

  def passed?()
    l1 = [1, 2, 3]
    l2 = [2, 3, 4]
    return unique_elements(l1, l2) == [1, 4]
  end
end

# Tests
class TestAll < Test
  def initialize()
    @name = "all"
  end

  def passed?()
    arr_proc = ArrayProcessor.new([1, 2, 3, 4, 5])
    return arr_proc.all? { |el| el > 0 } == true
  end
end

class TestFlatMap < Test
  def initialize()
    @name = "flat_map"
  end

  def passed?()
    arr_proc = ArrayProcessor.new([1, 2, 3])
    return arr_proc.flat_map { |el| [el, el * 2] } == [1, 2, 2, 4, 3, 6]
  end
end

class TestOne < Test
  def initialize()
    @name = "one"
  end

  def passed?()
    arr_proc = ArrayProcessor.new([1, 2, 3, 4, 5])
    return arr_proc.one? { |el| el == 3 } == true
  end
end

class TestInject < Test
  def initialize()
    @name = "inject"
  end

  def passed?()
    arr_proc = ArrayProcessor.new([1, 2, 3, 4, 5])
    return arr_proc.inject(0) { |sum, el| sum + el } == 15
  end
end

class TestMinBy < Test
  def initialize()
    @name = "min_by"
  end

  def passed?()
    arr_proc = ArrayProcessor.new([1, 2, 3, 4, 5])
    return arr_proc.min_by { |el| -el } == 5
  end
end

class TestFind < Test
  def initialize()
    @name = "find"
  end

  def passed?()
    arr_proc = ArrayProcessor.new([1, 2, 3, 4, 5])
    return arr_proc.find { |el| el > 3 } == 4
  end
end

tests = []
tests  << TestFindMinIndex.new()
tests  << TestCountElementsInInterval.new()
tests  << TestCountElementsBetweenMin.new()
tests  << TestCountElementsInRange.new()
tests  << TestUniqueElements.new()
tests  << TestUniqueElements.new()
tests  << TestFlatMap.new()
tests  << TestOne.new()
tests  << TestInject.new()
tests  << TestMinBy.new()
tests  << TestFind.new()

run_tests(tests)
