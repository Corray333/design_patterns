require "./entities"

students = []

students << Student.new({
  surname: "Anikin",
  name: "Mark",
  patronymic: "Andreevich",
  phone: "89320509129",
  git: "github.com/Corray333"
})

students << Student.new({
  surname: "Masenko",
  name: "Maria",
  patronymic: "Sergeevna",
  phone: "89234567890",
})


students.each() do |student|
  puts(student, "\n")
end

students.each() do |student|
  print(student.inspect(), "\n")
end