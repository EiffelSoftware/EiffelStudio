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

	EV_DRAWING_AREA_IMP
		redefine
			make,
			interface,
			width,
			height,
			destroy,
			drawable
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
                        -- Create a gtk pixmap of size (1 * 1).
		local
			gdkpix: POINTER
		do
			base_make (an_interface)
			gdkpix := C.gdk_pixmap_new (C.gdk_root_parent, 1, 1, -1)
			set_c_object (C.gtk_pixmap_new (gdkpix, default_pointer))
			C.gtk_widget_show (c_object)

				-- Initialize the GC
			gc := C.gdk_gc_new (C.gtk_pixmap_struct_pixmap (c_object))
			C.gdk_gc_set_function (gc, C.GDK_COPY_ENUM)
			initialize_gc
			gcvalues := C.c_gdk_gcvalues_struct_allocate
			C.gdk_gc_get_values (gc, gcvalues)
			init_default_values
		end

	reset_to_size (a_x, a_y: INTEGER) is
			-- Create new pixmap data of size `a_x' by `a_y'.
		local
			gdkpix: POINTER
		do
			unref_data
			gdkpix := C.gdk_pixmap_new (C.gdk_root_parent, a_x, a_y, -1)
			set_pixmap (gdkpix, default_pointer)
		end

feature -- Measurement

	width: INTEGER is
			-- width of the pixmap.
		local
			wid, hgt: INTEGER
		do
			C.gdk_window_get_size (C.gtk_pixmap_struct_pixmap (c_object), $wid, $hgt)
			Result := wid
		end

	height: INTEGER is
			-- height of the pixmap.
		local
			wid, hgt: INTEGER
		do
			C.gdk_window_get_size (C.gtk_pixmap_struct_pixmap (c_object), $wid, $hgt)
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

	set_with_buffer (a_buffer: STRING) is
			-- Load pixmap data from `a_buffer' in memory.
		local
			fg, bg, gdkpix: POINTER
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

			C.c_gdk_color_struct_free (fg)
			C.c_gdk_color_struct_free (bg)
			set_pixmap (gdkpix, default_pointer)
		end	

	stretch, stretch_image (a_x, a_y: INTEGER) is
			-- Stretch the image to fit in size `a_x' by `a_y'.
		do
		end

	set_size (a_x, a_y: INTEGER) is
			-- Set the size of the pixmap to `a_x' by `a_y'.
		local
			tempgdkpix: POINTER
			wid, hgt: INTEGER
		do
			tempgdkpix := C.gdk_pixmap_new (C.gdk_root_parent,
								a_x, a_y, -1)
			C.gdk_draw_pixmap (tempgdkpix, gc, drawable, 0, 0, 0, 0, width, height)
			unref_data	
			set_pixmap (tempgdkpix, default_pointer)
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
			Result := C.gtk_pixmap_struct_mask (c_object)
		end	

feature {NONE} -- Implementation

	parent_widget: POINTER

	set_pixmap (pix, msk: POINTER) is
			-- Set the GtkPixmap using Gdk pixmap data and mask.
		do
			C.gtk_pixmap_set (c_object, pix, msk)
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

feature {EV_DRAWABLE_IMP} -- Implementation

	drawable: POINTER is
		do
			Result := C.gtk_pixmap_struct_pixmap (c_object)
		end

feature {EV_PIXMAP_I, EV_PIXMAPABLE_IMP} -- Implementation

	interface: EV_PIXMAP

feature {NONE} -- Implementation
	
	unref_data is
			-- Remove references to redundant image data.
		do
			C.gdk_pixmap_unref (drawable)
			if mask /= default_pointer then
				C.gdk_pixmap_unref (mask)
			end
		end

end -- EV_PIXMAP_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that relied on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.15.2.1.2.4  1999/11/30 23:02:36  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.15.2.1.2.3  1999/11/29 17:37:21  brendel
--| Ignore previous log message. Commented out some old creation stuff. The new one is still to-be-implemented.
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
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
