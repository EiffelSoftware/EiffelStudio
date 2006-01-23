indexing
	description: "Fillable figure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf" 
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GD_FILLABLE

inherit

	GD_COLORABLE

feature -- Actions

	fill_closed_figure (red,green,blue: INTEGER ) is
		-- It floods a portion of the image with the specified color_index,
		-- beginning at the specified point and stopping at the specified border color.
		require
			red_possible: red >=0 and red <256
			green_possible: green >=0 and green <256
			blue_possible: blue >=0 and blue < 256
			background_color_allocated: image.background_color_allocated
		local
			ind: INTEGER
		do
			ind := image.color(red,green,blue)
			gdimagefilltoborder(image.image, x,y,color_index, ind)
		end

	x,y: INTEGER is deferred end
		-- Point within Current Current.

	image: GD_IMAGE is deferred end
		-- Image Current applies to.

feature {NONE} -- Externals

	gdimagefilltoborder(p: POINTER; x1,y1, stopping_color, color_ind: INTEGER) is
		external
			"c"
		alias
			"gdImageFillToBorder"
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






end -- class GD_FILLABLE
