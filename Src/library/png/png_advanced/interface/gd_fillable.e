indexing
	description: "Fillable figure"
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

end -- class GD_FILLABLE
