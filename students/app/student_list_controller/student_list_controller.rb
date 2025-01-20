require_relative '../../student_list/student_list.rb'
require_relative '../../student_list/student_reader_writer_json.rb'
require_relative '../../data_list/data_list_student_short.rb'

class StudentListController
  def initialize(view)
      @view = view
      @student_list = StudentList.new("../resources/data/students.json",StudentReaderWriterJson.new())
      read_data()
      @data_list = DataListStudentShort.new([])
      @data_list.add_observer(@view)
  end

  def refresh_data()
      @data_list = @student_list.get_student_page(@view.items_per_page, @view.current_page + 1)
      @data_list.notify()
  end

  def get_logs_count()
      return @student_list.get_student_short_count()
  end

  def sort_by_column(column_index)
      @student_list.sort()
  end
  
  def read_data()
      @student_list.read()
  end

end