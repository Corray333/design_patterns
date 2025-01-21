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

  def get_student_page(page, limit, data_list = nil)
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

    if data_list
      data_list.index = from_index
      data_list.data = student_short_slice
    else
      data_list = DataListStudentShort.new(student_short_slice)
      data_list.index = from_index
      data_list.data = student_short_slice
    end
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

  def sort(column_index, order)
    case column_index
    when 1
      @students = @students.sort_by { |student| student.fio }
    when 2
      @students = @students.sort_by { |student| student.git }
    when 3
      @students = @students.sort_by { |student| student.contact }
    end
  
    @students.reverse! if order == :desc
  end

  private
  def student_is_new?(student)
    return @students.none? { |s| student == s }
  end

end