require "./iterator.rb"

class BFS_iterator < Iterator
  def enumerator
    Enumerator.new do |yielder|
      enum_queue = [self.root]
      until enum_queue.empty?
        element = enum_queue.shift
        yielder << element
        enum_queue.concat element.children if element.children
      end
    end
  end
end