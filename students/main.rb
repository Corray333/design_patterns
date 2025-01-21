require "./data_list/data_list_student_short"
require "./entities/student_short"
require "./entities/student"
require "./student_list/student_list"
require "./student_list/student_reader_writer_json"
require "./student_list/student_reader_writer_yaml"
require "./student_list/student_list_db"

d = DataListStudentShort.new([
  StudentShort.new(1, "Ivanov Ivan Ivanovich", "ivanov", "mail@gmail.com"),
  StudentShort.new(2, "Petrov Petr Petrovich", "petrov", "petrov@gmail.com"),
  StudentShort.new(3, "Sidorov Sidor Sidorovich", "sidorov", "89320509129")
])

puts d.get_data().get_element(1, 0) 

# student_list = StudentList.new("students.json", StudentReaderWriterJson.new())
student_list = StudentList.new("./resources/data/students.yaml", StudentReaderWriterYAML.new())
student_list.sort_by_name()
p student_list.get_student_by_id(3)

p student_list.get_student_page(2, 2).get_data().get_element(1, 0)


p "DB from here:"
p "===================================================="

db_list = StudentListDB.instance
student_to_be_updated = db_list.get_student_by_id(1)
p student_to_be_updated
p db_list.get_student_page(2, 2).get_data().get_element(0, 0)
student_to_be_updated.birthdate = Time.now.to_i
db_list.update_student(student_to_be_updated)
student_to_be_updated = db_list.get_student_by_id(1)
p student_to_be_updated
