indexing
	description: "Polyline"
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

creation
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

feature -- Implementation
	
	points: ARRAY[TUPLE[INTEGER,INTEGER]]
		-- points which constitue the polyline figure.

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
end -- class GD_POLYLINE
