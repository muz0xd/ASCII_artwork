class Canvas
  def initialize(width, height, background)
    @width, @height, @background = width, height, background
    @data_matrix = Array.new(height) { Array.new(width) {background} }
  end
 
  def draw_cell(x, y, symbol = '.', options = {})
    DrawPrimitives::cell(@data_matrix, @background, x, y, symbol, options)
  end
 
  def draw_line(point_0 = {x: nil, y: nil}, point_1 = {x: nil, y: nil},
                symbol  = '@', options = {})

    DrawPrimitives::line(@data_matrix, @background, point_0, point_1, symbol,
                         options)
  end
 
  def draw_circle(point = {x: nil, y: nil}, radius = nil, symbol = '@', 
                  options = {})

    DrawPrimitives::circle(@data_matrix, @background, point, radius, symbol,
                           options)
  end
  
  def p_console
    @data_matrix.each do |line|
      line.each {|symbol| print symbol}
      puts
    end
  end
 
  def p_file(filename, options = {})
    default_options = {foreground: "000000", background: "ffffff", random: false}
    options = default_options.merge(options)

    bmp = BMP::Writer.new(@width, @height)
    @data_matrix.each_with_index do |line, i|
      line.each_with_index do |symbol, j|
        bmp[j, i] = if symbol == @background
          if options[:random]
            random_background_color
          else
            options[:background]
          end
        else
          options[:foreground]
        end
      end
    end
    bmp.save_as(filename)
  end
 
  def scale!(scale = 1)
    old_data_matrix = @data_matrix

    @width = @width * scale
    @height = @height * scale
    @data_matrix = Array.new(@height) { Array.new(@width) {@background} }

    @data_matrix.each_with_index do |line, i|
      line.each_with_index do |symbol, j|
        original_i = i / scale
        original_j = j / scale
        original_symbol = old_data_matrix[original_i][original_j]
        cell_set(j, i, original_symbol)
      end
    end
    self
  end
end
