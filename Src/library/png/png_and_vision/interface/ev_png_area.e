indexing
	description: "Projection under a PNG format of a drawing"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PNG_AREA

inherit

	EV_DRAWABLE
		redefine
			background_color,
			clear,
			clear_rect, 
			draw_arc ,
			draw_ellipse, 
			draw_pixmap, 
			draw_point,
			draw_polyline,
			draw_rectangle,
			draw_segment ,
			draw_straight_line,
			draw_text,
			fill_arc,
			fill_ellipse,
			fill_polygon, 
			fill_rectangle,
			foreground_color,
			set_background_color, 
			set_font ,
			set_foreground_color	
		end

	GD_FONTS

	DISPOSABLE

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

	background_color: EV_COLOR is
			-- Background color of current image.
		require else
			has_background: has_background_color
		local
			r,g,b: INTEGER
		do
			Result := corresponding_color(1)
		ensure then
			not_void: Result /= Void
		end

	foreground_color: EV_COLOR is
			-- Foreground color of current image. 
			-- Return background color if no current foreground color (default).
		require else
			has_background: has_background_color
		 do 
			Result := corresponding_color(color_index)
		ensure then
			not_void: Result /= Void
		end

feature -- Settings

	set_foreground_color (new_color: EV_COLOR) is
		-- Set 'new_color' as current selected color.
		require else
			not_void: new_color /= Void
			background_allocated: has_background_color
		do
			color_index := color(new_color.red, new_color.green, new_color.blue)
		ensure then
			color_index >0 and then color_index <= color_index_bound	
		end

	set_background_color (col: EV_COLOR) is
		-- Set 'col' as background color.
		require else
			background_not_allocated: not has_background_color
			not_void: col /= Void
		do
			color_index := color(col.red, col.green, col.blue)
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
			col: EV_COLOR
		do
			h := height
			w := width 
			col := background_color
			c_destroy_image(image)
			image := gdImageCreate(w,h)
			set_background_color(col)
		ensure then
			has_background_color: has_background_color
			image_exists: image /= Void
		end

feature -- Drawing operations.

	draw_ellipse (pt: EV_COORDINATES; r1: INTEGER; r2: INTEGER; orientation: EV_ANGLE) is
			-- Draw an ellipse.
		require else
			not_void: pt /= Void and orientation /= Void
		--	rgb: r1<=255 and r2 <=255 and r1>=0 and r2 >=0
			possible: is_inside(pt)
		do
			gdImageArc(image,pt.x,pt.y,r1,r2,0,360,color_index)
		end

	fill_ellipse (pt: EV_COORDINATES; r1: INTEGER; r2: INTEGER; orientation: EV_ANGLE) is
			-- Fill an ellipse.
		require else
			not_void: pt /= Void and orientation /= Void
			possible: is_inside(pt)
		do
			draw_ellipse(pt,r1,r2,orientation)
			gdimagefilltoborder(image,pt.x,pt.y,color_index, color_index )
		end

	draw_rectangle (pt: EV_COORDINATES; w: INTEGER; h: INTEGER; orientation: EV_ANGLE) is
			-- Draw a rectangle.
		require else
			not_void: pt /= Void and orientation /= Void
			positive_lengths: w >0 and h>0
			possible: is_inside(pt)
		do
			gdImageRectangle(image,pt.x,pt.y,pt.x+w,pt.y+h,color_index)	
		end

	fill_rectangle (pt: EV_COORDINATES; w: INTEGER; h: INTEGER; orientation: EV_ANGLE) is
			-- Fill a rectangle.
		require else
			not_void: pt /= Void and orientation /= Void
			positive_lengths: w >0 and h>0
		do
			draw_rectangle(pt,w,h,orientation)
			gdimagefilltoborder(image,pt.x,pt.y,color_index, color_index )
		end

	clear_rect (left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER) is 
			-- Clear rectangle
			require else
				meaningfull: left < right and top < bottom
				possible: right <= width and bottom <=height
			do
				gdImageRectangle(image,left,top,right,bottom,1)	
				gdimagefilltoborder(image,(2*right-left)//2,(2*bottom-right)//2,color_index,1)
			end

	draw_polyline (pts: ARRAY [EV_COORDINATES]; is_closed: BOOLEAN) is 
			-- Draw a polyline figure.
		require else
			not_void: pts /= Void
			at_least_two_points: pts.count>1
		local
			i: INTEGER
			gp1,gp2: EV_COORDINATES
		do
			from
				i := 2
			until
				i > pts.count
			loop
				gp1 := pts.item (i-1)
				gp2 := pts.item (i)
				draw_line(gp1.x,gp1.y,gp2.x,gp2.y,color_index) 
				i := i+1	
			end
			gp1 := pts.item (1)
			draw_line(gp2.x,gp2.y,gp1.x,gp1.y,color_index) 
		end

	draw_line(x1,y1,x2,y2: INTEGER;color_ind: INTEGER) is
			-- Draw a line
		require else
			color_index_possible: color_ind >=0 and color_ind <=255 and then color_ind <= color_index_bound
			point1_inside_the_image:coordinates_within_the_image(x1,y1)
			point2_inside_the_image:coordinates_within_the_image(x2,y2)
		do
			gdimageline (image, x1,y1,x2,y2,color_ind)
		end

	fill_polygon (pts: ARRAY [EV_COORDINATES]) is
			-- Fill polygon defined by 'pts'.	
		require else
			not_void: pts /= Void 
			at_least_three_points: pts.count>2
		local
			x,y: INTEGER
		do 
			x := (pts.item(1).x + pts.item(2).x + pts.item(3).x)//3
			y := (pts.item(1).y + pts.item(2).y + pts.item(3).y)//3
			draw_polyline(pts, TRUE)
			gdimagefilltoborder(image,x,y,color_index, color_index )
		end

	draw_arc (pt: EV_COORDINATES; r1: INTEGER; r2: INTEGER; 
				start_angle: EV_ANGLE; aperture: EV_ANGLE;
			 	orientation: EV_ANGLE; style: INTEGER) is
				-- Draw arc
			require else
				not_void: pt /= Void and start_angle /= Void and aperture /= Void
				possible: is_inside(pt)
			do 
				gdImageArc(image,pt.x,pt.y,r1,
					   r2,start_angle.degrees.rounded,
					   aperture.degrees.rounded,
					   color_index)
			end

	fill_arc (pt: EV_COORDINATES; r1: INTEGER; r2: INTEGER; 
			  start_angle: EV_ANGLE; aperture: EV_ANGLE; 
              orientation: EV_ANGLE; style: INTEGER) is 
			-- Fill arc
		require else
			not_void: pt /= Void and start_angle /= Void and aperture /= Void and 
					  orientation /= Void
			possible: is_inside(pt)
		local
			pt1,pt2,pt3: EV_COORDINATES
		do 
			draw_arc(pt,r1,r2,start_angle,aperture,orientation,style)
			Create pt1.make
			Create pt2.make
			Create pt3.make
			pt1.set(((r1*(start_angle+orientation).cosine)/2).ceiling,
					 ((r1*(start_angle+orientation).sine)/2).ceiling)
			pt2.set(((r2*(start_angle+orientation+aperture).cosine)/2).ceiling,
					 ((r2*(start_angle+orientation+aperture).sine)/2).ceiling)
			pt1.set(pt1.x+pt.x, pt1.y+pt.y)
			pt2.set(pt2.x+pt.x, pt2.y+pt.y)
			draw_segment(pt,pt1)
			draw_segment(pt,pt2)
			pt3.set((pt1.x+pt2.x)//2, (pt1.y+pt2.y)//2)	
			gdimagefilltoborder(image,pt3.x,pt3.y,color_index, color_index )	
		end

	draw_segment (pt1: EV_COORDINATES; pt2: EV_COORDINATES) is 
				-- Draw segment.
		require else
			not_void: pt1 /= Void and pt2 /= Void
			meaningfull: pt1 /= pt2 and (pt1.x/=pt2.x or else pt2.y/=pt2.x)
			possible: is_inside(pt1) and is_inside(pt2)
		do 
			gdimageline ( image, pt1.x,pt1.y,pt2.x,pt2.y,color_index )
		end

	draw_pixmap (pt: EV_COORDINATES; pix: EV_PIXMAP) is
			-- Draw pixmap
		require else
			not_void: pt /= Void and pix /= Void
			possible: is_inside(pt)
		do 
			-- will be implemented as soon as a stable version of Vision
			-- is available.
		end

	draw_straight_line (pt1: EV_COORDINATES; pt2: EV_COORDINATES) is 
		-- Draw straight line.
		require else
			exist: pt1 /= Void and pt2 /= Void
			possible: is_inside(pt1) and is_inside(pt2)
		do 
			-- Not yet supported
		end

	draw_text (pt: EV_COORDINATES; text: STRING) is
			-- Draw text.
		require else
			not_void: pt /= Void and text /= Void
			possible: is_inside(pt)
		local
			a: any
			p: POINTER
		do
			a := text.to_c
			p := font(selected_font)
			c_image_string(image, p,pt.x,pt.y, $a , color_index)	
		end 

	draw_point (pt: EV_COORDINATES) is 
			-- Draw a pixel.
		require else
			not_void: pt /= Void
			possible: is_inside(pt)
		do
			gdImageSetPixel(image,pt.x,pt.y,color_index)
		end

feature {NONE} -- Internal operations

	corresponding_color(i: like color_index): EV_COLOR is
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
			Create Result.make_rgb(r,g,b)
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	color_index: INTEGER
		-- Internal index corresponding to the current selected color.

	image: POINTER
		-- Current Image.

feature -- Internal image information

	is_inside(pt: EV_COORDINATES): BOOLEAN is
		-- Does point 'pt' within the image bounds ?
		require
			exists: pt /= Void
		do
			Result := (pt.x <=width ) and then (pt.y <=height)
					   and then (pt.x>=0) and then (pt.y>=0)
		end

	color_index_bound: INTEGER is
		-- Return the number of color indexes currently associated with the image.
		do
			Result := c_image_color_total(image)
		ensure
			possible: Result >=0
		end

	coordinates_within_the_image(x,y: INTEGER): BOOLEAN is
			-- Does a point (x,y ) within the boundaries ?
		do
			Result := (gdImageBoundsSafe(image,x,y)=1)
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

	selected_font: INTEGER
		-- Current selected font.

	has_background_color: BOOLEAN is
		-- Does Current have a background color ?
		do
			Result := (c_image_color_total(image) >0)
		end

	height: INTEGER is
		do
			Result := c_get_height(image)
		end

	width: INTEGER is 
		do
			Result := c_get_width(image)
		end

feature -- Settings

	set_font (ft: EV_FONT) is 
		do

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






end -- class EV_PNG_AREA
