require "./node"
require "./dfs"
require "./bfs"

class HTMLNode < Node
  def initialize(tag, attributes = {})
    super()
    @name = tag
    @attributes = attributes
  end

  def to_s
    "<#{@name} #{@attributes.inspect}>"
  end

  def dfs
    return DFS_iterator.new(self)
  end

  def bfs
    return BFS_iterator.new(self)
  end

  def self.build_tree(html)
    tokens = html.scan(/<[^>]+>|[^<]+/)
    tag_stack = []
    current_tag = nil
    root_tag = nil
  
    until tokens.empty?
      token = tokens.shift

      if token.start_with?('<')
        if token[1] == '/'
          current_tag = tag_stack.pop
        else
          tag_name = token.match(/<(\w+)/)[1]
          attributes = token.scan(/(\w+)='([^']+)/).to_h

          new_tag = HTMLNode.new(tag_name, attributes)
          current_tag.add_child(new_tag) if current_tag
          root_tag ||= new_tag

          unless token.end_with?('/>')
            tag_stack.push(current_tag) if current_tag
            current_tag = new_tag
          end
        end

      else
        current_tag.add_child(HTMLNode.new('text', { 'content' => token.strip })) if !token.strip.empty?
      end

    end
    return root_tag
  end
end
