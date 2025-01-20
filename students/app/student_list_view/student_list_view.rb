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



end

