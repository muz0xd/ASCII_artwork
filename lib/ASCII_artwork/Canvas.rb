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
 
  def line_set (k0 = {x: nil, y: nil}, k1 ={x: nil, y: nil} ,
                  symbol = '@', clean = false)
    
    if k0.include?(nil) || k1.include?(nil) || k0.length != 2 || k1.length != 2
      return
    end
    
    steep = (k1[:y] - k0[:y]).abs > (k1[:x] - k0[:x]).abs
    if steep
      k0[:x], k0[:y] = k0[:y], k0[:x]
      k1[:x], k1[:y] = k1[:y], k1[:x]
    end
    if k0[:x] > k1[:x]
      k0[:x], k1[:x] = k1[:x], k0[:x]
      k0[:y], k1[:y] = k1[:y], k0[:y]
    end
    deltax = k1[:x] - k0[:x]
    deltay = (k1[:y] - k0[:y]).abs
    error = (deltax/2).to_i
    y = k0[:y]
    k0[:y] < k1[:y] ? ystep = 1 : ystep = -1
    (k0[:x]..k1[:x]).each do |x|
      if clean
        steep ? cell_set(y, x, symbol, true) : cell_set(x, y, symbol, true)
      else
        steep ? cell_set(y, x, symbol) : cell_set(x, y, symbol)
      end
      error -= deltay
      if error < 0
        y += ystep
        error += deltax
      end
    end
  end
  
  def p_console
    @data_matrix.each do |line|
      line.each {|symbol| print symbol}
      puts
    end
  end
  
  def p_file(filename)
    bmp = BMP::Writer.new(@width, @height)
    @data_matrix.each_with_index do |line, i|
      line.each_with_index do |symbol, j|
        bmp[j, i] = symbol == @background ? "ffffff" : "000000"
      end
    end
    bmp.save_as(filename)
  end
end
