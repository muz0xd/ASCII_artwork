class DrawPrimitives
  def self.cell(data_matrix, background, x, y, symbol = '.', options = {})
    default_options = {clean: false}
    options = default_options.merge(options)
    
    if options[:clean] then symbol = background end
    if (0...data_matrix[0].size) === x && (0...data_matrix.size) === y
      data_matrix[y][x] = symbol
    end
  end

  def self.line(data_matrix, background, point_0 = {x: nil, y: nil},
                point_1 = {x: nil, y: nil}, symbol  = '@', options = {})

    default_options = {clean: false}
    options = default_options.merge(options)
 
    x0, y0, x1, y1 = point_0[:x], point_0[:y], point_1[:x], point_1[:y]
    return unless x0 && y0 && x1 && y1
 
    delta_x = (x1 - x0).abs
    delta_y = (y1 - y0).abs
    sign_x  = x0 < x1 ? 1 : -1
    sign_y  = y0 < y1 ? 1 : -1
 
    error = delta_x - delta_y
 
    self.cell(data_matrix, background, x1, y1, symbol, options)
    while(x0 != x1 || y0 != y1)
      self.cell(data_matrix, background, x0, y0, symbol, options)
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

  def self.circle(data_matrix, background, point = {x: nil, y: nil},
                  radius = nil, symbol = '@', options = {})
                  
    default_options = {clean: false}
    options = default_options.merge(options)
                  
    x0, y0 = point[:x], point[:y]
    return unless x0 && y0 && radius
 
    x = 0
    y = radius
    delta = 2 - 2 * radius
    error = 0
 
    while(y >= 0)
      self.cell(data_matrix, background, x0 + x, y0 + y, symbol, options)
      self.cell(data_matrix, background, x0 + x, y0 - y, symbol, options)
      self.cell(data_matrix, background, x0 - x, y0 + y, symbol, options)
      self.cell(data_matrix, background, x0 - x, y0 - y, symbol, options)
 
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
end
