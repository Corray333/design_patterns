require 'json'
require "./reader_writer/reader_writer"
require "./entities/student"

class StudentReaderWriterJson < ReaderWriter
  def read(path)
    raise ArgumentError, "Invalid file path" unless File.file?(path)
    file_content = File.read(path)
    json_data = JSON.parse(file_content)
    students = json_data.map do |student_data|
      symbolized_data = student_data.transform_keys(&:to_sym)
      Student.from_hash(**symbolized_data)
    end
    return students
  end

  def write(path, students)
    json_data = students.map(&:to_hash)
    File.open(path, "w") do |file|
      file.write(JSON.pretty_generate(json_data))
    end
  end
end