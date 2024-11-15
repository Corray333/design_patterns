require "./html_tree"

root = HTMLNode.build_tree('<div><p><span>hello</span></p><p><span>hello</span></p></div>')

puts "DFS:"
root.dfs.each { |node| puts node }
puts

puts "BFS:"
root.bfs.each { |node| puts node }