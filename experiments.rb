# msg = " Hello, World! "
# print(msg.length, "\n")
# print(msg.chomp)
# print(msg.split(" "))
# print(msg.gsub("l", "L"))
# print(msg.upcase)

class Human
  @@count = 0
  def initialize(name, age)
    @name = name
    @age = age
    @@count += 1
  end
  def self.count
    @@count
  end
  def to_s
    "#{@name}, #{@age}"
  end
end

h1 = Human.new("Alice", 20)
h2 = Human.new("Bob", 30)
h3 = Human.new("Charlie", 40)
puts Human.count
puts h1
puts h2
puts h3
puts h1.to_s
puts h2.to_s
puts h3.to_s
