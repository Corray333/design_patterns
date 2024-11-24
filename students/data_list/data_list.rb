class DataList
  def initialize(data)
    throw ArgumentError, "Data must be an array" if !data.is_a?(Array)

    @data = data
    @data.freeze
  end
end
