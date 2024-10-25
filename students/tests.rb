require "./entities"

class Test
  def initialize(name, func)
    @name = name
    @func = func
  end
end

tests = []

def test_write_and_read()
  students = []

  students << Student.new(
    "Anikin",
    "Mark",
    "Andreevich",
    phone: "89320509129",
    git: "github.com/Corray333"
  )
  students << Student.new(
    "Masenko",
    "Maria",
    "Sergeevna",
    phone: "89234567890",
  )

  Student.write_to_txt("students.txt", students)

  new_students = Student.read_from_txt("students.txt")

  if students == new_students
    return true
  else
    return false
  end
end

tests << Test.new("write_and_read", method(:test_write_and_read))

def test_student_and_short_student_compability()
  student = Student.new(
    "Anikin",
    "Mark",
    "Andreevich",
    phone: "89320509129",
    git: "github.com/Corray333"
  )
  student_str = student.to_s()
  short_student = StudentShort.from_string(student_str, id: student.id)

  contact = ""
  if student.phone
    contact = student.phone
  elsif student.tg_username
    contact = student.tg_username
  elsif student.email
    contact = student.email
  end

  if student.id == short_student.id &&
    student.git == short_student.git &&
    contact == short_student.contact
    return true
  else
    return false
  end
end

tests << Test.new("student_and_short_student_compability", method(:test_student_and_short_student_compability))

def run_tests(tests)
  tests.each do |test|
    if test.instance_variable_get(:@func).call
      puts "#{test.instance_variable_get(:@name)} passed"
    else
      puts "#{test.instance_variable_get(:@name)} failed"
    end
  end
end


run_tests(tests)