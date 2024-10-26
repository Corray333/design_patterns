require "./html_tag"

class HTMLTree
  include Enumerable

  attr_accessor :root

  def initialize(html)
    @root = build_tree(html)
  end

  def build_tree(html)
    tag_stack = []
    current_tag = nil
    root_tag = nil

    html.scan(/<[^>]+>|[^<]+/) do |token|
      if token.start_with?('<')
        if token[1]=='/'
          current_tag = tag_stack.pop
        else
          tag_name = token.match(/<(\w+)/)[1]
          attributes = token.scan(/(\w+)='([^']+)/).to_h
          new_tag = HTMLTag.new(tag_name, attributes)
          tag_stack.push(current_tag) if current_tag
          p(current_tag)
          p(new_tag)
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
end

html = "<html><body><div id='main'><p>Hello, World!</p></div></body></html>"
tree = HTMLTree.new(html)

# Обход в глубину
tree.each { |tag| puts tag.to_s }