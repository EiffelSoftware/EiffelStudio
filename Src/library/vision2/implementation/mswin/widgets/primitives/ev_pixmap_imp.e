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
		rename
			dc as display_dc,
			height as display_height,
			width as display_width
		redefine
			destroy,
			clear,
			clear_rectangle,
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
			set_size
		end

	EV_DRAWING_AREA_IMP
		redefine
			dc,
			destroy,
			width,
			height,
			clear,
			clear_rectangle,
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
			set_size
		select
			dc,
			width,
			height
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
			s_dc.release

			interface.expose_actions.extend (~paint_bitmap)

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
			-- Current Bitmap displayed on the screen.
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

	set_size (new_width, new_height: INTEGER) is
			-- Resize the current bitmap. If the new size
			-- is smaller than the old one, the bitmap is
			-- clipped.
		local
			bmp: WEL_BITMAP
			s_dc: WEL_SCREEN_DC
			old_bitmap_dc: like bitmap_dc
			old_width, old_height: INTEGER
		do
				-- Retrieve the current values
			old_bitmap_dc := bitmap_dc
			old_width := width
			old_height := height

				-- release the old bitmap
			if bitmap_dc.bitmap_selected then
				bitmap_dc.unselect_bitmap
			end
				-- create and assign a new bitmap & bitmap_dc
			create s_dc
			s_dc.get
			create bitmap_dc.make_by_dc (s_dc)
			create bmp.make_compatible (s_dc, new_width, new_height)
			bitmap_dc.select_bitmap (bmp)
			s_dc.release

				-- Copy the content of the old bitmap into the
				-- new one
			bitmap_dc.bit_blt(0, 0, new_width.min(old_width), new_height.min(old_height),
				old_bitmap_dc, 0, 0, Srccopy)

				-- Initialize the new device context
			bitmap_dc.set_background_opaque
			bitmap_dc.set_background_transparent
			reset_pen
			reset_brush

				-- Delete the old bitmap_dc.
			old_bitmap_dc.delete
		
				-- Finally, call the precursor.
			Precursor (new_width, new_height)
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
			dib: EV_WEL_DIB
			bmp:WEL_BITMAP
		do
			create dib.make_by_stream (a_file)
			bitmap_dc.select_palette (dib.palette)
			create bmp.make_by_dib (bitmap_dc, dib, Dib_rgb_colors)
			bitmap_dc.select_bitmap (bmp)
		end

	update_display is
			-- Update the display.
		do
				-- If the bitmap is exposed, then ask for
				-- redrawing it (`invalidate' causes
				-- `paint_bitmap' to be called)
			if parent /= Void then
				invalidate
			end
		end

feature {NONE} -- Implementation

	interface: EV_PIXMAP

	destroy is
			-- Destroy actual object.
		do
			bitmap_dc.delete
			screen_dc.delete
		end

	paint_bitmap (a_x, a_y, a_width, a_height: INTEGER) is
			-- Paint the bitmap onto the screen (i.e. the display_dc).
		local
			wel_rect: WEL_RECT
			bitmap_top, bitmap_left: INTEGER
				-- coordinates of the top-left corner of the bitmap inside the drawn area
			bitmap_right, bitmap_bottom: INTEGER
				-- coordinates of the bottom-right corner of the bitmap inside the drawn area
			bitmap_width, bitmap_height: INTEGER
		do
			if bitmap /= Void then
					-- Compute usefull constants
				bitmap_height := bitmap.height
				bitmap_width := bitmap.width
				bitmap_left := (display_width - bitmap_width) // 2
				bitmap_top := (display_height - bitmap_height) // 2
				bitmap_right := bitmap_left + bitmap_width
				bitmap_bottom := bitmap_top + bitmap_height
							
					-- Draw the bitmap (If it is larger than the displayed
					-- area, it will be clipped by Windows.
				display_dc.bit_blt (bitmap_left, bitmap_top, bitmap_width, bitmap_height, bitmap_dc, 0, 0, Srccopy)

					--|  if the displayed area is larger than the bitmap, we erase the
					--|  background that is outside the bitmap (i.e: AREA 1, 2, 3 & 4)
					--|
					--|  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
					--|  X                             X
					--|  X          AREA 1             X
					--|  X                             X
					--|  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
					--|  X         X         X         X
					--|  X AREA 3  X BITMAP  X  AREA 4 X
					--|  X         X         X         X
					--|  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
					--|  X                             X
					--|  X          AREA 2             X
					--|  X                             X
					--|  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

				create wel_rect.make (0, 0, 0, 0)
					-- fill AREA 1
				if bitmap_top > 0 then
					wel_rect.set_rect (0, 0, display_width, bitmap_top)
					display_dc.fill_rect(wel_rect, our_background_brush)
				end

					-- fill AREA 2
				if bitmap_bottom < display_height then
					wel_rect.set_rect (0, bitmap_bottom, display_width, display_height)
					display_dc.fill_rect(wel_rect, our_background_brush)
				end

					-- fill AREA 3
				if bitmap_left > 0 then
					wel_rect.set_rect (0, bitmap_top, bitmap_left, bitmap_bottom)
					display_dc.fill_rect(wel_rect, our_background_brush)
				end

					-- fill AREA 4
				if bitmap_right < display_width then
					wel_rect.set_rect (bitmap_right, bitmap_top, display_width, bitmap_bottom)
					display_dc.fill_rect(wel_rect, our_background_brush)
				end
			else
					-- Simply erase the background.
				create wel_rect.make (0, 0, display_width, display_height)
				display_dc.fill_rect(wel_rect, our_background_brush)
			end
		end

feature -- Drawing primitives

	clear is
			-- Call precursor and apply bitmap.
		do
			Precursor
			update_display
		end

	clear_rectangle (x1, y1, x2, y2: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (x1, y1, x2, y2)
			update_display
		end

	draw_point (a_x, a_y: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y)
			update_display
		end

	draw_text (a_x, a_y: INTEGER; a_text: STRING) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_text)
			update_display
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (x1, y2, x2, y2)
			update_display
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (x1, y1, x2, y2)
			update_display
		end

	draw_arc (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius, a_start_angle, an_aperture)
			update_display
		end

	draw_pixmap (a_x, a_y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_pixmap)
			update_display
		end

	draw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_width, a_height)
			update_display
		end

	draw_ellipse (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius)
			update_display
		end

	draw_polyline (points: ARRAY [EV_COORDINATES]; is_closed: BOOLEAN) is
			-- Call precursor and apply bitmap.
		do
			Precursor (points, is_closed)
			update_display
		end

	draw_pie_slice (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius, a_start_angle, an_aperture)
			update_display
		end

	fill_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_width, a_height)
			update_display
		end

	fill_ellipse (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius)
			update_display
		end

	fill_polygon (points: ARRAY [EV_COORDINATES]) is
			-- Call precursor and apply bitmap.
		do
			Precursor (points)
			update_display
		end

	fill_pie_slice (a_x, a_y, a_vertical_radius, a_horizontal_radius: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Call precursor and apply bitmap.
		do
			Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius, a_start_angle, an_aperture)
			update_display
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

	redraw_pixmap (left, top, right, bottom: INTEGER) is
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
--| Revision 1.19  2000/02/24 05:06:35  pichery
--| Work on the Windows implementation of EV_PIXMAP. Some work remains but
--| the main part is done.
--|
--| Revision 1.18  2000/02/20 20:29:27  pichery
--| created a factory that build WEL objects (pens & brushes). This factory
--| keeps created objects into an hashtable in order to avoid multiple object
--| creation for the same pen or brush.
--| factory is here used to retrieve pens and brushes in drawing areas
--|
--| Revision 1.17  2000/02/19 06:57:54  manus
--| fixed broken fixme
--|
--| Revision 1.16  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.15  2000/02/16 20:16:15  pichery
--| - implemented set_size for EV_PIXMAP under windows.
--|
--| Revision 1.14  2000/02/16 18:08:52  pichery
--| implemented the newly added features: redraw_rectangle, clear_and_redraw, clear_and_redraw_rectangle
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
