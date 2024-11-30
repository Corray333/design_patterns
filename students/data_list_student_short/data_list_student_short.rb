require "./data_list/data_list"
require "./data_table/data_table"
require "./entities/student_short"

class DataListStudentShort < DataList
  def initialize(data)
    super(data)
  end

  def get_names
    return ["№", "FIO", "Git", "Contact"]
  end

  private

  def get_row(id)
    return [id, @data[id].fio, @data[id].git, @data[id].contact]
  end
end