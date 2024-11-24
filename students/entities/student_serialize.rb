require "./entities/student"
require "./entities/student_short"

def read_student_from_txt(file_path)
  raise ArgumentError, "Invalid file path" unless File.file?(file_path)
  students = []
  File.open(file_path, "r") do |file|
    file.each_line do |line|
      json_data = JSON.parse(line)

      # string keys to symbols
      symbolized_data = json_data.transform_keys(&:to_sym)
      students << Student.from_hash(**symbolized_data)
    end
  end
  return students
end

def write_student_to_txt(file_path, students)
  File.open(file_path, "w") do |file|
    students.each do |student|
      file.puts(student.to_json)
    end
  end
end