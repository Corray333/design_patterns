require "set"
require_relative "../helpers/deep_dup"

class DataList
  include DeepDup

  attr_accessor :index

  def initialize(data)
    self.index = 0
    self.data = data
    @data.freeze

    @selected = Set.new

    @observers = []
  end

  def data=(data)
    @data = {}

    data.each do |el|
      @data[self.index] = deep_dup(el)
      self.index = self.index + 1
    end
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

    @data.each do |k, v|
      data.push(self.get_row(k))
    end

    return DataTable.new(data)
  end

  def get_row
    raise NotImplementedError, "Not implemented"
  end

  def add_observer(observer)
    @observers << observer
  end

  def notify()
    @observers.each do |observer|
      observer.set_table_params(get_names(), self.count)
      observer.set_table_data(get_data())
    end
  end
end
