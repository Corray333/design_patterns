class DataTable
  def initialize(data)
    @data = data
  end

  def count_rows ()
    return @data.length
  end

  def count_cols()
    return @data.first.length
  end

  def get_element(row, col)
    throw IndexError, "Row index out of bounds" if row >= @data.length 

    throw IndexError, "Column index out of bounds" if col >= @data.first.length 

    return @data[row][col].dup
  end
end
