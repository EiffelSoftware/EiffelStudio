indexing
	description: "Arc"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GD_ARC

inherit
	
	GD_COLORABLE

	GD_FIGURE

create
	make

feature -- Initialization

	make(im: GD_IMAGE;a_x,a_y,a_width,a_height,deg_start,deg_end: INTEGER) is
		do
			initialize_figure(im)
			set_x_y(a_x,a_y)
			width := a_width
			height := a_height
			starting_deg := deg_start
			ending_deg := deg_end
		end

feature -- Drawing

	draw_border is
			-- Draw on image 'image' with color corresponding to 'color_index'.
			-- gdImageArc is used to draw a partial ellipse centered at the given point,
			-- with the specified width and height in pixels. The arc begins at the position 
			-- in degrees specified by starting_deg and ends at the position specified by 
			-- ending_deg. The arc is drawn in the color specified by the last argument. 
			--Values greater than 360 are interpreted modulo 360. 
		do
			gdImageArc(image.image,x,y,width,
					   height,starting_deg,ending_deg,color_index)
		end

feature {NONE} -- Implementation

	width,height: INTEGER
		-- Width of Current

	starting_deg, ending_deg: INTEGER
		-- Degree where the arc initiates, and where it ends.

feature {NONE} -- Externals

	gdImageArc(p: POINTER; a_x,a_y,ellipse_width,ellipse_height,starting_angle,ending_angle,col_index: INTEGER) is
		external
			"c"
		alias
			"gdImageArc"
		end

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






end -- class GD_ARC
