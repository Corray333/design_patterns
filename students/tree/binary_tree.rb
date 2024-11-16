class Node include Enumerable
  attr_accessor :value, :left, :right, :parent

  def initialize(value: nil, left: nil, right: nil, parent: nil)
    self.value = value
    self.left = left
    self.right = right
    self.parent = parent
  end

  def add_child(new_value)
    if new_value < self.value
      if self.left
        self.left.add_child(new_value)
      else
        self.left = Node.new(value: new_value, parent: self)
      end
    else
      if self.right
        self.right.add_child(new_value)
      else
        self.right = Node.new(value: new_value, parent: self)
      end
    end
  end

  def each(&block)
    self.left.each(&block) if self.left
    block.call(self)
    self.right.each(&block) if self.right
  end

end