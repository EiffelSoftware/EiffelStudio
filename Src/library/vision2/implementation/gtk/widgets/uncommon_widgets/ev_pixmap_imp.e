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
			interface
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

create
	make

feature {NONE} -- Initialization

	create_mask (a_width, a_height: INTEGER): POINTER is
		local
			fg: POINTER
			maskgc: POINTER
		do
			Result := C.gdk_pixmap_new (
				C.gdk_root_parent,
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
			gdkpix := C.gdk_pixmap_new (C.gdk_root_parent, 1, 1, -1)
			--gdkmask := create_mask (1, 1)
			--| FIXME IEK correctly implement masking function	
			set_c_object (C.gtk_event_box_new)
			gtk_pixmap := C.gtk_pixmap_new (gdkpix, gdkmask)
			C.gtk_widget_show (gtk_pixmap)
			C.gtk_container_add (c_object, gtk_pixmap)
--|hmm?		C.gtk_widget_show (c_object)

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
			gdkpix := C.gdk_pixmap_new (C.gdk_root_parent, a_x, a_y, -1)
			--gdkmask := create_mask (a_x, a_y)
			--| FIXME IEK correctly implement masking function	
			set_pixmap (gdkpix, gdkmask)
		end

feature -- Drawing operations

	redraw is
			-- Redraw the window without clearing it.
		do
			check false end
		end

	redraw_rectangle (x1, y1, x2, y2: INTEGER) is
			-- Redraw the rectangle (`x1',`y1') - (`x2', `y2')
		do
			check false end
		end

	clear_and_redraw is
			-- Redraw the window after clearing it.
		do
			check false end
		end

	clear_and_redraw_rectangle (x1, y1, x2, y2: INTEGER) is
			-- Clear and Redraw the rectangle (`x1',`y1') - (`x2', `y2')
		do
			check false end
		end

	flush is
			-- Update immediately the screen if needed
		do
			check false end
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
			a: ANY
			pixmap_buffer: STRING
			gdkpix, gdkmask: POINTER
		do
			pixfile ?= a_file
			unref_data

			if pixfile /= Void then
					-- The medium is a file.
				a := pixfile.name.to_c
				gdkpix := C.gdk_pixmap_create_from_xpm (
						C.gdk_root_parent,
						$gdkmask, default_pointer, $a)
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
			bitmap: POINTER
			maskgc: POINTER
			color: POINTER
			bool: BOOLEAN
		do
			if error_code /= Loadpixmap_error_noerror then
				(create {EXCEPTIONS}).raise ("Could not load image file.")
			end
			gdkpix := C.gdk_pixmap_new (
				C.gdk_root_parent,
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
				C.gdk_root_parent,
				$a, 32, 32, -1, $fg, $bg)

			--gdkmask := create_mask (32, 32)
			--| FIXME IEK correctly implement masking function	

			C.c_gdk_color_struct_free (fg)
			C.c_gdk_color_struct_free (bg)
			
			set_pixmap (gdkpix, gdkmask)
		end	

	stretch, stretch_image (a_x, a_y: INTEGER) is
			-- Stretch the image to fit in size `a_x' by `a_y'.
		do
		end

	set_size (a_x, a_y: INTEGER) is
			-- Set the size of the pixmap to `a_x' by `a_y'.
		local
			tempgdkpix, gdkmask: POINTER
			wid, hgt: INTEGER
		do
			tempgdkpix := C.gdk_pixmap_new (C.gdk_root_parent,
								a_x, a_y, -1)
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

	mask: POINTER is
			-- Pointer to the GdkBitmap used for masking.
		do
			Result := C.gtk_pixmap_struct_mask (gtk_pixmap)
		end	

feature {NONE} -- Implementation

	parent_widget: POINTER

	set_pixmap (pix, msk: POINTER) is
			-- Set the GtkPixmap using Gdk pixmap data and mask.
		do
			C.gtk_pixmap_set (gtk_pixmap, pix, msk)
		end

	initialize_gc is
			-- Set the foreground color of the GC to black.
		local
			allocated: BOOLEAN
			fg: POINTER
		do
			fg := C.c_gdk_color_struct_allocate
				-- Create the color black (default with calloc)

			allocated := C.gdk_colormap_alloc_color (
				C.gdk_colormap_get_system,
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

feature {EV_PIXMAP_I, EV_PIXMAPABLE_IMP} -- Implementation

	interface: EV_PIXMAP

feature {EV_PIXMAPABLE_IMP, EV_CURSOR_IMP, EV_MULTI_COLUMN_LIST_IMP} -- Implementation

	gtk_pixmap: POINTER

feature {NONE} -- Implementation
	
	unref_data is
			-- Remove references to redundant image data.
		do
			C.gdk_pixmap_unref (drawable)
			if mask /= default_pointer then
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
