require '../lib/ASCII_artwork'

cvs = Canvas.new 96, 23, ' '
interpolation_points_1 = [{x: 0, y: 12}, {x: 5, y: 6}, {x: 13, y: 2}, 
                          {x: 16, y: 1}, {x: 23, y: 0}, {x: 28, y: 1},
                          {x: 29, y: 2}]

interpolation_points_2 = [{x: 0, y: 12}, {x: 1, y: 13}, {x: 5, y: 14}, 
                          {x: 13, y: 13}, {x: 16, y: 12}, {x: 24, y: 8},
                          {x: 29, y: 2}]

                        
cvs.draw_cubicspline(interpolation_points_1, '#')
cvs.draw_cubicspline(interpolation_points_2, '#')


interpolation_points_4 = [{x: 28, y: 1}, {x: 37, y: 0}, {x: 44, y: 4}]
                          
interpolation_points_5 = [{x: 0, y: 18} , {x: 6, y: 22}, {x: 17, y: 21},
                          {x: 24, y: 19}, {x: 29, y: 17}, {x: 33, y: 15},
                          {x: 38, y: 12}, {x: 44, y: 5}]
                                

cvs.draw_cubicspline(interpolation_points_4, '#')
cvs.draw_cubicspline(interpolation_points_5, '#')
cvs.draw_line({x: 0, y: 18} , {x: 0, y: 15}, '#')



cvs.draw_line({x: 16, y: 22} , {x: 42, y: 18}, '#')
cvs.draw_line({x: 44, y: 5} , {x: 42, y: 18}, '#')


cvs.draw_line({x: 0, y: 14} , {x: 15, y: 21}, '#')
cvs.draw_line({x: 15, y: 21} , {x: 20, y: 10}, '#')
cvs.draw_line({x: 20, y: 12} , {x: 36, y: 12}, '#')
cvs.draw_line({x: 28, y: 4} , {x: 37, y: 13}, '#')
cvs.draw_line({x: 28, y: 4} , {x: 40, y: 2}, '#')

cvs.draw_cell({x: 29, y: 3}, '#')

cvs.p_console

