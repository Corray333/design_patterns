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
    data_list.index = from_index
    data_list.data = student_short_slice
    return data_list
  end

  def add_student(student)
    new_id = @students.map { |student| student.id }.max + 1
    student.id = new_id
    student_is_new?(student) ? @students.push(student) : raise(ArgumentError, "Student already exists")
  end

  def update_student(student)
    raise(ArgumentError, "Student already exists") if !student_is_new?(student)
    
    @students = @students.map { |s| s.id == student.id ? student : s }
  end

  def delete_by_id(id)
    @students.delete_if { |student| student.id == id }
  end

  def count()
    return @students.length
  end

  def sort_by_name()
    @students = @students.sort_by { |student| student.fio }
  end

  private
  def student_is_new?(student)
    @students.none? do |s|
      (student.id && s.id == student.id) ||
      (student.git && s.git == student.git) ||
      (student.email && s.email == student.email) ||
      (student.phone && s.phone == student.phone) ||
      (student.tg_username && s.tg_username == student.tg_username)
    end
  end

end