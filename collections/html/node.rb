class Node

  attr_reader :children

  def initialize()
    @children = []
  end

  def add_child(node)
    @children << node
  end

  def traverse_depth(node, &block)
    return if node.nil?

    block.call(node)
    node.children.each { |child| traverse_depth(child, &block) }
  end
end