require 'fox16'
include Fox

class StudentListView < FXMainWindow
  attr_reader :current_page, :items_per_page
  def initialize(app)
    super(app, "Students",opts: DECOR_ALL & ~DECOR_RESIZE, width: 915, height: 440)

    @items_per_page = 15
    @current_page = 0
    @total_pages = 3
    @sort_order = :asc

    main_frame = FXHorizontalFrame.new(self, LAYOUT_FILL_X | LAYOUT_FILL_Y)

    
    table_frame = FXVerticalFrame.new(main_frame, FRAME_SUNKEN | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    draw_table(table_frame)


    button_frame = FXVerticalFrame.new(main_frame, FRAME_SUNKEN | LAYOUT_FILL_Y | LAYOUT_FIX_WIDTH, width: 150)
    
    draw_buttons(button_frame)


  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  private def draw_table(parent_frame)
    @table = FXTable.new(parent_frame, opts: TABLE_READONLY | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    @table.rowHeader.width = 0 
    @table.setTableSize(@items_per_page, 4)
    @table.setColumnWidth(0, 30)
    @table.setColumnWidth(1, 100)
    @table.setColumnWidth(2, 200)
    @table.setColumnWidth(3, 200)

    navigation_segment = FXHorizontalFrame.new(parent_frame, opts: LAYOUT_CENTER_X | LAYOUT_FIX_WIDTH, width:100)
    @prev_button = FXButton.new(navigation_segment, "<<<", opts: LAYOUT_LEFT | BUTTON_NORMAL)
    @page_index = FXLabel.new(navigation_segment, "#{@current_page + 1}", opts: LAYOUT_CENTER_X)
    @next_button = FXButton.new(navigation_segment, ">>>", opts: LAYOUT_RIGHT | BUTTON_NORMAL)


  end




  def set_table_params(column_names, rows_count)
    column_names.each_with_index do |name, index| 
        @table.setColumnText(index, name)
    end

    @table.setColumnWidth(0, 30)
    @table.setColumnWidth(1, 100)
    @table.setColumnWidth(2, 200)
    @table.setColumnWidth(3, 200)
  end

  private def draw_buttons(button_frame)
    FXLabel.new(button_frame, "Действия")
  
    FXButton.new(button_frame, "Добавить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
  
    @edit_button = FXButton.new(button_frame, "Изменить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @edit_button.enabled = false 
  
    @delete_button = FXButton.new(button_frame, "Удалить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @delete_button.enabled = false 
  
    @update_button = FXButton.new(button_frame, "Обновить", opts: BUTTON_NORMAL | LAYOUT_FILL_X)
    @table.connect(SEL_CHANGED) do
      selected_rows = []
      (@table.selStartRow..@table.selEndRow).each do |row|
        selected_rows << row if row >= 0 && row < @table.numRows && @table.rowSelected?(row)
      end
  
      if selected_rows.size == 1 
        @edit_button.enabled = true
        @delete_button.enabled = true
      elsif selected_rows.size > 1 
        @edit_button.enabled = false
        @delete_button.enabled = true
      else
        @edit_button.enabled = false
        @delete_button.enabled = false
      end
    end
  end


end

