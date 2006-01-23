indexing
	description: "Object which is colorable"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GD_COLORABLE


feature -- Settings

	set_color(red,green,blue: INTEGER) is
			-- Set color defined by the rgb 3-tuple 
			-- (red,green,blue).	
		require
			red_possible: red >=0 and red <256
			green_possible: green >=0 and green <256
			blue_possible: blue >=0 and blue < 256
			background_color_allocated: image.background_color_allocated
		do
			internal_color_index := 	color(red,green,blue)
		ensure
			possible: color_index>=0
		end

	set_color_transparent(red,green,blue: INTEGER) is
			-- Set color transparent to the one defined by the rgb 3-tuple 
			-- (red,green,blue).	
		require
			red_possible: red >=0 and red <256
			green_possible: green >=0 and green <256
			blue_possible: blue >=0 and blue < 256
			background_color_allocated: image.background_color_allocated
		local
			col: INTEGER
		do
			col := color(red,green,blue)
			if col>0 then
				gdImageColorTransparent(image.image, col)
			end
		end

feature -- Access

	color(red,green,blue: INTEGER):INTEGER is
			-- Index of Color obtained in rgb mode for Current Image.
		require
			red_possible: red >=0 and red <256
			green_possible: green >=0 and green <256
			blue_possible: blue >=0 and blue < 256
			background_color_allocated: image.background_color_allocated
		do
			Result := c_get_color_exact(image.image,red,green, blue)
			if Result <0 then
				Result := gdimagecolorallocate (image.image, red,green,blue )
			end
		ensure
			result_possible: Result >= 0
		end

feature -- Access

	color_index: INTEGER is
			-- Return the color index corresponding to the 
			-- color Currrent is going to be draw in.
		do
			if internal_color_index >0 then
				Result := internal_color_index 
			else
				Result := image.background_color_index
			end
		end
	
	image: GD_IMAGE is deferred end

feature {NONE} -- Implementation
	
	internal_color_index: INTEGER
		
feature {NONE} -- Externals

	c_get_color_exact (p: POINTER; r,g,b: INTEGER):INTEGER is
		external
			"c"
		alias
			"gdImageColorExact"
		end

   gdImageColorAllocate(p: POINTER; red,green,blue: INTEGER): INTEGER is
		external
			"c"
		alias
			"gdImageColorAllocate"
		end

   gdImageColorTransparent(im:POINTER; col: INTEGER)  is
		external
			"C"
		alias
			"gdImageColorTransparent"
		end

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
