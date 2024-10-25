class ArrayProcessor
  def initialize(arr)
    @arr = arr.dup.freeze
  end

  def elements
    return @arr
  end

  def [](index)
    return @arr[index]
  end

  def all?(&block)
    @arr.each { |el| return false unless block.call(el) }
    return true
  end

  def flat_map(&block)
    result = []
    @arr.each { |el| result.concat(block.call(el)) }
    return result
  end

  def one?(&block)
    count = 0
    @arr.each { |el| count += 1 if block.call(el) }
    return count == 1
  end

  def inject(initial, &block)
    result = initial
    @arr.each { |el| result = block.call(result, el) }
    result
  end

  def min_by(&block)
    min_element = @arr.first
    min_value = block.call(min_element)
    @arr.each do |el|
      value = block.call(el)
      if value < min_value
        min_element = el
        min_value = value
      end
    end
    return min_element
  end

  def find(&block)
    @arr.each { |el| return el if block.call(el) }
    return nil
  end
end
