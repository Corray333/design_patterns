require "set"

class DataList
  def initialize(data)
    throw ArgumentError, "Data must be an array" if !data.is_a?(Array)

    @data = data
    @data.freeze

    @selected = Set.new
  end

  def data=(data)
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
    raise NotImplementedError, "Not implemented"
  end
end
