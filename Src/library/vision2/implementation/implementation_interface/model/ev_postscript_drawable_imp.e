indexing
	description: "EiffelVision postscript drawing area implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POSTSCRIPT_DRAWABLE_IMP

inherit
	EV_DRAWABLE_I
	
	EV_POSTSCRIPT_PAGE_CONSTANTS

	REFACTORING_HELPER
		export
			{NONE} all
		end
	
create
	make

feature {NONE} -- Initialize

	make (an_interface: EV_POSTSCRIPT_DRAWABLE) is
			-- Create a EV_POSTSCRIPT_DRAWBALE_IMP with front end `an_interface'.
		do
			base_make (an_interface)
		end
	
feature {EV_ANY} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			set_default_font
			set_default_colors
			set_default_page_size
			
			line_width := 1
			drawing_mode := drawing_mode_copy
			clip_area := Void
			tile := Void
			dashed_line_style := False
			
			set_is_initialized (True)
			create postscript_result.make (0)
		end
		
feature -- Access

	width: INTEGER
			-- Horizontal size in pixels.

	height: INTEGER 
			-- Vertical size in pixels.

	line_width: INTEGER
			-- Line thickness.

	drawing_mode: INTEGER
			-- Logical operation on pixels when drawing.
		
	clip_area: EV_RECTANGLE
			-- Clip area used to clip drawing.
			-- If set to Void, no clipping is applied.
		
	tile: EV_PIXMAP
			-- Pixmap that is used to instead of background_color.
			-- If set to Void, `background_color' is used to fill.

	dashed_line_style: BOOLEAN
			-- Are lines drawn dashed?
			
	foreground_color: EV_COLOR
			-- Color of foreground features like text.

	background_color: EV_COLOR
			-- Color displayed behind foregournd features.
			
	font: EV_FONT
			-- Typeface appearance for `Current'.
			
	left_margin: INTEGER
			-- size of left margin.

	bottom_margin: INTEGER
			-- size of bottom margin.
			
	landscape: BOOLEAN
			-- Is page shown in landscape mode? (other is portrait)

feature -- Element change

	set_size (a_width, a_height: INTEGER) is
			-- set `width' to `a_width' and `height' to `a_height'.
		require
			positive: a_width >= 0 and a_height >= 0
		do
			width := a_width
			height := a_height
		ensure
			set: width = a_width and height = a_height
		end

	set_line_width (a_width: INTEGER) is
			-- Assign `a_width' to `line_width'.
		do
			if a_width /= line_width then
				line_width := a_width
				add_ps (line_width.out + " setlinewidth")
				add_ps ("1 setlinecap")
			end
		end

	set_drawing_mode (a_mode: INTEGER) is
			-- Set drawing mode to `a_logical_mode'.
		do
			drawing_mode := a_mode
		end

	set_clip_area (an_area: EV_RECTANGLE) is
			-- Set area which will be refreshed.
		do
			clip_area := an_area
		end

	remove_clip_area is
			-- Do not apply any clipping.
		do
			clip_area := Void
		end

	set_tile (a_pixmap: EV_PIXMAP) is
			-- Set tile used to fill figures.
			-- Set to Void to use `background_color' to fill.
		do
			tile := a_pixmap	
		end

	remove_tile is
			-- Do not apply a tile when filling.
		do
			tile := Void
		end

	enable_dashed_line_style is
			-- Draw lines dashed.
		do
			if not dashed_line_style then				
				dashed_line_style := True
				add_ps ("[3] 0 setdash")
			end
		end

	disable_dashed_line_style is
			-- Draw lines solid.
		do
			if dashed_line_style then
				dashed_line_style := False
				add_ps ("[] 0 setdash")
			end
		end

	set_default_colors is
			-- Set foreground and background color to their default values.
		do
			create foreground_color.make_with_rgb (0, 0, 0)
			create background_color.make_with_rgb (1, 1, 1)
		end
		
	set_default_font is
			-- Set the `font' to the default font.
		do
			create font
		end
		
	set_foreground_color (a_color: like foreground_color) is
			-- Assign `a_color' to `foreground_color'.
		do
			if 
				a_color.red /= foreground_color.red or else
				a_color.blue /= foreground_color.blue or else
				a_color.green /= foreground_color.green
			then
				add_ps (a_color.out + " setrgbcolor")
			end
			foreground_color := a_color
		end

	set_background_color (a_color: like background_color) is
			-- Assign `a_color' to `foreground_color'.
		do
			background_color := a_color
		end
		
	set_margins (a_left_margin, a_bottom_margin: INTEGER) is
			-- Set `left' and `bottom' margins to `a_left_margin'
			-- and `a_bottom_margin'.
		require
			a_left_margin_not_negative: a_left_margin >= 0
			a_bottom_margin_not_negative: a_bottom_margin >= 0
		do
			left_margin := a_left_margin
			bottom_margin := a_bottom_margin
		ensure
			left_set: left_margin = a_left_margin
			bottom_set: bottom_margin = a_bottom_margin
		end

	set_page_size (a_size: INTEGER; a_landscape: BOOLEAN) is
			-- Set horizontal and vertical dimensions of page.
			-- Values for `a_size' are defined in EV_POSTSCRIPT_PAGE_CONSTANTS.
		do
			real_page_width := page_width (a_size, a_landscape) - (left_margin*2)
			real_page_height := page_height (a_size, a_landscape) - (bottom_margin*2)
			landscape := a_landscape
		end
		
	set_default_page_size is
			-- Set page size to default values.
		do
			set_page_size (Letter, False)
			width := real_page_width
			height := real_page_height
		end
		
		
	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		do
			font := a_font.twin
		end
		
feature -- Clearing and drawing operations

	redraw is 
			-- Force `Current' to redraw itself. 
		do 
		end 

	clear is
			-- Erase `Current' with `background_color'.
		do
			postscript_result.clear_all
			clear_rectangle (0, 0, width, height)
		end

	clear_rectangle (x1, y1, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height' in `background_color'.
		do
			add_ps ("%%Drawing PS Figure fill Rectangle")
			add_ps ("gsave")
			translate_to (0, 0)
			add_ps ("newpath")
			append_color (background_color)
			add_ps (x1.out + " " + (- y1).out + " moveto")
			add_ps ((x1 + a_width).out + " " + (- y1).out + " lineto")
			add_ps ((x1 + a_width).out + " " + (- y1 - a_height).out + " lineto")
			add_ps (x1.out + " "  + ( - y1 - a_height).out + " lineto")
			add_ps ("closepath")
			add_ps ("fill")
			add_ps ("stroke")
			add_ps ("grestore")
		end
		
	save_to_named_file (a_file_name: FILE_NAME) is
			-- Save `Current' to the file with `a_file_name'.
		require
			a_file_name_not_void: a_file_name /= Void
		local
			file_with_header: STRING
			clip_rectangle, page_rectangle, page_clip_rectangle: EV_RECTANGLE
			file: PLAIN_TEXT_FILE
			nb_of_h_pages, nb_of_v_pages, h, v, cur_page: INTEGER
		do
			create file_with_header.make (0)
			-- header
			file_with_header.append ("%%!PS-Adobe-3.0%N")
			file_with_header.append ("%%%%Creator: N/A%N")
			file_with_header.append ("%%%%Title: N/A%N")
			file_with_header.append ("%%%%CreationDate: N/A%N")
			file_with_header.append ("%%%%DocumentData: N/A%N")
			file_with_header.append ("%%%%Origin: 0 0%N")
			file_with_header.append ("%%%%BoundingBox: 0 0 " + real_page_width.out + " " + real_page_height.out + "%N")
			file_with_header.append ("%%%%LanguageLevel: 2%N")
			if landscape then
				file_with_header.append ("%%%%PageOrientation: Landscape%N")
			else
				file_with_header.append ("%%%%PageOrientation: Portrait%N")
			end
			
			nb_of_v_pages := (height / real_page_height).ceiling
			nb_of_h_pages := (width / real_page_width).ceiling
			file_with_header.append ("%%%%Pages: " + (nb_of_v_pages * nb_of_h_pages).out + "%N")
			file_with_header.append_string (get_eiffel_header)
			
			-- draw page routine
			file_with_header.append ("/draw_page {%N")
			file_with_header.append (postscript_result)
			file_with_header.append ("} bind def%N")
			
			-- draw all pages
			if clip_area = Void then
				create clip_rectangle.make (0, 0, width, height)
			else
				clip_rectangle := clip_area
			end

			from
				v := 1
				cur_page := 1
			until
				v > nb_of_v_pages
			loop
				from
					h := 1
				until
					h > nb_of_h_pages
				loop
					file_with_header.append ("%N%N%%%%Page: " + cur_page.out + " " + cur_page.out + "%N")
					file_with_header.append ("%%%%BeginPageSetup%N")
					file_with_header.append ("%%Setting Clip Path and Origin%N")

					file_with_header.append ("gsave%N")
					-- Translate to page
					file_with_header.append ((-real_page_width * (h - 1) + left_margin).out + " " + (real_page_height * v + bottom_margin).out + " translate%N")

					-- set page clip
					create page_rectangle.make (real_page_width * (h - 1), real_page_height * (v - 1), real_page_width, real_page_height)					
					page_clip_rectangle := intersect (page_rectangle, clip_rectangle)
					file_with_header.append  ("newpath%N")
					file_with_header.append  ((page_clip_rectangle.left).out + " " + (- (page_clip_rectangle.top)).out + " moveto%N")
					file_with_header.append  ((page_clip_rectangle.width).out + " 0 rlineto%N")
					file_with_header.append  ("0 " + (- page_clip_rectangle.height).out + " rlineto%N")
					file_with_header.append  ((-page_clip_rectangle.width).out + " 0 rlineto%N")
					file_with_header.append  ("closepath%N")
					file_with_header.append ("clip%Nclippath%N")
					
					-- draw everything
					file_with_header.append ("draw_page%N")

					file_with_header.append ("grestore%N")
					file_with_header.append ("%%%%EndPageSetup%N")
					file_with_header.append ("showpage%N")
					
					h := h + 1
					cur_page := cur_page + 1
				end
				v := v + 1
			end
			
			file_with_header.append ("%%%%EOF%N")
			
			create file.make_open_write (a_file_name)
			file.put_string (file_with_header)
			file.close
		end
		
	intersect (p, q: EV_RECTANGLE): EV_RECTANGLE is
			-- Intersection of `q' and `p'.
		do
			if not p.intersects (q) then
				create Result
			else
				create Result.make (p.left.max (q.left), p.top.max (q.top), 0, 0)
				Result.include (p.right.min (q.right), p.bottom.min (q.bottom))
			end
		ensure
			Result_exists: Result /= Void
		end
		
feature -- Duplication 
	
	sub_pixmap (area: EV_RECTANGLE): EV_PIXMAP is 
			-- Pixmap region of `Current' represented by rectangle `area' 
		do
		end 
		
feature -- Drawing operations

	draw_point (x, y: INTEGER) is
			-- Draw point at (`x', 'y').
		do
			translate_to (x, ( - y))
			add_ps ("newpath")
			draw_arc_ps (1, 0, 360)
			add_ps ("closepath")
			add_ps ("fill")
			add_ps ("stroke")
			translate_to (-x, y)
		end

	draw_text (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' with left of baseline at (`x', `y') using `font.
		do
			draw_text_top_left (x, y - font.ascent, a_text)
		end

	draw_text_top_left (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		local
			font_name, font_style, line: STRING
			c: CHARACTER
			nb, i, line_nr, font_height: INTEGER
		do
			add_ps ("gsave")
			translate_to (0, 0)
			font_name := font.name.twin
			font_name.put (font_name.item (1).as_upper, 1)
			font_style := ""
			if font.weight = 8 then
				font_style.append ("Bold")
			end
			if font_name.is_equal ("Times") then
				if font.shape = 11 then
					font_style.append ("Italic")
				end
			else
				if font.shape = 11 then
					font_style.append ("Oblique")
				end
			end
			if font_style.count = 0 then
				font_style.append ("Roman")
			end
			add_ps ("/" + font_name + "-" + font_style + " findfont")
			add_ps (font.height.out + " scalefont")
			add_ps ("setfont")
			from
				i := 1
				nb := a_text.count
				font_height := font.height
				line_nr := 0
				line := ""
			until
				i > nb
			loop
				c := a_text.item (i)
				if c.is_equal ('%N') or i = nb then
					if i = nb then
						line.append_character (c)
					end
					add_ps (x.out + " " + ( - y - font.ascent - line_nr * font_height).out + " moveto")
					add_ps ("(" + line + ") show")
					line_nr := line_nr + 1
					line := ""
				else
					line.append_character (c)
				end
				i := i + 1
			end
			
			add_ps ("grestore")
		end

	draw_ellipsed_text (x, y: INTEGER; a_text: STRING; clipping_width: INTEGER) is
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		do
			fixme ("draw_ellipsed_text: To be implemented")
		end

	draw_ellipsed_text_top_left (x, y: INTEGER; a_text: STRING; clipping_width: INTEGER) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		do
			fixme ("draw_ellipsed_text_top_left: To be implemented")
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		do
			add_ps ("newpath")
			add_ps (x1.out + " " + ( - y1).out + " moveto")
			add_ps (x2.out + " " + ( - y2).out + " lineto")
			add_ps ("stroke")
		end

	draw_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' with upper-left corner on (`x', 'y').
		local
			pixmap_width, pixmap_height: INTEGER
			hex_string: STRING
			i: INTEGER
		do
			
			add_ps ("gsave")
			translate_to (x, - y - a_pixmap.height)
			pixmap_width := a_pixmap.width
			pixmap_height := a_pixmap.height
			
			add_ps (pixmap_width.out + " " + pixmap_height.out + " scale")
			
			hex_string := a_pixmap.implementation.raw_image_data.rgb_hex_representation
			
			add_ps (pixmap_width.out + " " + pixmap_height.out + " 8 [" + pixmap_width.out + " 0 0 " + (-pixmap_height).out
				+ " 0 " + pixmap_height.out + "]")

			from
				i := 250
			until
				i + 250 > hex_string.count
			loop
				hex_string.insert_string ("%N", i + 1)
				i := i + 250
			end
			add_ps ("{<%N"+hex_string+"%N>}")
			add_ps ("false 3 colorimage")
			add_ps ("grestore")	
		end

	draw_sub_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; area: EV_RECTANGLE) is
			-- Draw `area' of `a_pixmap' with upper-left corner on (`x', `y').
		local
			new_pixmap: EV_PIXMAP
		do
			create new_pixmap.make_with_size (area.width, area.height)
			new_pixmap.draw_sub_pixmap (0, 0, a_pixmap, area)
			draw_pixmap (x, y, new_pixmap)
		end

	draw_arc (x, y, a_bounding_width, a_bounding_height: INTEGER;
						a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- Angles are measured in radians.
		do
			add_ps ("gsave")
			translate_to (x + (a_bounding_width // 2), (-(y + (a_bounding_height // 2))))
			add_ps ("1 " + (a_bounding_height / a_bounding_width).out + " scale")
			draw_arc_ps (a_bounding_width // 2, ((a_start_angle * 180) / Pi).rounded, (((an_aperture + a_start_angle) * 180) / Pi).rounded)
			add_ps ("stroke")
			add_ps ("grestore")
		end

	draw_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', 'y')
			-- with size `a_width' and `a_height'.
		do
			add_ps ("newpath")
			add_ps (x.out + " " + ( - y).out + " moveto")
			add_ps ((x + a_width).out + " " + ( - y).out + " lineto")
			add_ps ((x + a_width).out + " " + ( - y - a_height).out + " lineto")
			add_ps (x.out + " "  + ( - y - a_height).out + " lineto")
			add_ps ("closepath")
			add_ps ("stroke")
		end

	draw_ellipse (x, y, a_bounding_width, a_bounding_height: INTEGER) is
			-- Draw an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
		do
			add_ps ("gsave")
			translate_to (x + (a_bounding_width // 2), ( - (y + (a_bounding_height //2))))
			add_ps ("newpath")
			add_ps ("1 " + (a_bounding_height / a_bounding_width).out + " scale")
			draw_arc_ps (a_bounding_width // 2, 0, 360)
			add_ps ("closepath")
			add_ps ("stroke")
			add_ps ("grestore")
		end

	draw_polyline (points: ARRAY [EV_COORDINATE]; is_closed: BOOLEAN) is
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		local
			i, nb: INTEGER
			p: EV_COORDINATE
		do
			
			add_ps ("newpath")
			from
				i := points.lower
				nb := points.upper
				p := points.item (i)
				add_ps (p.x.out + " " + (- p.y).out + " moveto")
				i := i + 1
			until
				i > nb
			loop
				p := points.item (i)
				add_ps (p.x.out + " " + (- p.y).out + " lineto")
				i := i + 1
			end
			if is_closed then
				add_ps ("closepath")
			end
			add_ps ("stroke")
		end

	draw_pie_slice (x, y, a_bounding_width, a_bounding_height: INTEGER;
					a_start_angle, an_aperture: REAL) is
			-- Draw part of an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', 'y').
			-- Angles are measured in radians.
		do
			add_ps ("gsave")
			translate_to (x + (a_bounding_width // 2), -(y + (a_bounding_height // 2)))
			draw_pie_slice_ps (a_bounding_height, a_bounding_width, line_width, ((a_start_angle * 180) / Pi).rounded, (((an_aperture + a_start_angle) * 180) / Pi).rounded, dashed_line_style, False)
		end

feature -- Drawing operations (filled)

	fill_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', 'y')
			-- with size `a_width' and `a_height'. Fill with `background_color'.
		do
			
			add_ps ("gsave")
			translate_to (0, 0)
			add_ps ("newpath")
			add_ps (x.out + " " + ( - y).out + " moveto")
			add_ps ((x + a_width).out + " " + ( - y).out + " lineto")
			add_ps ((x + a_width).out + " " + (- y - a_height).out + " lineto")
			add_ps (x.out + " "  + ( - y - a_height).out + " lineto")
			add_ps ("closepath")
			add_ps ("fill")
			add_ps ("stroke")
			add_ps ("grestore")
		end

	fill_ellipse (x, y, a_bounding_width, a_bounding_height: INTEGER) is
			-- Fill an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
		do
			add_ps ("gsave")
			translate_to (x + (a_bounding_width // 2), ( - (y + (a_bounding_height //2))))
			add_ps ("newpath")
			add_ps ("1 " + (a_bounding_height / a_bounding_width).out + " scale")
			draw_arc_ps (a_bounding_width // 2, 0, 360)
			add_ps ("closepath")
			add_ps ("fill")
			add_ps ("stroke")
			add_ps ("grestore")
		end

	fill_polygon (points: ARRAY [EV_COORDINATE]) is
			-- Draw line segments between subsequent points in `points'.
			-- Fill with `background_color'.
		local
			i, nb: INTEGER
			p: EV_COORDINATE
		do
			add_ps ("gsave")
			translate_to (0, 0)
			add_ps ("newpath")
			from
				i := points.lower
				p := points.item (i)
				add_ps (p.x.out + " " + ( - p.y).out + " moveto")
				i := i + 1
				nb := points.upper
			until
				i > nb
			loop
				p := points.item (i)
				add_ps (p.x.out + " " + (- p.y).out + " lineto")
				i := i + 1
			end

			add_ps ("closepath")
			add_ps ("eofill")
			add_ps ("grestore")
		end

	fill_pie_slice (x, y, a_bounding_width, a_bounding_height: INTEGER;
					a_start_angle, an_aperture: REAL) is
			-- Fill part of an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', 'y').
			-- Angles are measured in radians.
		do
			add_ps ("gsave")
			translate_to (x + (a_bounding_width // 2), -(y + (a_bounding_height // 2)))
			draw_pie_slice_ps (a_bounding_height, a_bounding_width, line_width, ((a_start_angle * 180) / Pi).rounded, (((an_aperture + a_start_angle) * 180) / Pi).rounded, False, True)
		end

feature {EV_ANY, EV_ANY_I} -- Command

	destroy is
			-- Destroy underlying native toolkit objects.
			-- Render `Current' unusable.
			-- Any feature calls after a call to destroy are
			-- invalid.
		do
			set_is_destroyed (True)
		end
		
feature {EV_POSTSCRIPT_DRAWABLE} -- Write line
		
	add_ps (a_code: STRING) is
			-- Add `a_code' to postscript data.
		do
			postscript_result.append ("      "+a_code)
			postscript_result.append_character ('%N')
		end
		
feature {NONE} -- Implementation

	draw_arc_ps (a_radius, start_angle, end_angle: INTEGER) is
		do
			add_ps ("0 0 "+a_radius.out+" " + start_angle.out + " " + end_angle.out + " arc")
		end
		
	draw_pie_slice_ps (a_h, a_w, a_line_width, start_angle, end_angle: INTEGER; dashed, filled: BOOLEAN) is
		do
			add_ps ("newpath")
			if (a_w > a_h) then
				add_ps ("1 " + (a_h / a_w).out + " scale")
			else
				add_ps ((a_w / a_h).out + " 1 scale")
			end
			add_ps ("0 0 moveto")
			draw_arc_ps (a_h // 2, start_angle, end_angle)
			add_ps ("closepath")
			if filled then
				add_ps ("fill")
			else
				add_ps ("stroke")
			end
			add_ps ("grestore")
		end

	append_color (a_color: EV_COLOR) is
			-- 
		require
			a_color_not_void: a_color /= Void
		do
			
			add_ps (a_color.out + " setrgbcolor")
		end
		
		
	get_eiffel_header: STRING is
			-- Header dedicated to eiffel.
		do
			Result := "%N%%Generated by:%N%
			%%%EiffelVision2: library of reusable components for ISE Eiffel.%N%
			%%%Copyright (C) 1986-2003 Interactive Software Engineering Inc.%N%
			%%%All rights reserved. Duplication and distribution prohibited.%N%
			%%%May be used only with ISE Eiffel, under terms of user license.%N%
			%%%Contact ISE for any other use.%N%N%
			%%%Interactive Software Engineering Inc.%N%
			%%%ISE Building%N%
			%%%356 Storke Road, Goleta, CA 93117 USA%N%
			%%%Telephone 805-685-1006, Fax 805-685-6869%N%
			%%%Electronic mail <info@eiffel.com>%N%
			%%%Customer support: http://support.eiffel.com%N%
			%%%For latest info see award-winning pages: http://www.eiffel.com%N%N"
		end
		
	postscript_result: STRING
			-- Everithing is drawn to this string.

	real_page_width: INTEGER
			-- page width without border.

	real_page_height: INTEGER
			-- page height without border.

	translate_to (a_x, a_y: INTEGER) is
		do
			add_ps (a_x.out + " " + a_y.out + " " + "translate")
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




end -- class EV_POSTSCRIPT_DRAWABLE_IMP

