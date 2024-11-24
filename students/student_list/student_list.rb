class StudentList
  def initialize(path, reader_writer)
    @path = path
    @reader_writer = reader_writer
    @students = read()
  end

  def read ()
    @students = @reader_writer.read(@path)
  end

  def write ()
    @reader_writer.write(@path, @students)
  end

  def get_student_by_id(id)
    return @students.find { |student| student.id == id }
  end

  def get_student_page(page, limit)
    from_index = (page - 1) * limit
    to_index = from_index + limit
    if to_index > @students.length
      to_index = @students.length
    end
    if from_index >= @students.length
      from_index = @students.length - 1
    end

    slice = @students[from_index...to_index]
    student_short_slice = slice.map { |student| StudentShort.from_student(student) }

    data_list = DataListStudentShort.new(student_short_slice)
    return data_list
  end

  def sort()
    return @students.sort_by { |student| student.fio }
  end

  def add_student(student)
    new_id = @students.map { |student| student.id }.max + 1
    student.id = new_id
    @students.push(student)
    write()
  end

  def delete_by_id(id)
    @students.delete_if { |student| student.id == id }
    write()
  end

  def count()
    return @students.length
  end

end