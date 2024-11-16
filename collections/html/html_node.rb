require "./node"

class HTMLNode < Node
  private_class_method :new

  TAGS = {
    html: 'html',
    head: 'head',
    body: 'body',
    div: 'div',
    span: 'span',
    p: 'p',
    a: 'a',
    img: 'img',
    ul: 'ul',
    li: 'li',
    h1: 'h1',
    h2: 'h2',
    h3: 'h3',
  }.freeze

  ATTRIBUTES = {
    class: 'class',
    style: 'style',
    id: 'id'
  }
  
  def initialize(tag, attributes = {})
    super()
    @tag = TAGS[tag.to_sym] || tag
    @attributes = attributes
  end

  def to_s
    "<#{@tag} #{@attributes.inspect}>"
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
          attributes = token.scan(/(\w+)="([^"]+)/).to_h

          new_tag = new(tag_name, attributes)
          current_tag.add_child(new_tag) if current_tag
          root_tag ||= new_tag

          unless token.end_with?('/>')
            tag_stack.push(current_tag) if current_tag
            current_tag = new_tag
          end
        end

      else
        current_tag.add_child(new('text', { 'content' => token.strip })) if !token.strip.empty?
      end

    end
    return root_tag
  end

  def number_of_children()
    return @children.size
  end

  def has_child?()
    return @children.size > 0
  end

  def style()
    return @attributes[ATTRIBUTES[:style]]
  end

end
