indexing
	description: "Color Facilities relative to a GD-image."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GD_COLOR_PROPERTIES

feature -- Access

	color(red,green,blue: INTEGER):INTEGER is
			-- Index of Color obtained in rgb mode for Current Image.
		require
			red_possible: red >=0 and red <256
			green_possible: green >=0 and green <256
			blue_possible: blue >=0 and blue < 256
			background_color_allocated: background_color_allocated
		do
			Result := c_get_color_exact(image,red,green, blue)
			if Result <0 then
				Result := gdimagecolorallocate (image, red,green,blue )
			end
		ensure
			result_possible: Result >= 0
		end

	color_index_of (r,g,b: INTEGER): INTEGER is
		--It  searches the colors which have been defined thus far in the image 
		-- specified and returns the index of the first color with RGB values
		-- which exactly match those of the request. 
		--If no allocated color matches the request precisely, 
		-- it will return -1gdImageColorExact returns -1.
		require
			rgb_possibles: r>=0 and r<256 and g>=0 and g<256 and b>=0 and b<256
		do
			Result := gdImageColorAllocate(image, r,g,b )
		end

	has_color (r,g,b: INTEGER): BOOLEAN is
		-- Does current image palette contains the color defined with r,g,b ?
			require
			rgb_possibles: r>=0 and r<256 and g>=0 and g<256 and b>=0 and b<256
		do
			Result := (gdImageColorAllocate(image, r,g,b )/=-1)
		end

	color_index_bound: INTEGER is
		-- Return the number of color indexes currently associated with the image.
		do
			Result := c_image_color_total(image)
		end

feature -- Settings

	set_background_color(r,g,b: INTEGER) is
		-- Set the background color of Current.
		-- This has to be set before any other color operations.
		do
			background_color_index := gdImageColorAllocate(image, r,g,b )
			if background_color_index/=-1 then
				background_color_allocated := TRUE
			end
		end

feature -- Implementation
	
	image: POINTER is deferred end
		-- Image Current is relative to.

	background_color_allocated: BOOLEAN
		-- Background Color Index of Current image.

	background_color_index: INTEGER
		-- Index of the background color

feature {NONE} -- Externals

    gdImageColorAllocate(p: POINTER; red,green,blue: INTEGER): INTEGER is
		external
			"c"
		alias
			"gdImageColorAllocate"
		end

	c_get_color_exact (p: POINTER; r,g,b: INTEGER):INTEGER is
		external
			"c"
		alias
			"gdImageColorExact"
		end

	c_image_color_total (p: POINTER): INTEGER is
		external	
			"c[macro <eiffel_png.h>]"
		alias
			"c_get_colors_total"
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






end -- class GD_COLOR_PROPERTIES
