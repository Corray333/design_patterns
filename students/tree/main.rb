require "./binary_tree"
require "../student"

tree = Node.new(value: Student.new("Anikin", "Mark", "Andreevich", id: 0, birthdate: 1034380800))
tree.add_child(Student.new("Masenko", "Maria", "Sergeenva", id: 1, birthdate: 1076457600))
tree.add_child(Student.new("Chechel", "Chel", "Chelikovich", id: 1, birthdate: 1033380800))

tree.each{|node| p(node.value)}