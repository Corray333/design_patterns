require_relative "./data_list"
require_relative "../data_table/data_table"
require_relative "../entities/student_short"

class DataListStudentShort < DataList

  def initialize(data)
    super(data)
  end

  def get_names
    return ["№", "FIO", "Git", "Contact"]
  end

  def get_row(id)
    return [id, @data[id].fio, @data[id].git, @data[id].contact]
  end
end