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

	make(im: GD_IMAGE;a_color_index:INTEGER;x,y,a_width,a_height,deg_start,deg_end: INTEGER) is
		do
			center_x := x
			center_y := y
			width := a_width
			height := a_height
			starting_deg := deg_start
			ending_deg := deg_end
			image := im
			color_index := a_color_index
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
			gdImageArc(image.image,center_x,center_y,width,
					   height,starting_deg,ending_deg,color_index)
		end

feature {NONE} -- Implementation

	center_x,center_y: INTEGER
		-- Coordinates of Current

	width,height: INTEGER
		-- Width of Current

	starting_deg, ending_deg: INTEGER
		-- Degree where the arc initiates, and where it ends.

feature {NONE} -- Externals

	gdImageArc(p: POINTER; x,y,ellipse_width,ellipse_height,starting_angle,ending_angle,col_index: INTEGER) is
		external
			"c"
		alias
			"gdImageArc"
		end

invariant
	color_index_possible: color_index >=0 and color_index <=255 and then 
								  color_index <= image.color_index_bound

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
