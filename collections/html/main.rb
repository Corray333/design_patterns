require "./html_node"

root = HTMLNode.build_tree('<html lang="ru">
  <head>
      <meta charset="UTF-8"/>
      <title>Пример</title>
  </head>
  <body>
      <h1 id="main-heading" class="header-text">Привет!</h1>
      <p style="font-family: Arial, sans-serif; background-color: #f4f4f4;">Это пример простого HTML-документа.</p>
  </body>
  </html>')

puts root.dfs.each {|el| puts(el, el.children)}
puts
puts root.bfs.each {|el| puts(el, el.children)}
