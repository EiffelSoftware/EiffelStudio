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
			set_size,
			on_parented
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
			set_size,
			on_parented
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
			s_dc: WEL_SCREEN_DC
		do
			create s_dc
			s_dc.get
			create bitmap_dc.make_by_dc (s_dc)
			create bitmap.make_compatible (s_dc, 1, 1)
			bitmap_dc.select_bitmap (bitmap)
			s_dc.release

			{EV_DRAWING_AREA_IMP} Precursor
		end

	read_from_file (a_file: IO_MEDIUM) is
			-- Load the pixmap described in 'file_name'. 
			--| FIXME: If the file is in a wrong format, 
			--|        an exception is raised.
		local
			file: RAW_FILE
			dib: EV_WEL_DIB
		do
			create dib.make_by_stream (a_file)
			bitmap_dc.select_palette (dib.palette)
			create bitmap.make_by_dib (bitmap_dc, dib, Dib_rgb_colors)

				-- Initialize the new device context
			dc_to_reset := True
		end

	read_from_named_file (file_name: STRING) is
			-- Load the pixmap described in 'file_name'. 
			--
			-- Exceptions "Unable to retrieve icon information", 
			--            "Unable to load the file"
		local
			filename_ptr: ANY
		do
			filename_ptr := file_name.to_c
			c_ev_load_pixmap($Current, $filename_ptr, $update_fields)
		end

	update_fields(
		error_code		: INTEGER; -- Loadpixmap_error_xxxx 
		data_type		: INTEGER; -- Loadpixmap_hicon, ...
		pixmap_width	: INTEGER; -- Height of the loaded pixmap
		pixmap_height	: INTEGER; -- Width of the loaded pixmap
		rgb_data		: POINTER; -- Pointer on a C memory zone
		alpha_data		: POINTER; -- Pointer on a C memory zone
		) is
			-- Callback function called from the C code by c_ev_load_pixmap.
			-- 
			-- See `read_from_named_file'
			-- Exceptions "Unable to retrieve icon information",
			--            "Unable to load the file"
		require
			valid_data_type: 
				data_type = Loadpixmap_hicon or 
				data_type = Loadpixmap_hbitmap or 
				data_type = Loadpixmap_rgb_data or 
				data_type = Loadpixmap_alpha_data
		local
			icon_info: WEL_ICON_INFO
			dib: WEL_DIB
			size_row: INTEGER
			memory_dc: WEL_MEMORY_DC
		do
			if error_code = Loadpixmap_error_noerror then
					-- No error while loading the file
				if data_type = Loadpixmap_hicon then
						-- create the icon
					create icon.make_by_pointer(rgb_data)

						-- retrieve the bitmap from the icon.
					icon_info := icon.get_icon_info
					if icon_info /= Void then
						bitmap := icon_info.color_bitmap
						mask_bitmap := icon_info.mask_bitmap
					else
						exception_raise ("Unable to retrieve icon information")
					end
				end

				if data_type = Loadpixmap_hbitmap then
					create bitmap.make_by_pointer(rgb_data)
--					bitmap.set_unshared
					create mask_bitmap.make_by_pointer(alpha_data)
--					mask_bitmap.set_unshared
				end

				if data_type = Loadpixmap_rgb_data then
					size_row := 4 * ((pixmap_width * 24 + 31) // 32)
					create dib.make_by_content_pointer (
						rgb_data, 
						size_row * pixmap_height + 40
						)
					create bitmap.make_by_dib (bitmap_dc, dib, Dib_rgb_colors)
					palette := dib.palette

					size_row := 4 * ((pixmap_width * 1 + 31) // 32)
					create dib.make_by_content_pointer (
						alpha_data, 
						size_row * pixmap_height + 40 + 8
						)
					create memory_dc.make
					create mask_bitmap.make_by_dib (
						memory_dc, dib, 
						Dib_rgb_colors
						)
				end
			else
					-- An error occurred while loading the file
				exception_raise ("Unable to load the file")
			end

				-- Initialize the new device context
			dc_to_reset := True
		end
		

feature -- Access

	dc: WEL_DC is
			-- The device context of the control.
		do
			Result := bitmap_dc
		end

	bitmap: WEL_BITMAP
		-- Current bitmap used. Void if not initialized, not
		-- Void otherwise.

	mask_bitmap: WEL_BITMAP
		-- Monochrome bitmap used as mask. Void if none.

	icon: WEL_ICON
		-- Current icon used. Void if none.

	palette: WEL_PALETTE
		-- Current palette used. Void if none.

	transparent_color: EV_COLOR
			-- Color used as transparent (Void by default).

feature -- Status setting

	set_with_buffer (a_buffer: STRING) is
			-- Load pixmap data from `a_buffer' intoemory.
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
			s_dc				: WEL_SCREEN_DC
			mem_dc				: WEL_MEMORY_DC
			old_bitmap_dc		: like bitmap_dc
			old_mask_bitmap_dc	: like mask_bitmap_dc
			old_width			: INTEGER
			old_height			: INTEGER
		do
				-- Operation not possible on icons, so we convert..
			convert_icon_to_bitmap

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
			create bitmap.make_compatible (s_dc, new_width, new_height)
			bitmap_dc.select_bitmap (bitmap)
			s_dc.release

				-- Copy the content of the old bitmap into the
				-- new one
			bitmap_dc.bit_blt(
				0,							-- x source
				0, 							-- y source
				new_width.min(old_width),	-- width source
				new_height.min(old_height),	-- height source
				old_bitmap_dc, 				-- dc source
				0, 							-- x dest.
				0, 							-- y dest.
				Srccopy						-- copy mode
				)

				-- Initialize the new device context
			bitmap_dc.set_background_opaque
			bitmap_dc.set_background_transparent
			reset_pen
			reset_brush

				-- Delete the old bitmap_dc.
			old_bitmap_dc.delete

			------------------------------
			-- Resize the mask (if any) --
			------------------------------
			if mask_bitmap /= Void then
				
					-- Retrieve the current values
				old_mask_bitmap_dc := mask_bitmap_dc

					-- release the old bitmap
				if mask_bitmap_dc.bitmap_selected then
					mask_bitmap_dc.unselect_bitmap
				end
					-- create and assign a new bitmap & bitmap_dc
				create mask_bitmap_dc.make
				create mask_bitmap.make_compatible (
					mask_bitmap_dc, 
					new_width, 
					new_height
					)
				mask_bitmap_dc.select_bitmap (mask_bitmap)

					-- Copy the content of the old bitmap into the
					-- new one
				mask_bitmap_dc.bit_blt(
					0,							-- x source
					0,							-- y source
					new_width.min(old_width),	-- width source
					new_height.min(old_height),	-- height source
					old_mask_bitmap_dc,			-- dc source
					0,							-- x dest.
					0,							-- y dest.
					Srccopy						-- copy mode
					)
			end
		
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

	reset_dc(always_reset: BOOLEAN) is
			-- Perform the reset of the dc.
		do
			if dc_to_reset and (in_container or always_reset) then
				dc_to_reset := False

				if bitmap_dc.palette_selected then
					bitmap_dc.unselect_palette
				end
				if palette /= Void then
					bitmap_dc.select_palette (palette)
				end
	
				if bitmap_dc.bitmap_selected then
					bitmap_dc.unselect_bitmap
				end
				bitmap_dc.select_bitmap (bitmap)

				if mask_bitmap /= Void then
					if mask_bitmap_dc.bitmap_selected then
						mask_bitmap_dc.unselect_bitmap
					end
					mask_bitmap_dc.select_bitmap(mask_bitmap)
				end

				bitmap_dc.set_background_opaque
				bitmap_dc.set_background_transparent
				reset_pen
				reset_brush
				update_display_bitmap := True
			end
		end

feature {NONE} -- Internal states and Operations

	update_display is
			-- Update the screen.
		do
				-- If the bitmap is exposed, then ask for
				-- redrawing it (`invalidate' causes
				-- `paint_bitmap' to be called)
			if parent /= Void then
				invalidate
			end
			update_display_bitmap := True
		end

	update_display_bitmap: BOOLEAN
			-- Should we update the temporary bitmap used
			-- for display.

	dc_to_reset: BOOLEAN
			-- Should we perform a reset of the dc before
			-- drawing?

	in_container: BOOLEAN
			-- Is the pixmap in a container?
	
	on_parented is
			-- `Current' has just been added to a container
		do
			convert_icon_to_bitmap
			dc_to_reset := True
			in_container := True
			reset_dc(True)
			interface.expose_actions.extend (~paint_bitmap)
		end

feature {NONE} -- Implementation

	bitmap_dc: WEL_MEMORY_DC
			-- The DC of the bitmap in memory.

	mask_bitmap_dc: WEL_MEMORY_DC
			-- The DC of the mask bitmap in memory

	display_bitmap: WEL_BITMAP
			-- Temporary bitmap used for display

	display_mask_bitmap: WEL_BITMAP
			-- Temporary bitmap used for display

	display_bitmap_dc: WEL_MEMORY_DC
			-- Temporary device context used for display

	display_mask_dc: WEL_MEMORY_DC
			-- Temporary device context bitmap used for display

	interface: EV_PIXMAP

	destroy is
			-- Destroy actual object.
		do
			bitmap_dc.delete
			screen_dc.delete
		end

	convert_icon_to_bitmap is
			-- Stop using the WEL_ICON internally.
			-- Drawing on a WEL_ICON is not possible so
			-- we stop using icon.
		do
			if icon /= Void then
				dc_to_reset := True		
					-- Stop using the icon...
				icon := Void
			end	
		end

	paint_bitmap (a_x, a_y, a_width, a_height: INTEGER) is
			-- Paint the bitmap onto the screen (i.e. the display_dc).
		local
			wel_rect: WEL_RECT
			bitmap_top, bitmap_left: INTEGER
				-- Coordinates of the top-left corner of the 
				-- bitmap inside the drawn area
			bitmap_right, bitmap_bottom: INTEGER
				-- Coordinates of the bottom-right corner of the
				--- bitmap inside the drawn area
			bitmap_width, bitmap_height: INTEGER
			window_width, window_height: INTEGER
		do
			if bitmap /= Void then

				reset_dc(False)

					-- Compute usefull constants
				bitmap_height := height
				bitmap_width := width
				window_width := display_width
				window_height := display_height
				bitmap_left := (display_width - bitmap_width) // 2
				bitmap_top := (display_height - bitmap_height) // 2
				bitmap_right := bitmap_left + bitmap_width
				bitmap_bottom := bitmap_top + bitmap_height
							
					-- Draw the bitmap (If it is larger than the displayed
					-- area, it will be clipped by Windows.
				if icon /= Void then
						-- Erase the background (otherwise we cannot 
						-- apply the mask
					create wel_rect.make (
						bitmap_left, 
						bitmap_top, 
						bitmap_right, 
						bitmap_bottom
						)
					display_dc.fill_rect(
						wel_rect, 
						our_background_brush
						)

					display_dc.draw_icon(
						icon, 
						bitmap_left, 
						bitmap_top
						)
				elseif mask_bitmap /= Void then

						-- Create the mask and image used for display. 
						-- They are different than the real image because 
						-- we need to apply logical operation in order 
						-- to display the masked bitmap.
					if display_bitmap = Void or 
					   display_mask_bitmap = Void or 
					   update_display_bitmap then
						create display_mask_bitmap.make_by_bitmap(mask_bitmap)
						create display_mask_dc.make_by_dc(display_dc)
						display_mask_dc.select_bitmap(display_mask_bitmap)
						display_mask_dc.pat_blt(
							0, 
							0, 
							bitmap_width, 
							bitmap_height, 
							Dstinvert
							)

						create display_bitmap.make_by_bitmap(bitmap)
						create display_bitmap_dc.make_by_dc(display_dc)
						display_bitmap_dc.select_bitmap(display_bitmap)
						display_bitmap_dc.bit_blt (
							0, 
							0, 
							bitmap_width, 
							bitmap_height, 
							display_mask_dc, 
							0, 
							0, 
							Srcand
							)

						update_display_bitmap := False
					end

						-- Erase the background (otherwise we cannot apply 
						-- the mask
					create wel_rect.make (
						bitmap_left, 
						bitmap_top, 
						bitmap_right, 
						bitmap_bottom
						)
					display_dc.fill_rect(
						wel_rect, 
						our_background_brush
						)

					display_dc.bit_blt (
						bitmap_left, 
						bitmap_top, 
						bitmap_width, 
						bitmap_height, 
						display_mask_dc, 
						0, 
						0, 
						Maskpaint
						)

					display_dc.bit_blt (
						bitmap_left, 
						bitmap_top,
						bitmap_width, 
						bitmap_height, 
						display_bitmap_dc, 
						0, 
						0, 
						Srcpaint
						)
				else
					display_dc.bit_blt (
						bitmap_left, 
						bitmap_top, 
						bitmap_width, 
						bitmap_height, 
						bitmap_dc, 
						0, 
						0, 
						Srccopy
						)
				end
				

					--|  If the displayed area is larger than the bitmap, 
					--|  we erase the background that is outside the bitmap
					--|  (i.e: AREA 1, 2, 3 & 4)
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
					wel_rect.set_rect (
						0, 
						0, 
						window_width, 
						bitmap_top
						)
					display_dc.fill_rect(wel_rect, our_background_brush)
				end

					-- fill AREA 2
				if bitmap_bottom < window_height then
					wel_rect.set_rect (
						0, 
						bitmap_bottom, 
						window_width, 
						window_height
						)
					display_dc.fill_rect(wel_rect, our_background_brush)
				end

					-- fill AREA 3
				if bitmap_left > 0 then
					wel_rect.set_rect (
						0, 
						bitmap_top, 
						bitmap_left, 
						bitmap_bottom
						)
					display_dc.fill_rect(wel_rect, our_background_brush)
				end

					-- fill AREA 4
				if bitmap_right < window_width then
					wel_rect.set_rect (
						bitmap_right, 
						bitmap_top, 
						window_width, 
						bitmap_bottom
						)
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
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor
			update_display
		end

	clear_rectangle (x1, y1, x2, y2: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor (x1, y1, x2, y2)
			update_display
		end

	draw_point (a_x, a_y: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor (a_x, a_y)
			update_display
		end

	draw_text (a_x, a_y: INTEGER; a_text: STRING) is
			-- Call precursor and apply bitmap.
		do
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor (a_x, a_y, a_text)
			update_display
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor (x1, y2, x2, y2)
			update_display
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor (x1, y1, x2, y2)
			update_display
		end

	draw_arc (
		a_x					: INTEGER
		a_y					: INTEGER
		a_vertical_radius	: INTEGER
		a_horizontal_radius	: INTEGER
		a_start_angle		: INTEGER
		an_aperture			: REAL
		) is
			-- Call precursor and apply bitmap.
		do
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor (
				a_x, 
				a_y, 
				a_vertical_radius, 
				a_horizontal_radius, 
				a_start_angle, 
				an_aperture
				)
			update_display
		end

	draw_pixmap (a_x, a_y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Call precursor and apply bitmap.
		do
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor (a_x, a_y, a_pixmap)
			update_display
		end

	draw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor (a_x, a_y, a_width, a_height)
			update_display
		end

	draw_ellipse (
		a_x					: INTEGER
		a_y					: INTEGER
		a_vertical_radius	: INTEGER
		a_horizontal_radius	: INTEGER
		) is
			-- Call precursor and apply bitmap.
		do
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius)
			update_display
		end

	draw_polyline (points: ARRAY [EV_COORDINATES]; is_closed: BOOLEAN) is
			-- Call precursor and apply bitmap.
		do
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor (points, is_closed)
			update_display
		end

	draw_pie_slice (
		a_x					: INTEGER 
		a_y					: INTEGER
		a_vertical_radius	: INTEGER
		a_horizontal_radius	: INTEGER
		a_start_angle		: REAL 
		an_aperture			: REAL
		) is
			-- Call precursor and apply bitmap.
		do
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor (
				a_x, 
				a_y, 
				a_vertical_radius, 
				a_horizontal_radius, 
				a_start_angle, 
				an_aperture
				)
			update_display
		end

	fill_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Call precursor and apply bitmap.
		do
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor (a_x, a_y, a_width, a_height)
			update_display
		end

	fill_ellipse (
		a_x					: INTEGER
		a_y					: INTEGER
		a_vertical_radius	: INTEGER
		a_horizontal_radius	: INTEGER
		) is
			-- Call precursor and apply bitmap.
		do
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor (a_x, a_y, a_vertical_radius, a_horizontal_radius)
			update_display
		end

	fill_polygon (points: ARRAY [EV_COORDINATES]) is
			-- Call precursor and apply bitmap.
		do
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor (points)
			update_display
		end

	fill_pie_slice (
		a_x					: INTEGER
		a_y					: INTEGER
		a_vertical_radius	: INTEGER
		a_horizontal_radius	: INTEGER
		a_start_angle		: REAL
		an_aperture			: REAL
		) is
			-- Call precursor and apply bitmap.
		do
			convert_icon_to_bitmap
			reset_dc(False)
			Precursor (
				a_x, 
				a_y, 
				a_vertical_radius, 
				a_horizontal_radius, 
				a_start_angle, 
				an_aperture
				)
			update_display
		end

feature -- Duplication

	copy_pixmap (other: EV_PIXMAP) is
			-- Update `Current' to have same appearence as `other'.
			-- (So as to satisfy `is_equal'.)
		local
			other_implementation: like Current
		do
			other_implementation ?= other.implementation
			bitmap_dc ?= other_implementation.dc
			bitmap := other_implementation.bitmap
			mask_bitmap := other_implementation.mask_bitmap
			icon := other_implementation.icon
			transparent_color := other_implementation.transparent_color
		end

feature -- Obsolete

	internal_dc: WEL_MEMORY_DC is
		obsolete
			"Use: dc"
		do
			Result := bitmap_dc
		end

	character_representation: ARRAY [CHARACTER] is
			-- Return a representation of the pixmap in
			-- an array of character.
		local
			info: WEL_BITMAP_INFO
		do
			create info.make_by_dc (bitmap_dc, bitmap, Dib_rgb_colors)
			Result := bitmap_dc.di_bits (
				bitmap, 
				0, 
				height, 
				info, 
				Dib_rgb_colors
				)
		end

feature {NONE} -- Externals

	c_ev_load_pixmap(
		curr_object: POINTER; 
		file_name: POINTER; 
		update_fields_routine: POINTER
		) is
		external
			"C | %"load_pixmap.h%""
		end

	Loadpixmap_error_noerror: INTEGER is 0
	Loadpixmap_rgb_data: INTEGER is 0
	Loadpixmap_alpha_data: INTEGER is 1
	Loadpixmap_hicon: INTEGER is 2
	Loadpixmap_hbitmap: INTEGER is 3

invariant
	bitmap_not_void: is_initialized implies bitmap /= Void
	mask_consistent: mask_bitmap /= Void implies mask_bitmap_dc /= Void

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
--| Revision 1.23  2000/03/28 19:18:27  pichery
--| - Implemented `set_size'
--| - Formatting
--|
--| Revision 1.22  2000/03/23 23:24:14  brendel
--| Renamed on_contained to on_parented.
--|
--| Revision 1.21  2000/03/20 23:18:02  pichery
--| - Entirely reviewed the implementation of pixmaps.
--| - Added mask notion
--| - Added ICON support (a pixmap can be internally stored as an HICON)
--| - Added multiple format loading (Currently supported under Windows: BMP,
--|   ICO & PNG)
--|
--| Revision 1.20  2000/02/25 01:07:51  pichery
--| Added a small trick to speed up the display of pixmaps under Windows.
--|
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
--| implemented the newly added features: redraw_rectangle, clear_and_redraw, 
--| clear_and_redraw_rectangle
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
--| added set_with_buffer and stretch, both are not yet implemented yet
--| though. read from_file now takes an IO_MEDIUM.
--|
--| Revision 1.12.6.2  1999/12/17 00:20:17  rogers
--| Altered to fit in with the review branch. Also altered to allow 
--| compilation. The last version commited to CVS would not compile at all. 
--| These changes have not been tested thoroughly.
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
