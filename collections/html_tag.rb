class HTMLTag
  attr_accessor :name, :attributes, :children

  def initialize(name, attributes = {})
    @name = name
    @attributes = attributes
    @children = []
  end

  def add_child(tag)
    @children << tag
  end

  def to_s
    "<#{@name} #{@attributes.inspect}>"
  end
end