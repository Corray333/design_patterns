require 'yaml'
require "./student_list/reader_writer"
require "./entities/student"

class StudentReaderWriterYAML < ReaderWriter
  def read(path)
    raise ArgumentError, "Invalid file path" unless File.file?(path)
    file_content = File.read(path)
    yaml_data = YAML.safe_load(file_content, symbolize_names: true)
    students = yaml_data.map do |student_data|
      Student.from_hash(**student_data)
    end
    return students
  end

  def write(path, students)
    yaml_data = students.map(&:to_hash)
    File.open(path, "w") do |file|
      file.write(YAML.dump(yaml_data))
    end
  end
end