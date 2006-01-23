indexing
	description: "Gif Image"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GIF_IMAGE

inherit
	DISPOSABLE

	GIF_FONTS

create
	make,make_from_file

feature -- Initialization

	make(w,h: INTEGER) is
			-- Initialize the image with
			-- 'w' as width and 'h' as height.
		require
			width_possible: w > 0
			height_possible: h > 0
		do
			image := GdImageCreate (w,h)
		end

	make_from_file (file_name: FILE_NAME) is
			-- Load a GIF file, and store it into 'image'
		require
			file_name_possible: file_name /= Void and then file_name.is_valid
		local
			file: RAW_FILE
			fd_file: POINTER
		do
			create file.make_open_read(file_name)
			fd_file := file.file_pointer
			image := gdImageCreateFromGif(fd_file)
			file.close
		end

feature -- Basic Operations

	save_to_file (file_name: FILE_NAME) is
			-- Save Current to file.
		require
			file_name_possible: file_name /= Void and then file_name.is_valid
		local
			file: RAW_FILE
			fd_file: POINTER
		do
			create file.make_create_read_write(file_name)
			file.open_write
			fd_file := file.file_pointer
			gdimagegif(image, fd_file)
			file.close
		end

feature -- Access

	color(red,green,blue: INTEGER):INTEGER is
			-- Index of Color obtained in rgb mode for Current Image.
		require
			red_possible: red >=0 and red <256
			green_possible: green >=0 and green <256
			blue_possible: blue >=0 and blue < 256
		do
			Result := c_get_color_exact(image,red,green, blue)
			if Result <0 then
				Result := gdimagecolorallocate (image, red,green,blue )
			end
		ensure
			result_possible: Result >= 0
		end

	width: INTEGER is
		do
			Result := c_get_width ( image )
		end		

	height: INTEGER is
		do
			Result := c_get_height ( image )
		end

feature -- Validity of use for Current Image.

	coordinates_within_the_image(x,y: INTEGER): BOOLEAN is
			-- Does a point (x,y ) within the boundaries ?
		do
			Result := (gdImageBoundsSafe(image,x,y)=1)
		end
	
	points_within_the_image(array: ARRAY [GIF_POINT]): BOOLEAN is
			-- Are all the points of 'array' within the image ?
		require
			array_not_empty: array /= Void and then array.count>0
		local
			i: INTEGER
			gp: GIF_POINT
		do
			from
				i := 1
				Result := TRUE
			until
				i >= array.count or not Result
			loop
				gp := array.item (i)
				Result := coordinates_within_the_image(gp.get_x, gp.get_y ) 
				i := i+1	
			end
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

feature -- Drawing

	draw_string(s: STRING;x,y,gif_font,color_index: INTEGER) is 
		-- Draw_string is used to draw multiple characters on the image. 
		-- 's' is the string we want to display.
		-- x,y is the starting location the string begins.
		-- color_index is the index of the color we wish to use.
		-- 'gif_font' is the font we want to use.
		require
			coordinates_within_the_image:coordinates_within_the_image(x,y)
			string_exists: s /= Void
			color_index_possible: color_index >=0 and color_index <=255 and then color_index <= color_index_bound
			gif_font_possible: font_possible ( gif_font )
		local
			a: any
			p: POINTER
		do
			a := s.to_c
			p := font(gif_font)
			c_image_string(image, p,x,y, $a , color_index)	
		end 

	draw_line(x1,y1,x2,y2: INTEGER;color_index: INTEGER) is
			-- Draw a line
		require
			color_index_possible: color_index >=0 and color_index <=255 and then color_index <= color_index_bound
			point1_inside_the_image:coordinates_within_the_image(x1,y1)
			point2_inside_the_image:coordinates_within_the_image(x2,y2)
		do
			gdimageline ( image, x1,y1,x2,y2,color_index )
		end

	draw_dashed_line(x1,y1,x2,y2: INTEGER;color_index: INTEGER) is
			-- Draw a dashed line
		require
			color_index_possible: color_index >=0 and color_index <=255 and then color_index <= color_index_bound
			point1_inside_the_image:coordinates_within_the_image(x1,y1)
			point2_inside_the_image:coordinates_within_the_image(x2,y2)
		do
			gdimagedashedline ( image, x1,y1,x2,y2,color_index )
		end

	draw_polygon (array: ARRAY [GIF_POINT]; color_index: INTEGER) is
		require
			color_index_possible: color_index >=0 and color_index <=255 and then color_index <= color_index_bound
			at_least_two_elements: array.count > 1
			points_with_the_image: points_within_the_image(array)
		local
			i: INTEGER
			gp1,gp2: GIF_POINT
		do
			from
				i := 2
			until
				i > array.count
			loop
				gp1 := array.item (i-1)
				gp2 := array.item (i)
				draw_line(gp1.get_x,gp1.get_y,gp2.get_x,gp2.get_y,color_index) 
				i := i+1	
			end
			gp1 := array.item (1)
			draw_line(gp2.get_x,gp2.get_y,gp1.get_x,gp1.get_y,color_index) 
		end

	draw_ellipse (center_x,center_y,ellipse_width,ellipse_height,color_index:INTEGER) is
		require
			color_index_possible: color_index >=0 and color_index <=255 and then color_index <= color_index_bound
		do
			gdImageArc(image,center_x,center_y,ellipse_width,ellipse_height,0,360,color_index)
		end

	draw_rectangle (x1,y1,x2,y2,color_index: INTEGER) is
			-- Draw a rectangle with (x1,y1) and (x2,y2) the coords of 
			-- two of the opposite summits of the rectangle.
		require
			color_index_possible: color_index >=0 and color_index <=255 and then color_index <= color_index_bound
			point1_inside_the_image:coordinates_within_the_image(x1,y1)
			point2_inside_the_image:coordinates_within_the_image(x2,y2)
		do
			gdImageRectangle(image,x1,y1,x2,y2,color_index)	
		end

	draw_arc (center_x,center_y,arc_width,arc_height,starting_deg,ending_deg,color_index:INTEGER) is
			-- gdImageArc is used to draw a partial ellipse centered at the given point,
			-- with the specified width and height in pixels. The arc begins at the position 
			-- in degrees specified by starting_deg and ends at the position specified by 
			-- ending_deg. The arc is drawn in the color specified by the last argument. 
			--Values greater than 360 are interpreted modulo 360. 
		require
			color_index_possible: color_index >=0 and color_index <=255 and then color_index <= color_index_bound
			center_inside_the_image:coordinates_within_the_image(center_x,center_y)
		do
			gdImageArc(image,center_x,center_y,arc_width,arc_height,starting_deg,ending_deg,color_index)
		end

	fill_closed_figure ( x,y,border_color, color_index: INTEGER ) is
		-- gdImageFillToBorder floods a portion of the image with the specified color_index,
		--beginning at the specified point and stopping at the specified border color.
		require
			color_index_possible: color_index >=0 and color_index <=255 and then color_index <= color_index_bound
		do
			gdimagefilltoborder(image, x,y,border_color, color_index )
		end

feature {NONE} -- Implementation

	image: POINTER
		-- Pointer on the image structure.

	dispose is
			-- Remove C_struture associated with Current Image.
		do
			c_destroy_image(image)
		end

feature {NONE} -- Externals

	GdImageCreate (i,j: INTEGER):POINTER is
		external
			"C"
		alias
			"gdImageCreate"
		end

	c_destroy_image (p: POINTER)is
		external
			"C"
		alias
			"gdImageDestroy"
		end

	gdImageCreateFromGif (p: POINTER): POINTER is
		external
			"C"
		alias
			"gdImageCreateFromGif"
		end

       gdImageColorAllocate(p: POINTER; red,green,blue: INTEGER): INTEGER is
		external
			"c"
		alias
			"gdImageColorAllocate"
		end

       gdImageLine(p: POINTER; x1,y1,x2,y2: INTEGER; color_index: INTEGER) is
		external
			"c"
		alias
			"gdImageLine"
		end

	gdImageDashedLine(p: POINTER; x1,y1,x2,y2: INTEGER; color_index: INTEGER) is
		external
			"c"
		alias
			"gdImageDashedLine"
		end

	gdImageRectangle(p: POINTER; x1,y1,x2,y2: INTEGER; color_index: INTEGER) is
		external
			"c"
		alias
			"gdImageRectangle"
		end

	gdImageArc(p: POINTER; x,y,ellipse_width,ellipse_height,starting_angle,ending_angle,color_index: INTEGER) is
		external
			"c"
		alias
			"gdImageArc"
		end


	gdImageGif(p: POINTER; f: POINTER) is
		external
			"c"
		alias
			"gdImageGif"
		end

	gdimagefilltoborder(p: POINTER; x,y, stopping_color, color_index: INTEGER) is
		external
			"c"
		alias
			"gdImageFillToBorder"
		end

	c_pixel_color_index(p: POINTER; x,y: INTEGER):INTEGER is
		external
			"c"
		alias
			"gdImageGetPixel"
		end

	gdImageBoundsSafe(p: POINTER; x,y: INTEGER):INTEGER is
		external
			"c"
		alias
			"gdImageBoundsSafe"
		end

	c_get_height (p: POINTER ): INTEGER is
		external
			"c[macro <gif_library.h>]"
		end

	c_get_width (p: POINTER ): INTEGER is
		external
			"c[macro <gif_library.h>]"
		end
	
	c_get_color_exact (p: POINTER; r,g,b: INTEGER):INTEGER is
		external
			"c"
		alias
			"gdImageColorExact"
		end

	c_image_string (p,f: POINTER; i1,i2: INTEGER; s: POINTER; color_index: INTEGER) is
		external
			"c"
		alias
			"gdImageString"
		end

	c_image_color_total (p: POINTER): INTEGER is
		external	
			"c[macro <gif_library.h>]"
		alias
			"c_get_colors_total"
		end

invariant
	image_exists: image /= DEFAULT_POINTER

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




end -- class GIF_IMAGE
