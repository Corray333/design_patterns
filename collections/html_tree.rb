require "./html_tag"

class HTMLTree
  include Enumerable

  attr_accessor :root

  def initialize(html)
    @root = build_tree(html)
  end

  def build_tree(html)
    tokens = html.scan(/<[^>]+>|[^<]+/)
    parse_node(tokens)
  end

  def parse_node(tokens)
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
          new_tag = HTMLTag.new(tag_name, attributes)
          current_tag.add_child(new_tag) if current_tag
          tag_stack.push(current_tag) if current_tag
          current_tag = new_tag
          root_tag ||= current_tag
        end
      else
        current_tag.add_child(HTMLTag.new('text', { 'content' => token.strip })) if !token.strip.empty?
      end
    end
    return root_tag
  end

  def each(&block)
    traverse_depth(@root, &block)
  end

  def traverse_depth(node, &block)
    return if node.nil?

    block.call(node)
    node.children.each { |child| traverse_depth(child, &block) }
  end
end

