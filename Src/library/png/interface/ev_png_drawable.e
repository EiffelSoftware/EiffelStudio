indexing
	description: "Projection under a PNG format of a drawing"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PNG_DRAWABLE

inherit

	MEMORY
		redefine
			dispose
		end

	GD_FONTS

feature -- Access

	background_color: EV_COLOR is
			-- Background_color of Current
		do
		end

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

	has_background_color: BOOLEAN is
		-- Does Current have a background color ?
		do
			Result := (c_image_color_total(image) >0)
		end

feature -- Settings

	set_foreground_color (new_color: EV_COLOR) is
		-- Set 'new_color' as current selected color.
		require
			background_allocated: has_background_color
		do
			color_index := color(new_color.red, new_color.green, new_color.blue)
		end

	set_background_color (new_color: EV_COLOR) is
		-- Set 'new_color' as background color.
		require else
			background_not_allocated: not has_background_color
		do
			color_index := color(new_color.red, new_color.green, new_color.blue)
		end

	set_font (ft: EV_FONT) is 
		do

		end

feature -- Drawings

	draw_ellipse (pt: EV_COORDINATES; r1: INTEGER; r2: INTEGER; orientation: EV_ANGLE) is
			-- Draw an ellipse
		require
			not_void: pt /= Void and orientation /= Void
			rgb: r1<=255 and r2 <=255 and r1>=0 and r2 >=0
		do
			gdImageArc(image,pt.x,pt.y,r1,r2,0,360,color_index)
		end

	fill_ellipse (pt: EV_COORDINATES; r1: INTEGER; r2: INTEGER; orientation: EV_ANGLE) is
		require
			not_void: pt /= Void and orientation /= Void
			rgb: r1<=255 and r2 <=255 and r1>=0 and r2 >=0
		do
			gdImageArc(image,pt.x,pt.y,r1,r2,0,360,color_index)
			gdimagefilltoborder(image,pt.x,pt.y,color_index, color_index )
		end

	draw_rectangle (pt: EV_COORDINATES; w: INTEGER; h: INTEGER; orientation: EV_ANGLE) is
		do
			gdImageRectangle(image,pt.x,pt.y,pt.x+w,pt.y+h,color_index)	
		end

	fill_rectangle (pt: EV_COORDINATES; w: INTEGER; h: INTEGER; orientation: EV_ANGLE) is
		do
			gdImageRectangle(image,pt.x,pt.y,pt.x+w,pt.y+h,color_index)	
			gdimagefilltoborder(image,pt.x,pt.y,color_index, color_index )
		end

	draw_polyline (pts: ARRAY [EV_COORDINATES]; is_closed: BOOLEAN) is 
		local
			i: INTEGER
			gp1,gp2: GD_POINT
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

	fill_polygone (pts: ARRAY [EV_COORDINATES]) is
			do 
				draw_polyline(pts, TRUE)
				gdimagefilltoborder(image,pt.x,pt.y,color_index, color_index )
			end

	draw_arc (pt: EV_COORDINATES; r1: INTEGER; r2: INTEGER; 
				start_angle: EV_ANGLE; aperture: EV_ANGLE;
			 	orientation: EV_ANGLE; style: INTEGER) is
			do 
				gdImageArc(image,pt.x,pt.y,r1,
					   r2,start_angle.degrees,
					   aperture.degrees,
					   color_index)
			end

 	draw_segment (pt1: EV_COORDINATES; pt2: EV_COORDINATES) is 
		do 
			gdimageline ( image, pt1.x,pt1,pt2.x,pt2.y,color_index )
		end

	draw_straight_line (pt1: EV_COORDINATES; pt2: EV_COORDINATES) is do end

	fill_arc (pt: EV_COORDINATES; r1: INTEGER; r2: INTEGER; start_angle: EV_ANGLE; aperture: EV_ANGLE; orientation: EV_ANGLE; style: INTEGER) is do end

	draw_text (pt: EV_COORDINATES; text: STRING) is
		local
			a: any
			p: POINTER
		do
			a := s.to_c
			p := font(selected_font)
			c_image_string(image, p,x,y, $a , color_index)	
		end 

	draw_point (pt: EV_COORDINATES) is 
		do
			
		end

feature {NONE} -- Implementation

	image: POINTER
		-- Current Image.

	color_index: INTEGER
		-- Internal index corresponding to the current selected color.

	selected_font: POINTER

	--clear
	--clear_rect (left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER)
	--draw_pixmap (pt: EV_COORDINATES; pix: EV_PIXMAP)
	--foreground_color: EV_COLOR
	--is_drawable: BOOLEAN
	--line_width: INTEGER
	--logical_mode: INTEGER
	--max_count_for_draw_polyline: INTEGER
	--set_line_width (value: INTEGER)
	--set_logical_mode (value: INTEGER)


feature {NONE} -- Externals

	gdImageArc(p: POINTER; x,y,ellipse_width,ellipse_height,starting_angle,ending_angle,col_index: INTEGER) is
		external
			"c"
		alias
			"gdImageArc"
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

	c_image_color_total (p: POINTER): INTEGER is
		external	
			"c[macro <eiffel_png.h>]"
		alias
			"c_get_colors_total"
		end

	gdImageRectangle(p: POINTER; x1,y1,x2,y2: INTEGER; color_index: INTEGER) is
		external
			"c"
		alias
			"gdImageRectangle"
		end
 	gdImageLine(p: POINTER; x1,y1,x2,y2: INTEGER; color_index: INTEGER) is
		external
			"c"
		alias
			"gdImageLine"
		end

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

	gdImagePng(p: POINTER; f: POINTER) is
		external
			"c"
		alias
			"gdImagePng"
		end

end -- class EV_PNG_DRAWABLE
