indexing
	description: "Object which is colorable"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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






end -- class GD_COLORABLE
