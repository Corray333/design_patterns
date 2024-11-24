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

  def get_data()
    data = []

    @data.each_with_index do |student, index|
      data.push(self.get_row(index))
    end

    return DataTable.new(data)
  end

  private

  def get_row(id)
    return [id, @data[id].fio, @data[id].git, @data[id].contact]
  end
end