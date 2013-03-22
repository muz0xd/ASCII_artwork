class DrawPrimitives
  def self.cell(data_matrix, background, point = {x: nil, y: nil}, symbol = '.',
                options = {})
    default_options = {clean: false}
    options = default_options.merge(options)
    
    if options[:clean] then symbol = background end
    if (0...data_matrix[0].size) === point[:x] &&
       (0...data_matrix.size) === point[:y]
      data_matrix[point[:y]][point[:x]] = symbol
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
 
    self.cell(data_matrix, background, {x: x1, y: y1}, symbol, options)
    while(x0 != x1 || y0 != y1)
      self.cell(data_matrix, background, {x: x0, y: y0}, symbol, options)
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
      self.cell(data_matrix, background, {x: x0 + x, y: y0 + y}, symbol, options)
      self.cell(data_matrix, background, {x: x0 + x, y: y0 - y}, symbol, options)
      self.cell(data_matrix, background, {x: x0 - x, y: y0 + y}, symbol, options)
      self.cell(data_matrix, background, {x: x0 - x, y: y0 - y}, symbol, options)
 
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

  def self.cubicspline(data_matrix, background,
                       points = [{x: nil, y: nil}, {x: nil, y: nil} ],
                       symbol = '@', options = {})

    default_options = {clean: false}
    options = default_options.merge(options)

    _h = points.size
    bo = (points[_h-1][:x] - points[0][:x] + 1).abs
    aM = Array.new(bo) {|i| points[0][:x] + i}
    bG = []
    bH = []
    points.each do |point|
      bG << point[:x]
      bH << point[:y]
    end

    _l = _h;
    _o = Array.new(_h)
    _t = Array.new(_h)
    _g = Array.new(_h)
    ap = Array.new(bo)
    bm = Array.new(bo)
    t =  Array.new(2)
    t[0] = Array.new(_h)
    t[1] = Array.new(_h)
    _next = Array.new(2)
    _f = 1
    _c = _j = 0

    for i in 0...bo
      ap[_j] = aM[_j]
      _j += 1
    end

    _v=0;

    for i in 0..._l
      v = (bG[_v]).to_f
      bP = (bH[_v]).to_f
      _v+=1

      unless (v.nan? && bP.nan?)
        _o[i] = v
        _t[i] = bP
      end
    end

    _k=1

    for i in 0..._l-1
      t[0][_k] = _o[_k] - _o[i]
      t[1][_k] = (_t[_k] - _t[i]) / t[0][_k]
      _k+=1    
    end

    if _l == 2
      t[1][0] = t[0][0] = 1.0
      _g[0] = 2.0 * t[1][1]
    else
      v = l = t[0][1]
      t[1][0] = t[0][2]
      t[0][0] = v + t[0][2]
      l *= l * t[1][2]
      _g[0] = ((v + 2.0 * t[0][0]) * t[1][1] * t[0][2] + l) / t[0][0]
    end

    ab=_l-1

    for i in 1...ab
      v = -(t[0][i+1] / t[1][i-1])
      _g[i] = v * _g[i-1] + 3.0 * (t[0][i] * t[1][i+1] + t[0][i+1] * t[1][i])
      t[1][i] = v * t[0][i-1] + 2.0 * (t[0][i] + t[0][i+1])
    end

    if _l == 2
      _g[1] = t[1][1]
    else
      if _l == 3
        _g[2] = 2.0 * t[1][2]
        t[1][2] = 1.0
        v= -(1.0 / t[1][1])
      else
        v = t[0][_l-2] + t[0][_l-1]
        l = t[0][_l-1] * t[0][_l-1] * (_t[_l-2] - _t[_l-3])
        l /= t[0][_l-2]
        _g[_l-1] = ((t[0][_l-1] + 2.0 * v) * t[1][_l-1] * t[0][_l-2] + l) / v
        v = -(v / t[1][_l-2])
        t[1][_l-1] = t[0][_l-2]
      end
      t[1][_l-1] = v*t[0][_l-2] + t[1][_l-1]
      _g[_l-1] = (v*_g[_l-2] + _g[_l-1]) / t[1][_l-1]
    end
    
    (_l-2).downto(0) do |i| 
      _g[i] = (_g[i] - t[0][i] * _g[i + 1]) / t[1][i]
    end

    while _c < _j
      for _v in _c..._j
        if ap[_v] >= _o[_f] then break end
      end
      if _v < _j
        if _f == (_l-1) then _v = _j end
      end
      ab = _v - _c
      
      if ab > 0
        aR = h = _o[_f]-_o[_f-1]
        _next[1] = _next[0] = 0
        bM = 0.0
        aS = (_t[_f] - _t[_f-1]) / h
        bk = (_g[_f-1] - aS) / h
        bb = (_g[_f] - aS) / h
        ac = -(bk + bk + bb)
        bF = ac + ac
        _r = (bk + bb) / h
        aJ = _r + _r + _r
        
        for k in 0...ab
          l = ap[_c+k] - _o[_f-1]
          bm[_c+k] = _t[_f-1] + l * (_g[_f-1] + l * (ac + l * _r))
          if l < bM then _next[0] = _next[0] + 1 end
          if l > aR then _next[1] = _next[1] + 1 end
        end
        
        if (_next[0] > 0) && (_f != 1)
          for k in _c..._v
            if ap[k] < _o[_f-1] then break end
          end
          _v = k
          for k in 0..._f
            if ap[_v] < _o[k] then break end
          end
          _f = ((k-1) > 0) ? (k-1) : 0
        end
        _c = _v
      end
      _f += 1
      if _f >= _l then break end
    end

    bo.times do |i|
      self.cell(data_matrix, background, {x: aM[i], y: bm[i].round}, symbol, options)
    end
  end  
end
