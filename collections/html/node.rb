require "./dfs"
require "./bfs"

class Node

  attr_reader :children

  def initialize()
    @children = []
  end

  def add_child(node)
    @children << node
  end

  def dfs
    return DFS_iterator.new(self)
  end

  def bfs
    return BFS_iterator.new(self)
  end
end