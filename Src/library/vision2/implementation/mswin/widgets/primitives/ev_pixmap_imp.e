--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision pixmap. Mswindows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXMAP_IMP

inherit
	EV_PIXMAP_I
		redefine
			interface
		end

	EV_DRAWING_AREA_IMP
		undefine
			width,
			height,
			destroy
		redefine
			clear,
			clear_rect,
			draw_point,
			draw_text,
			draw_segment,
			draw_straight_line,
			draw_arc,
			draw_pixmap,
			draw_rectangle,
			draw_ellipse,
			draw_polyline,
			draw_pie_slice,
			fill_rectangle,
			fill_ellipse,
			fill_polygon,
			fill_pie_slice,
			interface,
			initialize,
			dc
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	--| We have the DC for drawing area, but we want that to be
	--| the one for the pixmap, and redefine all primitives to apply
	--| the updated bitmap-dc to the screen-dc.

	initialize is
		local
			bmp: WEL_BITMAP
			s_dc: WEL_SCREEN_DC
		do
			create s_dc
			s_dc.get
			create bitmap_dc.make_by_dc (s_dc)
			create bmp.make_compatible (s_dc, 1, 1)
			bitmap_dc.select_bitmap (bmp)

			{EV_DRAWING_AREA_IMP} Precursor
		end

feature -- Access

	dc: WEL_DC is
			-- The device context of the control.
		do
			Result := bitmap_dc
		end

	bitmap_dc: WEL_MEMORY_DC
			-- The DC of the bitmap in memory.

	bitmap: WEL_BITMAP is
			-- Bitmap selected in the internal_dc
		do
			Result := bitmap_dc.bitmap
		end

	transparent_color: EV_COLOR
			-- Color used as transparent (Void by default).

feature -- Status setting

	set_with_buffer (a_buffer: STRING) is
			-- Load pixmap data from `a_buffer' in memory.
		do
			--|FIXME Implement
			check
				not_yet_implemented: False
			end
		end

	stretch, stretch_image (a_x, a_y: INTEGER) is
			-- Stretch the image to fit in size `a_x' by `a_y'.
		do
			--|FIXME Implement
			check
				not_yet_implemented: False
			end
		end

feature -- Measurement

	width: INTEGER is
			-- Width of the pixmap.
		do
			if bitmap /= Void then
				Result := bitmap.width
			end
		end

	height: INTEGER is
			-- Height of the pixmap.
		do
			if bitmap /= Void then
				Result := bitmap.height
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

feature -- Basic operation

	read_from_file (a_file: IO_MEDIUM) is
			-- Load the pixmap described in 'file_name'. 
			-- If the file does not exist or it is in a 
			-- wrong format, an exception is raised.
		local
			file: RAW_FILE
			dib: WEL_DIB
			bmp:WEL_BITMAP
		do
			file ?= a_file
			check
				a_file_not_void: file /= Void
			end
			!! dib.make_by_file (file)
			bitmap_dc.select_palette (dib.palette)
			!! bmp.make_by_dib (bitmap_dc, dib, Dib_rgb_colors)
			bitmap_dc.select_bitmap (bmp)
		end

	apply_bitmap is
			-- Copy the bitmap-dc to the screen-dc.
		do
			if False then --| FIXME if on_screen then ...
				screen_dc.copy_dc (bitmap_dc, create {WEL_RECT}.make_window (screen_dc.window))
			end
		end

feature -- Implementation

	interface: EV_PIXMAP

	destroy is
			-- Destroy actual object.
		do
			bitmap_dc.delete
			screen_dc.delete
		end

feature -- Drawing primitives

	clear is
			-- Call precursor and apply bitmap.
		do
			Precursor
			apply_bitmap
		end

	clear_rect (x1, y1, x2, y2: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (x1, y1, x2, y2)
			apply_bitmap
		end

	draw_point (a_x, a_y: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y)
			apply_bitmap
		end

	draw_text (a_x, a_y: INTEGER; a_text: STRING) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_text)
			apply_bitmap
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (x1, y2, x2, y2)
			apply_bitmap
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (x1, y1, x2, y2)
			apply_bitmap
		end

	draw_arc (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius, a_start_angle, an_aperture)
			apply_bitmap
		end

	draw_pixmap (a_x, a_y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_pixmap)
			apply_bitmap
		end

	draw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_width, a_height)
			apply_bitmap
		end

	draw_ellipse (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius)
			apply_bitmap
		end

	draw_polyline (points: ARRAY [EV_COORDINATES]; is_closed: BOOLEAN) is
			-- Call precursor and apply bitmap.
		do
			Precursor (points, is_closed)
			apply_bitmap
		end

	draw_pie_slice (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius, a_start_angle, an_aperture)
			apply_bitmap
		end

	fill_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_width, a_height)
			apply_bitmap
		end

	fill_ellipse (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius)
			apply_bitmap
		end

	fill_polygon (points: ARRAY [EV_COORDINATES]) is
			-- Call precursor and apply bitmap.
		do
			Precursor (points)
			apply_bitmap
		end

	fill_pie_slice (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius, a_start_angle, an_aperture)
			apply_bitmap
		end

feature -- Obsolete

	internal_dc: WEL_MEMORY_DC is
		obsolete
			"Use: dc"
		do
			Result := bitmap_dc
		end

--	internal_mask: WEL_BITMAP is
--			-- The mask corresponding to the transparent color.
--		require
--		local
--			monochrome_dc: WEL_MEMORY_DC
--		do
--			create monochrome_dc.make
--			create Result.make_compatible (monochrome_dc, width, height)
--			monochrome_dc.select_bitmap (Result)
--		end

--	internal_dc: WEL_MEMORY_DC
			-- A dc to draw on it

--	internal_bitmap: WEL_BITMAP
			-- A bitmap kept in memory when the dc is destroyed.

--	internal_ref: INTEGER
			-- Number of object that currently use the
			-- bitmap. Drawing areas not counted.

	character_representation: ARRAY [CHARACTER] is
			-- Return a representation of the pixmap in
			-- an array of character.
		local
			info: WEL_BITMAP_INFO
			bmp: WEL_BITMAP
			int: INTEGER
		do
			bmp := deep_clone (bitmap_dc.bitmap)
			create info.make_by_dc (bitmap_dc, bmp, Dib_rgb_colors)
			Result := bitmap_dc.di_bits (bmp, 0, height, info, Dib_rgb_colors)
		end

	redraw (left, top, right, bottom: INTEGER) is
			-- Redraw the area if necessary.
		local
			rect: WEL_RECT
		do
--			if parent_imp /= Void then
--				create rect.make (left, top, right, bottom)
--				parent_imp.dc.copy_dc (internal_dc, rect)
--			end
		end

--	reference is
			-- Reference the current pixmap.
--		do
--			if internal_ref = 0 then
--				internal_delete_dc
--			end
--			internal_ref := internal_ref + 1
--		end

--	unreference is
--			-- Unreference the current pixmap.
--		do
--			internal_ref := internal_ref - 1
--			if internal_ref = 0 then
--				internal_create_dc
--			end

--		end

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.13  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.6.10  2000/01/29 01:05:04  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.12.6.9  2000/01/27 19:30:31  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.6.8  2000/01/21 23:20:08  brendel
--| Changed apply_pixmap to do nothing temporarily.
--|
--| Revision 1.12.6.7  2000/01/20 18:30:51  king
--| Changed export status of interface.
--| Fixed compiler error in character_representation.
--|
--| Revision 1.12.6.6  2000/01/20 18:01:46  king
--| Renamed internal_dc to bitmap_dc.
--| Updated with new EV_DRAWABLE.
--| Moved useless features to Obsolete clause at bottom.
--|
--| Revision 1.12.6.5  2000/01/19 17:56:28  king
--| Changed to comply with EV_DRAWABLE.
--|
--| Revision 1.12.6.4  2000/01/18 01:31:14  king
--| Removed old invariant.
--|
--| Revision 1.12.6.3  1999/12/22 19:26:37  rogers
--| added set_with_buffer and stretch, both are not yet implemented yet though. read from_file now takes an IO_MEDIUM.
--|
--| Revision 1.12.6.2  1999/12/17 00:20:17  rogers
--| Altered to fit in with the review branch. Also altered to allow compilation. The last version commited to CVS would not compile at all. These changes have not been tested thoroughly.
--|
--| Revision 1.12.6.1  1999/11/24 17:30:36  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.2.4  1999/11/04 23:10:46  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.12.2.3  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
