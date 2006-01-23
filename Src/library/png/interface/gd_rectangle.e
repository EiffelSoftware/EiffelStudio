indexing
	description: "Rectangle"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GD_RECTANGLE

inherit
	GD_COLORABLE

	GD_FIGURE

creation
	make

feature -- Initialization

	make (im: GD_IMAGE;a_color_index:INTEGER; x1,y1,x2,y2: INTEGER) is
		do
			image := im
			color_index := a_color_index
			upper_left_x := x1
			upper_left_y := y1
			bottom_right_x := x2
			bottom_right_y := y2
		end

feature -- Drawing

	draw_border is
			-- Draw a rectangle thanks to upper_left and bottom_right coordinates. 
		do
			gdImageRectangle(image,x1,y1,x2,y2,color_index)	
		end	

feature -- Implementation

	upper_left_x, upper_left_y: INTEGER
	
	bottom_right_x, bottom_right_y: INTEGER

feature {NONE} -- Externals

	gdImageRectangle(p: POINTER; x1,y1,x2,y2: INTEGER; color_index: INTEGER) is
		external
			"c"
		alias
			"gdImageRectangle"
		end

invariant
	point1_inside_the_image:image.coordinates_within_the_image(upper_left_x,upper_left_y)
	point2_inside_the_image:image.coordinates_within_the_image(bottom_right_x,bottom_right_y)
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GD_RECTANGLE
