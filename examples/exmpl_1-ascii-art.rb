require '../lib/ASCII_artwork'

cvs = Canvas.new 61, 61, ' '

cvs.line_set({x: 30, y: 60}, {x: 0, y: 30}, "#")
cvs.line_set({x: 30, y: 60}, {x: 20, y: 30}, '#')
cvs.line_set({x: 30, y: 60}, {x: 40, y: 30}, '#')
cvs.line_set({x: 30, y: 60}, {x: 60, y: 30}, '#')

cvs.line_set({x: 0, y: 30}, {x: 60, y: 30}, '#')

cvs.line_set({x: 0, y: 30}, {x: 10, y: 15}, "#")
cvs.line_set({x: 20, y: 30}, {x: 10, y: 15}, '#')
cvs.line_set({x: 20, y: 30}, {x: 30, y: 15}, '#')
cvs.line_set({x: 40, y: 30}, {x: 30, y: 15}, '#')
cvs.line_set({x: 40, y: 30}, {x: 50, y: 15}, '#')
cvs.line_set({x: 60, y: 30}, {x: 50, y: 15}, '#')

cvs.line_set({x: 10, y: 15}, {x: 50, y: 15}, '#')

cvs.p_console
cvs.p_file("exmpl_1.bmp")
