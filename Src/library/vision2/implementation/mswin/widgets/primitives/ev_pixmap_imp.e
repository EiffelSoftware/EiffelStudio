indexing
	description: "EiffelVision pixmap. Mswindows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXMAP_IMP

inherit
	EV_PIXMAP_I

	EV_DRAWABLE_IMP
		rename
			dc as internal_dc
		redefine
			initialize,
			internal_dc,
			clear_rect,
			draw_point,
			draw_text,
			draw_segment,
			draw_straight_line,
			draw_polyline,
			draw_rectangle,
			draw_arc,
			draw_pixmap,
			fill_polygon,
			fill_rectangle,
			fill_arc
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_with_size

feature {NONE} -- Initialization

	make is
			-- Create an empty pixmap, its size is 1x1.
		local
			screen: WEL_SCREEN_DC
			bmp: WEL_BITMAP
		do
			!! screen
			screen.get
			!! internal_dc.make_by_dc (screen)
			!! bmp.make_compatible (screen, 1, 1)
			internal_dc.select_bitmap (bmp)
			screen.release
			initialize
		end

	make_with_size (w, h: INTEGER) is
			-- Create an empty pixmap, its size is `w' and `h' as size.
		local
			bmp: WEL_BITMAP
			screen: WEL_SCREEN_DC
		do
			!! screen
			screen.get
			!! internal_dc.make_by_dc (screen)
			!! bmp.make_compatible (screen, w, h)
			internal_dc.select_bitmap (bmp)
			screen.release
			initialize
		end

	initialize is
			-- Set some default values.
		local
			default_colors: EV_DEFAULT_COLORS
			color: EV_COLOR
		do
			!! default_colors
			set_background_color (default_colors.Color_dialog)
			!! color.make_rgb (0, 0, 0)
			set_foreground_color (color)
			clear
			{EV_DRAWABLE_IMP} Precursor
		end

feature -- Access

	bitmap: WEL_BITMAP is
			-- Bitmap selected in the internal_dc
		do
			if internal_bitmap /= Void then
				Result := internal_bitmap
			else
				Result := internal_dc.bitmap
			end
		end

	transparent_color: EV_COLOR
			-- Color used as transparent (Void by default).

	parent_imp: EV_DRAWING_AREA_IMP
			-- Parent of the pixmap when it is a drawing
			-- area only. Needed to update this last one.

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?  
		do
			Result := (bitmap = Void)
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			internal_dc.delete
			internal_dc := Void
			internal_bitmap := Void
		end

feature -- Measurement

	width: INTEGER is
			-- Width of the pixmap.
		do
			Result := bitmap.width
		end

	height: INTEGER is
			-- Height of the pixmap.
		do
			Result := bitmap.height
		end

feature -- Status setting

	reference is
			-- Reference the current pixmap.
		do
			if internal_ref = 0 then
				internal_delete_dc
			end
			internal_ref := internal_ref + 1
		end

	unreference is
			-- Unreference the current pixmap.
		do
			internal_ref := internal_ref - 1
			if internal_ref = 0 then
				internal_create_dc
			end

		end

feature -- Element change

	set_transparent_color (value: EV_COLOR) is
			-- Make `value' the new transparent color.
		do
			transparent_color := value
			check
				not_yet_implemented: False
			end
		end

	set_parent (par: EV_DRAWING_AREA_IMP) is
			-- Make `par' the new parent of the pixmap.
		require
			locked: is_locked
		do
			parent_imp := par
		end

feature -- Basic operation

	read_from_file (file_name: STRING) is
			-- Load the pixmap described in 'file_name'. 
			-- If the file does not exist or it is in a 
			-- wrong format, an exception is raised.
		local
			file: RAW_FILE
			dib: WEL_DIB
			bmp:WEL_BITMAP
		do
			!! file.make_open_read (file_name)
			!! dib.make_by_file (file)
			internal_dc.select_palette (dib.palette)
			!! bmp.make_by_dib (internal_dc, dib, Dib_rgb_colors)
			internal_dc.select_bitmap (bmp)
		end

	redraw (left, top, right, bottom: INTEGER) is
			-- Redraw the area if necessary.
		local
			rect: WEL_RECT
		do
			if parent_imp /= Void then
				create rect.make (left, top, right, bottom)
				parent_imp.dc.copy_dc (internal_dc, rect)
			end
		end

--	character_representation: ARRAY [CHARACTER] is
--			-- Return a representation of the pixmap in
--			-- an array of character.
--		local
--			info: WEL_BITMAP_INFO
--			bmp: WEL_BITMAP
--			int: INTEGER
--		do
--			bmp := deep_clone (bitmap)
--			create info.make_by_dc (internal_dc, bmp, Dib_rgb_colors)
--			Result := internal_dc.di_bits (bmp, 0, height, info, Dib_rgb_colors)
--		end

feature -- Implementation

	internal_dc: WEL_MEMORY_DC
			-- A dc to draw on it

	internal_bitmap: WEL_BITMAP
			-- A bitmap kept in memory when the dc is destroyed.

	internal_ref: INTEGER
			-- Number of object that currently use the
			-- bitmap. Drawing areas not counted.

	internal_create_dc is
			-- Create the `internal_dc' that allow to draw on the
			-- pixmap.
		require
			exists: not destroyed
			valid_internal_bitmap: internal_bitmap /= Void
			valid_internal_dc: internal_dc = Void
		local
			screen: WEL_SCREEN_DC
		do
			!! screen
			screen.get
			!! internal_dc.make_by_dc (screen)
			internal_dc.select_bitmap (internal_bitmap)
			internal_bitmap := Void
			screen.release
		ensure
			valid_internal_dc: internal_dc /= Void and internal_dc.exists
			valid_internal_bitmap: internal_bitmap = Void
		end

	internal_delete_dc is
			-- store the bitmap in `internal_bitmap' and 
			-- delete the `internal_dc'.
		require
			exists: not destroyed
			valid_internal_dc: internal_dc /= Void and internal_dc.exists
			valid_internal_bitmap: internal_bitmap = Void
		do
			internal_bitmap := internal_dc.bitmap
			internal_dc.delete
			internal_dc := Void
		ensure
			valid_internal_bitmap: internal_bitmap /= Void
			valid_internal_dc: internal_dc = Void
		end

	internal_mask: WEL_BITMAP is
			-- The mask corresponding to the transparent color.
		require
			exists: not destroyed
		local
			monochrome_dc: WEL_MEMORY_DC
		do
			create monochrome_dc.make
			create Result.make_compatible (monochrome_dc, width, height)
			monochrome_dc.select_bitmap (Result)
		end

feature -- Redefinitions for updating the parent when there is one

	clear_rect (left, top, right, bottom: INTEGER) is
			-- Clear the rectangular area defined by
			-- `a_left', `a_top', `a_right', `a_bottom'.
		do
			{EV_DRAWABLE_IMP} Precursor (left, top, right, bottom)
			redraw (left, top, right, bottom)
		end

	draw_point (pt: EV_COORDINATES) is
			-- Draw `a_point'.
		do
			{EV_DRAWABLE_IMP} Precursor (pt)
			redraw (pt.x, pt.y, pt.x + 1, pt.y + 1)
		end

	draw_text (pt: EV_COORDINATES; text: STRING) is
			-- Draw text
		do
			{EV_DRAWABLE_IMP} Precursor (pt, text)
			redraw (pt.x, pt.y - internal_dc.string_height (text), pt.x + internal_dc.string_width (text), pt.y)
		end

	draw_segment (pt1, pt2: EV_COORDINATES) is
			-- Draw a segment between `pt1' and `pt2'.
		local
			x1, x2, y1, y2: INTEGER
		do
			x1 := pt1.x
			x2 := pt2.x
			y1 := pt1.y
			y2 := pt2.y
			internal_dc.move_to (x1, y1)
			internal_dc.line_to (x2, y2)
			redraw (x1.min (x2), y1.min (y2), x1.max (x2) + 1, y1.max (y2) + 1)
		end

	draw_straight_line (pt1, pt2: EV_COORDINATES) is
			-- Draw an infinite line traversing `pt1' and `pt2'.
			-- Do not work
		do
			{EV_DRAWABLE_IMP} Precursor (pt1, pt2)
			redraw (0, 0, width, height) -- To do
		end

	draw_polyline (pts: ARRAY [EV_COORDINATES]; is_closed: BOOLEAN) is
			-- Draw a polyline, close it automatically if `is_closed'.
		do
			{EV_DRAWABLE_IMP} Precursor (pts, is_closed)
			redraw (0, 0, width, height) -- Probably more efficient to keep it this way.
		end

	draw_rectangle (pt: EV_COORDINATES; w, h: INTEGER; orientation: REAL) is
			-- Draw a rectangle whose center is `pt' and size is `w' and `h'
			-- and that has the orientation `orientation'.
		local
			radius: INTEGER
		do
			{EV_DRAWABLE_IMP} Precursor (pt, w, h, orientation)
			radius := (w.max (h) // 2) + 2
			redraw (pt.x - radius, pt.y - radius, pt.x + radius, pt.y + radius)
		end

	draw_arc (pt: EV_COORDINATES; r1, r2: INTEGER; start_angle, aperture, orientation: REAL; style: INTEGER) is
			-- Draw an arc centered in `pt' with a great radius of `r1' and a small radius
			-- of `r2' beginnning at `start_angle' and finishing at `start_angle + aperture'
			-- and with an orientation of `orientation' using the style `style'.
			-- The meaning of the style is the following :
			--   -1 : no link between the first and the last point
			--    0 : the first point is linked to the last point
			--    1 : the first and the last point are linked to the center `pt'
		local
			radius: INTEGER
		do
			{EV_DRAWABLE_IMP} Precursor (pt, r1, r2, start_angle, aperture, orientation, style)
			radius := r1.max (r2) + 1
			redraw (pt.x - radius, pt.y - radius, pt.x + radius, pt.y + radius)
		end

	draw_pixmap (pt: EV_COORDINATES; pix : EV_PIXMAP) is
			-- Copy `pix' into the drawable at the point `pt'.
		do
			{EV_DRAWABLE_IMP} Precursor (pt, pix)
			redraw (pt.x, pt.y, pt.x + pix.width, pt.y + pix.height)
		end

feature -- Filling operations

	fill_polygon (pts: ARRAY [EV_COORDINATES]) is
			 -- Fill a polygon.
		do
			{EV_DRAWABLE_IMP} Precursor (pts)
			redraw (0, 0, width, height) -- Probably more efficient to keep it this way.
		end

	fill_rectangle (pt: EV_COORDINATES; w, h: INTEGER; orientation: REAL) is
			-- Fill a rectangle whose center is `pt' and size is `w' and `h'
			-- with an orientation `orientation'.
		local
			radius: INTEGER
		do
			{EV_DRAWABLE_IMP} Precursor (pt, w, h, orientation)
			radius := (w.max (h) // 2) + 2
			redraw (pt.x - radius, pt.y - radius, pt.x + radius, pt.y + radius)
		end 

	fill_arc (pt: EV_COORDINATES; r1, r2 : INTEGER; start_angle, aperture, orientation: REAL; style: INTEGER) is
			-- Fill an arc centered in `pt' with a great radius of `r1' and a small radius
			-- of `r2' beginnning at `start_angle' and finishing at `start_angle + aperture'
			-- and with an orientation of `orientation' using the style `style'.
			-- The meaning of the style is the following :
			--   -1 : no link between the first and the last point
			--    0 : the first point is linked to the last point
			--    1 : the first and the last point are linked to the center `pt'
		local
			radius: INTEGER
		do
			{EV_DRAWABLE_IMP} Precursor (pt, r1, r2, start_angle, aperture, orientation, style)
			radius := r1.max (r2) + 1
			redraw (pt.x - radius, pt.y - radius, pt.x + radius, pt.y + radius)
		end

invariant
	not_double_data: not (internal_bitmap /= Void and internal_dc /= Void)
	dc_void_or_valid: (internal_dc /= Void) implies (internal_dc.exists)
	parent_implies_drawable: (parent_imp /= Void) implies (is_drawable)

end -- class EV_PIXMAP_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
