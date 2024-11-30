require "set"

class DataList
  def initialize(data)
    self.data = data
    @data.freeze

    @selected = Set.new
  end

  def data=(data)
    throw ArgumentError, "Data must be an array" if !data.is_a?(Array)
    @data = data
  end

  def select(num)
    throw ArgumentError, "num must be an integer" if !num.is_a?(Integer)
    throw IndexError, "num out of bounds" if num >= @data.length || num < 0

    @selected.add(@data[num])
  end

  def get_selected_ids()
    return @selected.map { |item| item.id }
  end

  def get_names
    raise NotImplementedError, "Not implemented"
  end

  def get_data()
    data = []

    @data.each_with_index do |student, index|
      data.push(self.get_row(index))
    end

    return DataTable.new(data)
  end

  def get_row
    raise NotImplementedError, "Not implemented"
  end
end
