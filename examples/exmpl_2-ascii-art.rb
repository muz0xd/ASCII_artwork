require '../lib/ASCII_artwork'

cvs = Canvas.new 64, 16, '.'
interpolation_points = [{x: 0, y: 5}, {x: 15, y: 11}, {x: 31, y: 5}, 
                        {x: 47, y: 11}, {x: 63, y: 5}]
cvs.draw_cubicspline(interpolation_points, '#')

cvs.p_console
cvs.p_file("exmpl_2.bmp")
