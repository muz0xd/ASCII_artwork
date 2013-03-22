require '../lib/ASCII_artwork'

cvs = Canvas.new 64, 32, '.'
interpolation_points_1 = [{x: 0, y: 12}, {x: 5, y: 6}, {x: 13, y: 2}, 
                          {x: 16, y: 1}, {x: 23, y: 0}, {x: 28, y: 1},
                          {x: 29, y: 2}]

interpolation_points_2 = [{x: 0, y: 12}, {x: 1, y: 13}, {x: 5, y: 14}, 
                          {x: 13, y: 13}, {x: 16, y: 12}, {x: 24, y: 8},
                          {x: 29, y: 2}]

                        
cvs.draw_cubicspline(interpolation_points_1, '#')
cvs.draw_cubicspline(interpolation_points_2, '#')



                          
interpolation_points_5 = [{x: 0, y: 18} , {x: 6, y: 22}, {x: 17, y: 21}, {x: 24, y: 19},  {x: 31, y: 16}, {x: 33, y: 15},
                          {x: 38, y: 12}, {x: 44, y: 4}]
                                

cvs.draw_cubicspline(interpolation_points_5, '#')

cvs.p_console
cvs.p_file("exmpl_2.bmp")
