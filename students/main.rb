require "./data_list_student_short/data_list_student_short"
require "./entities/student_short"

d = DataListStudentShort.new([
  StudentShort.new(1, "Ivanov Ivan Ivanovich", "ivanov", "mail@gmail.com"),
  StudentShort.new(2, "Petrov Petr Petrovich", "petrov", "petrov@gmail.com"),
  StudentShort.new(3, "Sidorov Sidor Sidorovich", "sidorov", "89320509129")
])

puts d.get_data().get_element(1, 1) 