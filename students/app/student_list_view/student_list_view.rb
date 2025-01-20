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

    filter_frame = FXVerticalFrame.new(main_frame, FRAME_SUNKEN | LAYOUT_FILL_Y | LAYOUT_FIX_WIDTH, width: 200)
    draw_filtration(filter_frame)

    
    table_frame = FXVerticalFrame.new(main_frame, FRAME_SUNKEN | LAYOUT_FILL_X | LAYOUT_FILL_Y)
    draw_table(table_frame)


    button_frame = FXVerticalFrame.new(main_frame, FRAME_SUNKEN | LAYOUT_FILL_Y | LAYOUT_FIX_WIDTH, width: 150)
    
    draw_buttons(button_frame)

    update_table_data()

  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  private def draw_filtration(filter_frame)
    FXLabel.new(filter_frame, "Фамилия и инициалы:")
    FXTextField.new(filter_frame, 20, nil, 0, TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    add_filter_section(filter_frame, "Git")

    add_filter_section(filter_frame, "Почта")

    add_filter_section(filter_frame, "Телефон")

    add_filter_section(filter_frame, "Telegram")

    FXButton.new(filter_frame, "Сбросить", opts: BUTTON_NORMAL)

  end

  private def add_filter_section(parent, label_text)
    section_frame = FXVerticalFrame.new(parent, LAYOUT_FILL_X | LAYOUT_FIX_HEIGHT | FRAME_THICK, height: 80)
    FXLabel.new(section_frame, label_text)
  
    combo_box = FXComboBox.new(section_frame, 3, nil, 0, COMBOBOX_STATIC | LAYOUT_FILL_X)
    combo_box.numVisible = 3
    combo_box.appendItem("Не важно")
    combo_box.appendItem("Да")
    combo_box.appendItem("Нет")
    combo_box.setCurrentItem(0) 
  
    input_field = FXTextField.new(section_frame, 20, opts: TEXTFIELD_NORMAL | LAYOUT_FILL_X)
    input_field.hide

    combo_box.connect(SEL_COMMAND) do
      case combo_box.currentItem
      when 1
        input_field.show
      else
        input_field.hide
      end
      section_frame.recalc
    end

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

    @prev_button.connect(SEL_COMMAND) {change_page(-1)}
    @next_button.connect(SEL_COMMAND) {change_page(1)}

  end

  private def update_table_data()
    (0...@items_per_page).each do |row|
      @table.setItemText(row, 0, "test")
      @table.setItemText(row, 1, '1')
      @table.setItemText(row, 2, '2')
      @table.setItemText(row, 3, '3')
    end
  
    @page_index.setText("#{@current_page + 1} / #{@total_pages}")
  end

  private def change_page(offset)
    new_page = @current_page + offset
    return if new_page < 0 || new_page >= @total_pages
    @current_page = new_page
    update_table_data()
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

