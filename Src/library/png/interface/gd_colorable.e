indexing
	description: "Object which is colorable"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GD_COLORABLE

feature {NONE} -- Implementation
	
	color_index: INTEGER

	image: GD_IMAGE is deferred end
		
invariant
	color_index_large_enough: color_index >=0 
	color_index_enough_enough: color_index <=255 
	image_exists: image /= Void
	index_possible: color_index <= image.color_index_bound

end -- class GD_COLORABLE
