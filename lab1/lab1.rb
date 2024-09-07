a = 2
a = "World"

printf("Hello, #{a}\n")
print(`ls`)

arr = [1,2,"three", [4,5]]


arr.each do |x|
  if x.is_a?(Array)
    print("Array: ")
    x.each do |y|
      printf("#{y} ")
    end
  else 
    printf("#{x}\n")
  end
end

print("#{arr.size}\n")

n = 4
0.upto(n) do |i|
  print("#{i}\n")
end


for 
  i in 0...n do 
    printf("#{i}\n")
end

class Human
  @@