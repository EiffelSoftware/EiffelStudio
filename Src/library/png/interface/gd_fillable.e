indexing
	description: "Fillable figure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GD_FILLABLE

feature -- Actions

	fill_closed_figure (col_index: INTEGER ) is
		-- gdImageFillToBorder floods a portion of the image with the specified color_index,
		--beginning at the specified point and stopping at the specified border color.
		require
			color_index_possible: col_index >=0 and 
									col_index <=255 and then 
									col_index <= image.color_index_bound
		do
			gdimagefilltoborder(image.image, x,y,color_index, col_index )
		end

	draw_border is deferred end

	x,y: INTEGER is deferred end
		-- Point within Current Current.

	color_index: INTEGER is deferred end
		-- Color index of Current

	image: GD_IMAGE is deferred end

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
