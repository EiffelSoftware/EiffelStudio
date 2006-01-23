indexing
	description: "Poylgon"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GD_POLYGON

inherit
	GD_POLYLINE
		rename
			draw_lines as draw_polygon
		redefine
			draw_poylgon
		end

	GD_FILLABLE
		rename
			fill_closed_figure as fill_polygon
		redefine
			fill_polygon
		end

create
	 make

feature -- Drawing

	draw_polygon is
		-- Draw 	
		local
			gp1,gp2: TUPLE[INTEGER,INTEGER]
		do
			precursor
			gp1 := points.item(points.count)
			gp2 := points.item(1)
			gdImageLine(image.image, gp1.integer_item(1),gp1,integer_item(2),
						gp2.integer_item(1), gp2.integer_item(2), color_index)			
		end

	fill_polygon(r,g,b: INTEGER) is
		--Fill Polygon with color (r,g,b)
		do
			ind := color(r,g,b)
			--gdimagefillto_border()
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






end -- class GD_POLYGON
