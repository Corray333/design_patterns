require 'json'
require "./reader_writer/reader_writer"
requier "./entities/student"

class StudentReaderWriterJson < ReaderWriter
  def read (path)
    raise ArgumentError, "Invalid file path" unless File.file?(path)
    students = []
    File.open(path, "r") do |file|
      file.each_line do |line|
        json_data = JSON.parse(line)

        # string keys to symbols
        symbolized_data = json_data.transform_keys(&:to_sym)
        students << Student.from_hash(**symbolized_data)
      end
    end
    return students
  end

  def write (path, students)
    File.open(path, "w") do |file|
      students.each do |student|
        file.puts(student.to_json)
      end
    end
  end
end