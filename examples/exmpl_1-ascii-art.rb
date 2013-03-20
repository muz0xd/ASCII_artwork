require '../lib/ASCII_artwork'

cvs = Canvas.new 61, 61, ' '

cvs.draw_line({x: 30, y: 60}, {x: 0, y: 30}, "#")
cvs.draw_line({x: 30, y: 60}, {x: 20, y: 30}, '#')
cvs.draw_line({x: 30, y: 60}, {x: 40, y: 30}, '#')
cvs.draw_line({x: 30, y: 60}, {x: 60, y: 30}, '#')

cvs.draw_line({x: 0, y: 30}, {x: 60, y: 30}, '#')

cvs.draw_line({x: 0, y: 30}, {x: 10, y: 15}, "#")
cvs.draw_line({x: 20, y: 30}, {x: 10, y: 15}, '#')
cvs.draw_line({x: 20, y: 30}, {x: 30, y: 15}, '#')
cvs.draw_line({x: 40, y: 30}, {x: 30, y: 15}, '#')
cvs.draw_line({x: 40, y: 30}, {x: 50, y: 15}, '#')
cvs.draw_line({x: 60, y: 30}, {x: 50, y: 15}, '#')

cvs.draw_line({x: 10, y: 15}, {x: 50, y: 15}, '#')

#cvs.draw_circle({x: 10, y: 15}, 5, "E")

cvs.p_console
cvs.p_file("exmpl_1.bmp")
