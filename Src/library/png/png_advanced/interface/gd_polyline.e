indexing
	description: "Polyline"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GD_POLYLINE

inherit
	GD_FIGURE
		rename
			draw_border as draw_lines
		end

	GD_COLORABLE

create
	make

feature -- Initialization

	make(im: GD_IMAGE; point_array: ARRAY[TUPLE[INTEGER,INTEGER]]) is
		-- Create image with points 'point_array'.
		require
			image_exists: im /= Void
			at_least_one_line: point_array.count>0
			points_with_the_image: im.points_within_the_image(point_array)
		do
			initialize_figure(im)
			set_x_y(point_array.item(1).integer_item(1),
					point_array.item(2).integer_item(2))
			points:= point_array
		ensure
			set: image = im and point_array = points
		end

feature -- Drawing

	draw_lines is
			-- Draw lines
		local
			i: INTEGER
			gp1,gp2: TUPLE[INTEGER,INTEGER]
		do
			from
				i := 2
			until
				i > points.count
			loop
				gp1 := points.item (i-1)
				gp2 := points.item (i)
				gdimageline (image.image,gp1.integer_item(1),gp1.integer_item(2),
								   gp2.integer_item(1),gp2.integer_item(2),
								   color_index) 
				i := i+1	
			end
		end

feature -- Settings

	set_style(a_style: INTEGER) is
		do

		end

feature -- Implementation
	
	points: ARRAY[TUPLE[INTEGER,INTEGER]]
		-- points which constitute the polyline figure.

	style: INTEGER
		-- Style Current is going to be drawn.
		-- Please refer to class 'GD_STYLES'

feature {NONE} -- Externals

	 gdImageLine(p: POINTER; x1,y1,x2,y2: INTEGER; a_color_index: INTEGER) is
		external
			"c"
		alias
			"gdImageLine"
		end

invariant
	at_least_one_line: points.count>0
	points_with_the_image: image.points_within_the_image(points)
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






end -- class GD_POLYLINE
