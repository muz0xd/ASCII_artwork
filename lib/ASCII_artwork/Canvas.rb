class Canvas
  def initialize(width, height, background)
    @width, @height, @background = width, height, background
    @data_matrix = Array.new(height) { Array.new(width) {background} }
  end
 
  def cell_set(x, y, symbol = '.', clean = false)
    if clean then symbol = @background end
    if (0...@width) === x && (0...@height) === y
      @data_matrix[y][x] = symbol
    end
  end
 
  def line_set (point_0 = {x: nil, y: nil},
                point_1 = {x: nil, y: nil},
                symbol  = '@', clean = false)
 
    x0, y0, x1, y1 = point_0[:x], point_0[:y], point_1[:x], point_1[:y]
    return unless x0 && y0 && x1 && y1
 
    delta_x = (x1 - x0).abs
    delta_y = (y1 - y0).abs
    sign_x  = x0 < x1 ? 1 : -1
    sign_y  = y0 < y1 ? 1 : -1
 
    error = delta_x - delta_y
 
    cell_set(x1, y1, symbol, clean)
    while(x0 != x1 || y0 != y1)
      cell_set(x0, y0, symbol, clean)
      tmp_error = error * 2
 
      if tmp_error > -delta_y
        error -= delta_y
        x0 += sign_x
      end
 
      if tmp_error < delta_x
        error += delta_x
        y0 += sign_y
      end
    end
  end
 
  def circle_set(point = {x: nil, y: nil}, radius = nil, symbol = '@', 
                  clean = false)
                  
    x0, y0 = point[:x], point[:y]
    return unless x0 && y0 && radius
 
    x = 0
    y = radius
    delta = 2 - 2 * radius
    error = 0
 
    while(y >= 0)
      cell_set(x0 + x, y0 + y, symbol, clean)
      cell_set(x0 + x, y0 - y, symbol, clean)
      cell_set(x0 - x, y0 + y, symbol, clean)
      cell_set(x0 - x, y0 - y, symbol, clean)
 
      error = 2 * (delta + y) - 1
      if(delta < 0 && error <= 0)
        x += 1
        delta += 2 * x + 1
        next
      end
 
      error = 2 * (delta - x) - 1
      if(delta > 0 && error > 0)
        y -= 1
        delta += 1 - 2 * y
        next
      end
 
      x += 1
      delta += 2 * (x - y)
      y -= 1
    end
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
