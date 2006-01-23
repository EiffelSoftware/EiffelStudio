indexing
	description: "Ellipse"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GD_ELLIPSE
	
inherit
	GD_ARC
		rename
			make as arc_make
		redefine
			draw_border
		end

	GD_FILLABLE
		rename
			fill_closed_figure as fill_ellipse,
			x as center_x,
			y as center_y
		end

create
	make

feature -- Initialization

	make(im: GD_IMAGE;a_color_index:INTEGER;x1,y1,a_width,a_height: INTEGER) is
			-- Initialization
		do
			arc_make(im,a_color_index,x1,y1,a_width,a_height,0,360)
		end

feature -- Drawing

	draw_border is
			-- Draw on image 'im' with color corresponding to 'color_index'.
		do
			gdImageArc(image.image,center_x,center_y,width,height,0,360,color_index)
		end

	draw_plain_ellipse(col: INTEGER) is
			-- Draw the ellipse and fill it with color 'col'.
		do
			draw_border
			fill_ellipse(col)			
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






end -- class GD_ELLIPSE
