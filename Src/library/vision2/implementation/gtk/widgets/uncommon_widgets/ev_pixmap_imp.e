--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision pixmap, GTK implementation."
	status: "See notice at end of class"
	keywords: "drawable, primitives, figures, buffer, bitmap, picture"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_PIXMAP_IMP
	
inherit
	EV_PIXMAP_I
		redefine
			interface,
			flush
		end

	EV_DRAWABLE_IMP
		undefine
			C
		redefine
			interface,
			make,
			width,
			height,
			destroy,
			drawable
		end

	EV_PRIMITIVE_IMP
		undefine
			foreground_color,
			background_color,
			set_foreground_color,
			set_background_color
		redefine
			interface,
			width,
			height,
			destroy
		end

	EV_PIXMAP_ACTION_SEQUENCES_IMP
		redefine
			interface,
			destroy
		end

create
	make

feature {NONE} -- Initialization

	create_mask (a_width, a_height: INTEGER): POINTER is
		local
			fg: POINTER
			maskgc: POINTER
		do
			Result := C.gdk_pixmap_new (
				default_gdk_window,
				a_width, a_height,
				-1
			)
			maskgc := C.gdk_gc_new (Result)
			fg := C.c_gdk_color_struct_allocate
			C.gdk_gc_set_foreground (maskgc, $fg)
			C.gdk_draw_rectangle (Result, maskgc, 1, 0, 0, -1, -1)
			
			C.c_gdk_color_struct_free (fg)
			C.gdk_gc_destroy (maskgc)
		end

	make (an_interface: like interface) is
                        -- Create a gtk pixmap of size (1 * 1).
		local
			gdkpix, gdkmask: POINTER
		do
			base_make (an_interface)
			gdkpix := C.gdk_pixmap_new (default_gdk_window, 1, 1, -1)
			--gdkmask := create_mask (1, 1)
			--| FIXME IEK correctly implement masking function	
			set_c_object (C.gtk_event_box_new)
			gtk_pixmap := C.gtk_pixmap_new (gdkpix, gdkmask)
			C.gtk_container_add (c_object, gtk_pixmap)
			C.gtk_widget_show (gtk_pixmap)
				-- Initialize the GC
			gc := C.gdk_gc_new (C.gtk_pixmap_struct_pixmap (gtk_pixmap))
			C.gdk_gc_set_function (gc, C.GDK_COPY_ENUM)
			initialize_gc
			gcvalues := C.c_gdk_gcvalues_struct_allocate
			C.gdk_gc_get_values (gc, gcvalues)
			init_default_values
		end

	reset_to_size (a_x, a_y: INTEGER) is
			-- Create new pixmap data of size `a_x' by `a_y'.
		local
			gdkpix, gdkmask: POINTER
		do
			unref_data
			gdkpix := C.gdk_pixmap_new (default_gdk_window, a_x, a_y, -1)
			--gdkmask := create_mask (a_x, a_y)
			--| FIXME IEK correctly implement masking function	
			set_pixmap (gdkpix, gdkmask)
		end

feature -- Drawing operations

	flush is
		do
			if is_displayed then
				C.gtk_widget_draw (gtk_pixmap, NULL)
			end
		end

feature -- Measurement

	width: INTEGER is
			-- width of the pixmap.
		local
			wid, hgt: INTEGER
		do
			C.gdk_window_get_size (
				C.gtk_pixmap_struct_pixmap (gtk_pixmap),
				$wid, $hgt
			)
			Result := wid
		end

	height: INTEGER is
			-- height of the pixmap.
		local
			wid, hgt: INTEGER
		do
			C.gdk_window_get_size (
				C.gtk_pixmap_struct_pixmap (gtk_pixmap),
				$wid, $hgt
			)
			Result := hgt
		end


feature -- Element change

	read_from_file (a_file: IO_MEDIUM) is
			-- Load the pixmap described in 'file_name'. 
			-- If the file does not exist or it is in a 
			-- wrong format, an exception is raised.
		local
			pixfile: FILE
			pixmap_buffer: STRING
			gdkpix, gdkmask: POINTER
		do
			pixfile ?= a_file
			unref_data

			if pixfile /= Void then
					-- The medium is a file.
				gdkpix := C.gdk_pixmap_create_from_xpm (
					default_gdk_window,
					$gdkmask,
					NULL,
					eiffel_to_c (pixfile.name)
				)
				set_pixmap (gdkpix, gdkmask) 
			else
					-- The medium is a data stream.
				create pixmap_buffer.make (0)
				--| FIXME  Streamed XPM data has to be perfect or seg fault.
			end				
		end

	read_from_named_file (file_name: STRING) is
			-- Attempt to load pixmap data from a file specified by `file_name'.
			-- May raise `Ev_unknow_image_format' or `Ev_courpt_image_data'
			-- exceptions.
			--|FIXME do this!
		do
			unref_data
			c_ev_load_pixmap ($Current, eiffel_to_c (file_name), $update_fields)
		end

	update_fields (
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
			data_type = Loadpixmap_rgb_data
		local
			gdkpix, gdkmask: POINTER
			i, j: INTEGER
			pix: CHARACTER
			p, pixp: POINTER
			maskgc: POINTER
			color: POINTER
		do
			if error_code /= Loadpixmap_error_noerror then
				(create {EXCEPTIONS}).raise ("Could not load image file.")
			end
			gdkpix := C.gdk_pixmap_new (
				default_gdk_window,
				pixmap_width,
				pixmap_height,
				-1	
					-- No color depth, take from gdk_root_parent.
			)
			C.gdk_draw_rgb_image (
				gdkpix,
				gc,
				0,0,
				pixmap_width,
				pixmap_height,
				C.Gdk_rgb_dither_normal_enum,
				rgb_data,
				pixmap_width * 3
			)
			gdkmask := C.gdk_pixmap_new (
				NULL,
				pixmap_width,
				pixmap_height,
				1	
			)
			maskgc := C.gdk_gc_new (gdkmask)
			check maskgc /= NULL end
			C.gdk_draw_rectangle (gdkmask, maskgc, 1, 0, 0, pixmap_width, pixmap_height)

			color := C.c_gdk_color_struct_allocate
			C.set_gdk_color_struct_pixel (color, 1)
			C.gdk_gc_set_foreground (maskgc, color)

			p := alpha_data
			pixp := p2p ($pix)
			from i := 0 until i >= pixmap_height loop
				from j := 0 until j >= pixmap_width loop
					pixp.memory_copy (p, 1)
					if pix.code > 0 then
						C.gdk_draw_point (gdkmask, maskgc, j, i)
					else 
					end
					p := p + 1
					j := j + 1
				end
				i := i + 1
			end

			C.gdk_gc_destroy (maskgc)
			C.c_gdk_color_struct_free (color)
			--gdkmask := NULL
			set_pixmap (gdkpix, gdkmask)
		end

	set_with_buffer (a_buffer: STRING) is
			-- Load pixmap data from `a_buffer' in memory.
		local
			fg, bg, gdkpix, gdkmask: POINTER
			a: ANY
		do
			unref_data

			a := a_buffer.to_c

			fg := C.c_gdk_color_struct_allocate -- (Black)
			bg := C.c_gdk_color_struct_allocate
				-- Set background to white.
			C.set_gdk_color_struct_red (bg, Max_16_bit)
			C.set_gdk_color_struct_green (bg, Max_16_bit)
			C.set_gdk_color_struct_blue (bg, Max_16_bit)
			
			gdkpix := C.gdk_pixmap_create_from_data (
				default_gdk_window,
				$a, 32, 32, -1, $fg, $bg)

			--gdkmask := create_mask (32, 32)
			--| FIXME IEK correctly implement masking function	

			C.c_gdk_color_struct_free (fg)
			C.c_gdk_color_struct_free (bg)
			
			set_pixmap (gdkpix, gdkmask)
		end	

	set_with_default is
			-- Initialize the pixmap with the default
			-- pixmap (Vision2 logo)
			--
			-- Exceptions "Unable to retrieve icon information"
		do
			unref_data
			c_ev_load_pixmap ($Current, NULL, $update_fields)
		end

	stretch, stretch_image (a_x, a_y: INTEGER) is
			-- Stretch the image to fit in size `a_x' by `a_y'.
		do
		end

	set_size (a_x, a_y: INTEGER) is
			-- Set the size of the pixmap to `a_x' by `a_y'.
		local
			tempgdkpix, gdkmask: POINTER
			foreg_clr: EV_COLOR
		do
			tempgdkpix := C.gdk_pixmap_new (default_gdk_window,
								a_x, a_y, -1)
			create foreg_clr
			foreg_clr.copy (foreground_color)
			set_foreground_color (background_color)
			C.gdk_draw_rectangle (tempgdkpix, gc, 1, 0, 0, -1, -1)
			set_foreground_color (foreg_clr)
			C.gdk_draw_pixmap (
				tempgdkpix,
				gc,
				drawable,
				0, 0, 0, 0,
				width, height
			)
			unref_data
			--gdkmask := create_mask (a_x, a_y)
			--| FIXME IEK correctly implement masking function	
			--| FIXME IEK correctly implement masking function	
			set_pixmap (tempgdkpix, gdkmask)
		end

	destroy is
		do
			Precursor
			C.gdk_gc_unref (gc)
		end

feature -- Access

	raw_image_data: EV_RAW_IMAGE_DATA is
		local
			a_gdkimage, a_visual: POINTER
			a_visual_type, a_pixel: INTEGER
			a_color: POINTER
			a_color_map: POINTER
			a_width: INTEGER
			array_offset, array_size: INTEGER
			array_area: SPECIAL [CHARACTER]
			color_struct_size: INTEGER
temp_alpha: CHARACTER
temp_alpha_int: INTEGER
		do
			create Result.make_with_alpha_zero (width, height)
			Result.set_originating_pixmap (interface)
			a_gdkimage := C.gdk_image_get (C.gtk_pixmap_struct_pixmap (gtk_pixmap), 0, 0, width, height)
			from
				a_width := width * 4
				a_color_map := C.gdk_rgb_get_cmap
				a_visual := C.gdk_colormap_get_visual (a_color_map)
				a_visual_type := C.gdk_visual_struct_type (a_visual)
print ("Visual Type = " + a_visual_type.out + "%N")
				a_color := C.c_gdk_color_struct_allocate
				array_size := a_width * height
				array_area := Result.area
				color_struct_size := C.c_gdk_color_struct_size
temp_alpha_int := 255
temp_alpha := temp_alpha_int.ascii_char
			until
				array_offset = array_size
			loop
				a_pixel := C.gdk_image_get_pixel (
					a_gdkimage,
					(array_offset \\ (a_width) // 4), -- Zero based X coord
					((array_offset) // a_width) -- Zero based Y coord
				)
			--	C.c_gdk_colormap_query_color (a_color_map, a_pixel, $a_color)
				array_area.put (C.gdk_color_struct_red (a_color).ascii_char, array_offset)
				array_area.put (C.gdk_color_struct_green (a_color).ascii_char, array_offset + 1)
				array_area.put (C.gdk_color_struct_blue (a_color).ascii_char, array_offset + 2)
				array_area.put (temp_alpha, array_offset + 3)
				--| FIXME IEK Add support for pixmap alpha.
				array_offset := array_offset + 4
			end
			C.c_gdk_color_struct_free (a_color)
			C.gdk_image_destroy (a_gdkimage)
		end

	mask: POINTER is
			-- Pointer to the GdkBitmap used for masking.
		do
			Result := C.gtk_pixmap_struct_mask (gtk_pixmap)
		end

feature {EV_STOCK_PIXMAPS_IMP} -- Implementation

	set_pixmap (pix, msk: POINTER) is
			-- Set the GtkPixmap using Gdk pixmap data and mask.
		do
			C.gtk_pixmap_set (gtk_pixmap, pix, msk)
		end	

feature {NONE} -- Implementation

	parent_widget: POINTER

	initialize_gc is
			-- Set the foreground color of the GC to black.
		local
			allocated: BOOLEAN
			fg: POINTER
		do
			fg := C.c_gdk_color_struct_allocate
				-- Create the color black (default with calloc)

			allocated := C.gdk_colormap_alloc_color (
				C.gdk_rgb_get_cmap,
				fg,
				False,
				True
			)
			check
				color_has_been_allocated: allocated = True
			end
			C.gdk_gc_set_foreground (gc, fg)
			C.c_gdk_color_struct_free (fg)
		end

feature -- Duplication

	copy_pixmap (other: EV_PIXMAP) is
			-- Update `Current' to have same appearence as `other'.
			-- (So as to satisfy `is_equal'.)
		do
			set_size (other.width, other.height)
			draw_pixmap (0, 0, other)
		end

feature {EV_DRAWABLE_IMP} -- Implementation

	drawable: POINTER is
		do
			Result := C.gtk_pixmap_struct_pixmap (gtk_pixmap)
		end

feature {EV_PIXMAPABLE_IMP, EV_CURSOR_IMP, EV_MULTI_COLUMN_LIST_IMP} -- Implementation

	gtk_pixmap: POINTER
		-- Pointer to the gtk pixmap widget.

feature {EV_STOCK_PIXMAPS_IMP} -- Implementation

	set_from_xpm_data (a_xpm_data: POINTER) is
			-- Pixmap symbolizing a piece of information.
		require
			xpm_data_not_null: a_xpm_data /= NULL
		local
			gdk_pixmap: POINTER
			a_mask: POINTER
			a_style: POINTER
		do
			a_style := C.gtk_widget_get_style (default_gtk_window)
			gdk_pixmap := C.gdk_pixmap_create_from_xpm_d (
				default_gdk_window,
				$a_mask,
				C.gtk_style_struct_bg (a_style),
				-- 1st in array is GTK_STATE_NORMAL
				a_xpm_data
			)
			set_pixmap (gdk_pixmap, a_mask)
		end

feature {NONE} -- Implementation
	
	unref_data is
			-- Remove references to redundant image data.
		do
			C.gdk_pixmap_unref (drawable)
			if mask /= NULL then
				C.gdk_pixmap_unref (mask)
			end
		end

feature -- Externals

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

feature {EV_PIXMAP_I, EV_PIXMAPABLE_IMP} -- Implementation

	interface: EV_PIXMAP

end -- EV_PIXMAP_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.44  2001/07/09 01:53:59  king
--| Temporarily commented out colormap_query external
--|
--| Revision 1.43  2001/07/02 16:19:30  king
--| Corrected pixmap data retrieval
--|
--| Revision 1.42  2001/06/27 00:17:00  king
--| Added gdk image destruction, thanks to DH for reporting Wild bug number 6
--|
--| Revision 1.41  2001/06/19 16:59:17  king
--| Uncommented needed alpha setting
--|
--| Revision 1.40  2001/06/15 19:31:51  king
--| Stopped pixmap retrieval from X server from sigsegv on non pseudo displays
--|
--| Revision 1.39  2001/06/14 20:11:50  king
--| Changed to use rgb cmap
--|
--| Revision 1.38  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.15.2.30  2001/06/01 22:50:44  etienne
--| Fix problem with `set_size' changing `foreground_color'.
--|
--| Revision 1.15.2.29  2001/05/18 18:19:48  king
--| Removed FIXME
--|
--| Revision 1.15.2.28  2001/04/17 21:05:46  king
--| Changed flush so widget is only redrawn if displayed
--|
--| Revision 1.15.2.27  2000/12/21 20:26:05  king
--| Now setting background color on pixmap resize
--|
--| Revision 1.15.2.26  2000/12/21 19:12:39  king
--| Optimized raw_image_data
--|
--| Revision 1.15.2.25  2000/11/20 17:30:22  andrew
--| Corrected raw image data retrieval
--|
--| Revision 1.15.2.24  2000/11/06 19:40:33  king
--| Acccounted for default to stock name change
--|
--| Revision 1.15.2.23  2000/11/04 01:10:41  andrew
--| Improved raw_image_data routine
--|
--| Revision 1.15.2.21  2000/10/27 16:54:46  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.15.2.20  2000/10/07 02:56:31  andrew
--| Update
--|
--| Revision 1.15.2.19  2000/10/03 00:43:48  king
--| Implemented raw_image_data
--|
--| Revision 1.15.2.18  2000/09/06 17:48:45  oconnor
--| Use new default_gdk_window feature instead of gdk_root_parent to try
--| to get a basis for visuals that will work better on workstations that
--| have different color depths for diverent windows.
--|
--| Revision 1.15.2.17  2000/08/28 18:24:57  king
--| Reverted flush implementation
--|
--| Revision 1.15.2.16  2000/08/24 23:18:34  king
--| Implemented flush to use clipping area
--|
--| Revision 1.15.2.15  2000/08/23 23:24:10  king
--| Removed redundant redraw features
--|
--| Revision 1.15.2.13  2000/08/23 23:09:28  king
--| Trying new implementation of flush
--|
--| Revision 1.15.2.11  2000/08/23 00:38:14  king
--| Made compilable with expose AS change
--|
--| Revision 1.15.2.10  2000/08/08 00:03:17  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.15.2.9  2000/08/01 19:31:06  king
--| Changed Default_pointer's to NULL's
--|
--| Revision 1.15.2.8  2000/07/31 18:57:31  king
--| Removed unused local variables
--|
--| Revision 1.15.2.7  2000/07/25 01:16:49  oconnor
--| added EV_PIXMAP_ACTION_SEQUENCES_IMP
--|
--| Revision 1.15.2.6  2000/06/27 23:52:32  king
--| Removed repeated definition of flush
--|
--| Revision 1.15.2.5  2000/05/08 23:02:19  king
--| Tidied up code
--|
--| Revision 1.15.2.4  2000/05/08 21:58:28  king
--| Added set_from_xpm_data
--|
--| Revision 1.15.2.3  2000/05/03 22:00:51  king
--| merged from HEAD
--|
--| Revision 1.36  2000/05/03 21:35:34  king
--| Altered export clause of set_pixmap to EV_DEF_PIX_IMP
--|
--| Revision 1.35  2000/05/03 04:32:08  pichery
--| Added feature `set_with_default'
--|
--| Revision 1.34  2000/05/02 18:55:32  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.33  2000/04/26 17:04:52  oconnor
--| put GtkPixmap in an event box
--|
--| Revision 1.32  2000/04/19 18:27:08  brendel
--| made 1 bit color work on 8bit and high color displays
--|
--| Revision 1.31  2000/04/19 18:07:18  oconnor
--| use propper color map in update_fields
--|
--| Revision 1.30  2000/04/14 16:53:50  oconnor
--| initial implementation of loading mask for pixmap
--|
--| Revision 1.29  2000/04/12 18:53:43  oconnor
--| removed obsolete ref to EV_COMPOSED_ITEM_IMP
--|
--| Revision 1.28  2000/04/12 15:36:04  brendel
--| Added 5 features. To be implemented.
--|
--| Revision 1.27  2000/04/11 22:47:39  oconnor
--| Inherit EV_DRAWABLE_IMP in place of EV_DRAWING_AREA_IMP in line with new
--| interface inheritance.
--| Simplified loading of pixmap from file.
--|
--| Revision 1.26  2000/04/04 20:56:14  oconnor
--| formatting
--|
--| Revision 1.25  2000/03/31 19:50:08  oconnor
--| connected to platform independant C image loader
--|
--| Revision 1.24  2000/03/24 01:31:45  king
--| Commented out mask creation routine in features
--|
--| Revision 1.23  2000/03/21 00:10:05  pichery
--| fixed small bug
--|
--| Revision 1.22  2000/03/21 00:08:30  pichery
--| forgotten to implemented feature `read_from_named_file'.
--|
--| Revision 1.21  2000/03/20 23:53:06  pichery
--| Renammed `copy' to `copy_pixmap'.
--|
--| Revision 1.20  2000/03/20 23:43:50  pichery
--| Moved implementation of `read_from_named_file' from interface
--| to implementation cluster
--|
--| Revision 1.19  2000/03/18 00:55:32  king
--| Added creation of mask, need to implement transparency for cursor
--| compatibility
--|
--| Revision 1.18  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.17  2000/02/15 19:25:29  king
--| Made interface exportable to composed_item
--|
--| Revision 1.16  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.15.2.1.2.17  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.15.2.1.2.16  2000/01/27 19:29:50  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.15.2.1.2.15  2000/01/10 21:52:11  king
--| Initializing gc values struct to avoid invariant violation
--|
--| Revision 1.15.2.1.2.14  1999/12/23 01:38:23  king
--| Removed redundant pointers gdkpix and gdkmask
--|
--| Revision 1.15.2.1.2.13  1999/12/22 20:06:16  king
--| Made pixmap compatible with ev_drawable
--|
--| Revision 1.15.2.1.2.12  1999/12/18 02:21:53  king
--| Implemented make and make_with_buffer and read_from_file
--|
--| Revision 1.15.2.1.2.11  1999/12/09 23:21:39  brendel
--| Changed inheritance structure.
--| Commented out obsolete and inapplicable features.
--|
--| Revision 1.15.2.1.2.10  1999/12/08 17:42:33  oconnor
--| removed more inherited externals
--|
--| Revision 1.15.2.1.2.9  1999/12/07 19:13:59  brendel
--| Ignore previous commit message.
--| Removed undefine of color-related features.
--|
--| Revision 1.15.2.1.2.8  1999/12/07 18:56:16  brendel
--| Changed implementation of width and height to make it more compact.
--| Improved contracts on set_bounds.
--|
--| Revision 1.15.2.1.2.7  1999/12/04 18:59:21  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.15.2.1.2.6  1999/12/03 23:56:43  brendel
--| Added redefine of initialize.
--| Commented out feature destroy.
--|
--| Revision 1.15.2.1.2.5  1999/12/01 01:02:33  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that
--| relied on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.15.2.1.2.4  1999/11/30 23:02:36  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.15.2.1.2.3  1999/11/29 17:37:21  brendel
--| Ignore previous log message. Commented out some old creation stuff. The
--| new one is still to-be-implemented.
--|
--| Revision 1.15.2.1.2.2  1999/11/24 22:48:06  brendel
--| Just managed to compile figure cluster example.
--|
--| Revision 1.15.2.1.2.1  1999/11/24 17:30:00  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.14.2.4  1999/11/23 22:59:48  oconnor
--| added _enum suffix
--|
--| Revision 1.14.2.3  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.14.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
