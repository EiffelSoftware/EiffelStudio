indexing
	description: "Projection under a PNG format of a drawing"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL2PNG

inherit

	GD_FONTS

	GD_FONT_CONSTANTS

	DISPOSABLE

	SINGLE_MATH

create
	make, make_from_file

feature -- Initialization

	make(w,h: INTEGER) is
			-- Initialize the image with
			-- 'w' as width and 'h' as height.
		require
			width_possible: w > 0
			height_possible: h > 0
		do
			image := GdImageCreate (w,h)
		ensure
			dimensions_set: height = h and width = w
		end

	make_from_file(fi: RAW_FILE) is
			-- Retrieve PNG image, stored in
			-- file 'fi'
		require
			not_void: fi /= Void
			exists: fi.exists
			rights: fi.is_readable and fi.is_writable
			closed: fi.is_closed
		local
			fd_file: POINTER
		do
			fi.open_read
			fd_file := fi.file_pointer
			image := gdImageCreateFromPng(fd_file)
			fi.close
		end

feature -- Actions

	save_to_file (file_name: FILE_NAME) is
			-- Save Current to a file whose file_name is 'file_name'.
		require
			possible: file_name /= Void and then file_name.is_valid
		local
			file: RAW_FILE
			fd_file: POINTER
		do
			Create file.make_create_read_write(file_name)
			file.open_write
			fd_file := file.file_pointer
			GdImagePng(image, fd_file)
			file.close
		end

feature -- Access

	background_color: TUPLE[INTEGER,INTEGER,INTEGER] is
			-- Background color of current image.
		require
			has_background: has_background_color
		do
			Result := corresponding_color(1)
		ensure
			not_void: Result /= Void
		end

	foreground_color: TUPLE[INTEGER,INTEGER,INTEGER] is
			-- Foreground color of current image. 
			-- Return background color if no current foreground color (default).
		require
			has_background: has_background_color
		 do 
			Result := corresponding_color(color_index)
		ensure
			not_void: Result /= Void
		end

feature -- Settings

	set_foreground_color (r,g,b: INTEGER) is
		-- Set 'new_color' as current selected color.
		require
			background_allocated: has_background_color
			possible: possible_rgb(r,g,b)
		do
			color_index := color(r, g, b)
		ensure then
			color_index >0 and then color_index <= color_index_bound	
		end

	set_background_color (r,g,b: INTEGER) is
		-- Set 'col' as background color.
		require
			background_not_allocated: not has_background_color
			possible: possible_rgb(r,g,b)
		do
			color_index := color(r, g, b)
		ensure then
			color_index >=0 
		end

feature -- Removal

	clear is 
		-- Clear the image.
		-- This also clear the color palette.
		require else
			has_background: has_background_color
		local
			w,h: INTEGER
			col: TUPLE[INTEGER,INTEGER,INTEGER]
		do
			h := height
			w := width 
			col := background_color
			c_destroy_image(image)
			image := gdImageCreate(w,h)
			set_background_color(col.integer_item(1),
						col.integer_item(2),
						col.integer_item(3))
		ensure then
			has_background_color: has_background_color
			image_exists: image /= Void
		end

feature -- Drawing operations.

	draw_ellipse (x,y:INTEGER; r1: INTEGER; r2: INTEGER) is
			-- Draw an ellipse.
		require
			possible: is_inside(x,y)
		do
			gdImageArc(image,x,y,r1,r2,0,360,color_index)
		end

	fill_ellipse (x,y: INTEGER; r1: INTEGER; r2: INTEGER) is
			-- Fill an ellipse.
		require
			possible: is_inside(x,y)
		do
			draw_ellipse(x,y,r1,r2)
			gdimagefilltoborder(image,x,y,color_index, color_index )
		end

	draw_rectangle (x,y: INTEGER; w: INTEGER; h: INTEGER) is
			-- Draw a rectangle.
		require
			positive_lengths: w >0 and h>0
			possible: is_inside(x,y) and is_inside(w+x, h+y)
		do
			gdImageRectangle(image,x,y,x+w,y+h,color_index)	
		end

	fill_rectangle (x,y: INTEGER; w: INTEGER; h: INTEGER) is
			-- Fill a rectangle.
		require
			positive_lengths: w >0 and h>0
			possible:  is_inside(x,y) and is_inside(w+x, h+y)
		do
			draw_rectangle(x,y,w,h)
			gdimagefilltoborder(image,x,y,color_index, color_index )
		end

	clear_rect (left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER) is 
			-- Clear rectangle
			require
				possible: is_inside(left,top) and is_inside(right,bottom)
			do
				gdImageRectangle(image,left,top,right,bottom,1)	
				gdimagefilltoborder(image,(2*right-left)//2,(2*bottom-right)//2,color_index,1)
			end

	draw_polyline (pts: ARRAY [TUPLE[INTEGER,INTEGER]]; is_closed: BOOLEAN) is 
			-- Draw a polyline figure.
		require else
			not_void: pts /= Void
			at_least_two_points: pts.count>1
		local
			i: INTEGER
			gp1,gp2: TUPLE[INTEGER,INTEGER]
		do
			from
				i := 2
			until
				i > pts.count
			loop
				gp1 := pts.item (i-1)
				gp2 := pts.item (i)
				draw_line(gp1.integer_item(1),
						  gp1.integer_item(2),
						  gp2.integer_item(1),
						  gp2.integer_item(2),color_index) 
				i := i+1	
			end
			gp1 := pts.item (1)
			draw_line(gp2.integer_item(1),
					  gp2.integer_item(2),
					  gp1.integer_item(1),
					  gp1.integer_item(2),color_index) 
		end

	draw_line(x1,y1,x2,y2: INTEGER;color_ind: INTEGER) is
			-- Draw a line
		require
			color_index_possible: color_ind >=0 and color_ind <=255 and then color_ind <= color_index_bound
			point1_inside_the_image:is_inside(x1,y1)
			point2_inside_the_image:is_inside(x2,y2)
		do
			gdimageline (image, x1,y1,x2,y2,color_ind)
		end

	fill_polygon (pts: ARRAY [TUPLE[INTEGER,INTEGER]]) is
			-- Fill polygon defined by 'pts'.	
		require else
			not_void: pts /= Void 
			at_least_three_points: pts.count>2
		local
			x,y: INTEGER
		do 
			x := (pts.item(1).integer_item(1) + pts.item(2).integer_item(1) + pts.item(3).integer_item(1))//3
			y := (pts.item(1).integer_item(2) + pts.item(2).integer_item(2) + pts.item(3).integer_item(2))//3
			draw_polyline(pts, TRUE)
			gdimagefilltoborder(image,x,y,color_index, color_index )
		end

	draw_arc (x,y: INTEGER; r1: INTEGER; r2: INTEGER; 
				start_angle: INTEGER; aperture: INTEGER;
			 	orientation: INTEGER; style: INTEGER) is
				-- Draw arc, the angle are measured in degrees.
			require
				possible: is_inside(x-r1//2,y-r2//2) and is_inside(x+r1//2,y+r2//2)
			do 
				gdImageArc(image,x,y,r1,
					   r2,start_angle,
					   aperture,
					   color_index)
			end

	fill_arc (x,y: INTEGER; r1: INTEGER; r2: INTEGER; 
			  start_angle: INTEGER; aperture: INTEGER; 
              orientation: INTEGER; style: INTEGER) is 
			-- Fill slice, the angles are measured in degrees.
		require
			possible: is_inside(x-r1//2,y-r2//2) and is_inside(x+r1//2,y+r2//2)
		local
			x1,y1,x2,y2,x3,y3: INTEGER
		do 
			draw_arc(x,y,r1,r2,start_angle,aperture,orientation,style)
			x1 := (cosine(r1*(start_angle+orientation)*pi/180)/2).ceiling + x
			y1 := (sine(r1*(start_angle+orientation)*pi/180)/2).ceiling + y
			x2 := (cosine(r2*(start_angle+orientation+aperture)*pi/180)/2).ceiling + x
			y2 := (sine(r2*(start_angle+orientation+aperture)*pi/180)/2).ceiling +y
			draw_segment(x,y,x1,y1)
			draw_segment(x,y,x2,y2)
			x3 := (x1+x2)//2
			y3 := (y1+y2)//2
			gdimagefilltoborder(image,x3,y3,color_index, color_index )	
		end

	draw_segment (x1,y1,x2,y2: INTEGER) is 
				-- Draw segment.
		require
			meaningfull: not (x1=x2 and y1=y2)
			possible: is_inside(x1,y1) and is_inside(x2,y2)
		do 
			gdimageline ( image, x1,y1,x2,y2,color_index )
		end

	draw_text (x,y: INTEGER; text: STRING) is
			-- Draw text.
		require
			not_void: text /= Void
			possible: is_inside(x,y)
		local
			a: any
			p: POINTER
		do
			a := text.to_c
			p := font(selected_font)
			c_image_string(image, p,x,y, $a , color_index)	
		end 

	draw_point (x,y: INTEGER) is 
			-- Draw a pixel.
		require
			possible: is_inside(x,y)
		do
			gdImageSetPixel(image,x,y,color_index)
		end

feature -- Setting fonts

	set_font(a_font_indice: like large_font) is
			-- Set Current font. Please refer to class GD_FONT_CONSTANTS for			
			-- possible values.
		require
			possible: font_possible(a_font_indice)
		do
			selected_font := a_font_indice
		end

feature {NONE} -- Internal operations

	corresponding_color(i: like color_index): TUPLE[INTEGER,INTEGER,INTEGER] is
			-- Color corrsponding to index 'i'.
		require
			has_background: has_background_color
			index_possible: i>=0 and then i <= color_index_bound
		local
			r,g,b: INTEGER
		do
			r := c_red(image,i)
			g := c_green(image,i)
			b := c_blue(image,i)
			Result := [r,g,b]
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	color_index: INTEGER
		-- Internal index corresponding to the current selected color.

	image: POINTER
		-- Current Image.

	selected_font: INTEGER
		-- Current selected font.

feature -- Internal image information

	is_inside(x,y: INTEGER): BOOLEAN is
		-- Does point 'pt' within the image bounds ?
		do
			Result := (gdImageBoundsSafe(image,x,y)=1)
		end

	possible_rgb(r,g,b:INTEGER): BOOLEAN is
			-- Is (r,g,b) a 3-tuple which complies with
			-- the rgb-representation ?
		do
			Result := (r>=0 and then g>=0 and then b>=0 and then
					   r <256 and then g<256 and then b<256)
		end

	color_index_bound: INTEGER is
		-- Return the number of color indexes currently associated with the image.
		do
			Result := c_image_color_total(image)
		ensure
			possible: Result >=0
		end

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

	has_background_color: BOOLEAN is
		-- Does Current have a background color ?
		do
			Result := (c_image_color_total(image) >0)
		end

	height: INTEGER is
			-- Height of Current.
		do
			Result := c_get_height(image)
		end

	width: INTEGER is 
			-- Widht of Current.
		do
			Result := c_get_width(image)
		end

feature {NONE} -- Memory 

	dispose is
			-- Remove C_struture associated with Current Image.
		do
			c_destroy_image(image)
		end

feature {NONE} -- Externals (general)

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

	gdImageCreateFromPng (p: POINTER): POINTER is
		external
			"C"
		alias
			"gdImageCreateFromPng"
		end

	gdImagePng(p: POINTER; f: POINTER) is
		external
			"c"
		alias
			"gdImagePng"
		end

	gdImageBoundsSafe(p: POINTER; x,y: INTEGER):INTEGER is
		external
			"c"
		alias
			"gdImageBoundsSafe"
		end

	c_get_width(p: POINTER):INTEGER is
		external
			"c[macro <eiffel_png.h>]"
		end

	c_get_height(p: POINTER):INTEGER is
		external
			"c[macro <eiffel_png.h>]"
		end

feature {NONE} -- Externals (drawings)

	gdImageSetPixel(p: POINTER; x1,y1, color_ind: INTEGER) is
		external
			"c"
		alias
			"gdImageSetPixel"
		end

	gdimagefilltoborder(p: POINTER; x1,y1, stopping_color, color_ind: INTEGER) is
		external
			"c"
		alias
			"gdImageFillToBorder"
		end

	c_image_string (p,f: POINTER; i1,i2: INTEGER; s: POINTER; color_ind: INTEGER) is
		external
			"c"
		alias
			"gdImageString"
		end

	gdImageArc(p: POINTER; x,y,ellipse_width,ellipse_height,starting_angle,ending_angle,col_index: INTEGER) is
		external
			"c"
		alias
			"gdImageArc"
		end

	gdImageRectangle(p: POINTER; x1,y1,x2,y2: INTEGER; color_ind: INTEGER) is
		external
			"c"
		alias
			"gdImageRectangle"
		end

 	gdImageLine(p: POINTER; x1,y1,x2,y2: INTEGER; color_ind: INTEGER) is
		external
			"c"
		alias
			"gdImageLine"
		end

feature {NONE} -- Externals (colors)

	c_red(p: POINTER; i: INTEGER):INTEGER is
		external
			"c"
		alias
			"c_get_red"
		end

	c_blue(p: POINTER; i: INTEGER): INTEGER is
		external
			"c"
		alias
			"c_get_blue"
		end

	c_green(p: POINTER; i: INTEGER):INTEGER is
		external
			"c"
		alias
			"c_get_green"
		end

	c_image_color_total (p: POINTER): INTEGER is
		external	
			"c[macro <eiffel_png.h>]"
		alias
			"c_get_colors_total"
		end

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

invariant
	color_index_possible: color_index >=0 and then color_index <= color_index_bound
	image_exists: image /= Void
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






end -- class EIFFEL2PNG
