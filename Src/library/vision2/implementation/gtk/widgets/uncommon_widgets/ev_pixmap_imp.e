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
			destroy,
			dispose
		end

	EV_PIXMAP_ACTION_SEQUENCES_IMP
		redefine
			interface,
			destroy
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk pixmap of size (1 * 1) with no mask.
		local
			gdkpix, gdkmask: POINTER
		do
			base_make (an_interface)
			
				-- Create a new pixmap
			gdkpix := C.gdk_pixmap_new (default_gdk_window, 1, 1, Default_color_depth)
				-- Box the pixmap into a container to receive events
			set_c_object (C.gtk_event_box_new)
			gtk_pixmap := C.gtk_pixmap_new (gdkpix, gdkmask)
			C.gdk_pixmap_unref (gdkpix)
			
			C.gtk_container_add (c_object, gtk_pixmap)
			C.gtk_widget_show (gtk_pixmap)

				-- Initialize the Graphical Context
			gc := C.gdk_gc_new (C.gtk_pixmap_struct_pixmap (gtk_pixmap))
			C.gdk_gc_set_function (gc, C.GDK_COPY_ENUM)
			initialize_graphical_context
			init_default_values
		end

	reset_to_size (a_x, a_y: INTEGER) is
			-- Create new pixmap data of size `a_x' by `a_y'.
		local
			gdkpix, gdkmask: POINTER
			loc_default_pointer: POINTER
		do
			gdkpix := C.gdk_pixmap_new (default_gdk_window, a_x, a_y, Default_color_depth)
			if mask /= loc_default_pointer then
				gdkmask := C.gdk_pixmap_new (NULL, a_x, a_y, Monochrome_color_depth)
			end
			set_pixmap (gdkpix, gdkmask)
		end

feature -- Drawing operations

	flush is
		do
			if is_show_requested then
				C.gtk_widget_draw (gtk_pixmap, NULL)
			end
		end

feature -- Measurement

	width: INTEGER is
			-- width of the pixmap.
		local
			wid, hgt: INTEGER
		do
			C.gdk_window_get_size (C.gtk_pixmap_struct_pixmap (gtk_pixmap), $wid, $hgt)
			Result := wid
		end

	height: INTEGER is
			-- height of the pixmap.
		local
			wid, hgt: INTEGER
		do
			C.gdk_window_get_size (C.gtk_pixmap_struct_pixmap (gtk_pixmap), $wid, $hgt)
			Result := hgt
		end

feature -- Element change

	read_from_named_file (file_name: STRING) is
			-- Attempt to load pixmap data from a file specified by `file_name'.
			-- May raise `Ev_unknown_image_format' or `Ev_corrupt_image_data'
			-- exceptions.
			--|FIXME do this!
		local
			temp_string: ANY
		do
			temp_string := file_name.to_c
			c_ev_load_pixmap ($Current, $temp_string, $update_fields)
		end

	set_with_default is
			-- Initialize the pixmap with the default
			-- pixmap (Vision2 logo)
			--
			-- Exceptions "Unable to retrieve icon information"
		do
			c_ev_load_pixmap ($Current, NULL, $update_fields)
		end

	stretch, stretch_image (a_x, a_y: INTEGER) is
			-- Stretch the image to fit in size `a_x' by `a_y'.
		do
				--| FIXME: To be implemented
			check
				to_be_implemented: False
			end
		end

	set_size (a_x, a_y: INTEGER) is
			-- Set the size of the pixmap to `a_x' by `a_y'.
		local
			gdkpix, gdkmask: POINTER
			pixgc, maskgc: POINTER
			loc_default_pointer: POINTER
		do
			gdkpix := C.gdk_pixmap_new (default_gdk_window, a_x, a_y, Default_color_depth)
			pixgc := C.gdk_gc_new (gdkpix)
			C.gdk_gc_set_function (pixgc, C.GDK_COPY_INVERT_ENUM)
			C.gdk_draw_rectangle (gdkpix, pixgc, 1, 0, 0, -1, -1)
			C.gdk_gc_set_function (pixgc, C.GDK_COPY_ENUM)
			
			C.gdk_draw_pixmap (gdkpix, pixgc, drawable, 0, 0, 0, 0, width, height)
			C.gdk_gc_unref (pixgc)

			if mask /= loc_default_pointer then
				gdkmask := C.gdk_pixmap_new (NULL, a_x, a_y, Monochrome_color_depth)
				maskgc := C.gdk_gc_new (gdkmask)
				C.gdk_draw_pixmap (gdkmask, maskgc, mask, 0, 0, 0, 0, width, height)
				C.gdk_gc_unref (maskgc)
			end
			set_pixmap (gdkpix, gdkmask)
		end

	destroy is
		do
			Precursor
			C.gdk_gc_unref (gc)
			gc := NULL
		end
		
	dispose is
			-- 
		do
--			if gc /= NULL then
--				gdk_gc_unref (gc)
--			end
			Precursor
		end
		
	gdk_gc_unref (a_gc: POINTER) is 
			-- void   gdk_gc_unref		  (GdkGC	    *gc);
		external
			"C (GdkGC*) | <gtk/gtk.h>"
		end

feature -- Access

	bitmap_array: ARRAY [CHARACTER] is
			-- Monochromatic representation of `Current' used for cursors.
			-- Representation in bits stored in characters.
		local
			a_gdkimage, a_visual: POINTER
			a_visual_type, a_pixel: INTEGER
			a_color: POINTER
			a_color_map: POINTER
			a_width: INTEGER
			array_offset, array_size: INTEGER
			array_area: SPECIAL [CHARACTER]
			color_struct_size: INTEGER
			local_c: EV_C_EXTERNALS
			character_result, n_character: INTEGER
			red_value: INTEGER
		do
			local_c := C
			array_size := width * height
			if (array_size \\ 8) > 0 then
				array_size := array_size + (8 - (array_size \\ 8))
			end
			check
				array_size_factor_of_8: (array_size \\ 8) = 0
			end
			array_size := array_size // 8
			create Result.make (1, array_size)
			
			a_gdkimage := local_c.gdk_image_get (local_c.gtk_pixmap_struct_pixmap (gtk_pixmap), 0, 0, width, height)
			from
				a_width := width
				a_color_map := local_c.gdk_rgb_get_cmap
				a_visual := local_c.gdk_colormap_get_visual (a_color_map)
				a_visual_type := local_c.gdk_visual_struct_type (a_visual)
				a_color := local_c.c_gdk_color_struct_allocate
				array_area := Result.area
				color_struct_size := local_c.c_gdk_color_struct_size
				array_offset := 0
				n_character := 0
			until
				array_offset = width * height
			loop
				a_pixel := local_c.gdk_image_get_pixel (
					a_gdkimage,
					(array_offset \\ (a_width)), -- Zero based X coord
					((array_offset) // a_width) -- Zero based Y coord
				)
				local_c.c_gdk_colormap_query_color (a_color_map, a_pixel, a_color)
				-- RGB values of a_color are 16 bit.
				if n_character = 8 then
					n_character := 0
					character_result := 0
				end		
				red_value := local_c.gdk_color_struct_red (a_color)
				if red_value > 0  then
					character_result := character_result + (2 ^ (n_character)).rounded
					-- Bitmap data is stored in a way that pixel 1 is bit 1 (2 ^ 0).
					-- This is the way it is read in by the gdk function. (FIFO)
				end
				if array_offset \\ 8 = 7 then
					Result.put (character_result.to_character, (array_offset // 8) + 1)
				end
				n_character := n_character + 1
				array_offset := array_offset + 1
			end
			local_c.c_gdk_color_struct_free (a_color)
			local_c.gdk_image_destroy (a_gdkimage)
		end

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
			local_c: EV_C_EXTERNALS
		do
			local_c := C
			create Result.make_with_alpha_zero (width, height)
			Result.set_originating_pixmap (interface)
			a_gdkimage := local_c.gdk_image_get (local_c.gtk_pixmap_struct_pixmap (gtk_pixmap), 0, 0, width, height)
			from
				a_width := width * 4
				a_color_map := local_c.gdk_rgb_get_cmap
				a_visual := local_c.gdk_colormap_get_visual (a_color_map)
				a_visual_type := local_c.gdk_visual_struct_type (a_visual)
				a_color := local_c.c_gdk_color_struct_allocate
				array_size := a_width * height
				array_area := Result.area
				color_struct_size := local_c.c_gdk_color_struct_size
				temp_alpha_int := 255
				temp_alpha := temp_alpha_int.to_character
			until
				array_offset = array_size
			loop
				a_pixel := local_c.gdk_image_get_pixel (
					a_gdkimage,
					(array_offset \\ (a_width) // 4), -- Zero based X coord
					((array_offset) // a_width) -- Zero based Y coord
				)
				local_c.c_gdk_colormap_query_color (a_color_map, a_pixel, a_color)
				-- RGB values of a_color are 16 bit.
				array_area.put ((local_c.gdk_color_struct_red (a_color) // 256).to_character, array_offset)
				array_area.put ((local_c.gdk_color_struct_green (a_color) // 256).to_character, array_offset + 1)
				array_area.put ((local_c.gdk_color_struct_blue (a_color) // 256).to_character, array_offset + 2)
				array_area.put (temp_alpha, array_offset + 3)
				array_offset := array_offset + 4
			end
			local_c.c_gdk_color_struct_free (a_color)
			local_c.gdk_image_destroy (a_gdkimage)
		end

feature -- Duplication

	copy_pixmap (other: EV_PIXMAP) is
			-- Update `Current' to have same appearence as `other'.
			-- (So as to satisfy `is_equal'.)
		local
			other_imp: EV_PIXMAP_IMP
		do
			other_imp ?= other.implementation
			copy_from_gdk_data (other_imp.drawable, other_imp.mask, other_imp.width, other_imp.height)
		end
		
feature {EV_ANY_I} -- Implementation
		
	copy_from_gdk_data (a_src_pix, a_src_mask: POINTER; a_width, a_height: INTEGER) is
			-- Update `Current' to use passed gdk pixmap data.
		local
			gdkpix, gdkmask: POINTER
			pixgc, maskgc: POINTER
		do
 			gdkpix := C.gdk_pixmap_new (default_gdk_window, a_width, a_height, Default_color_depth)
			pixgc := C.gdk_gc_new (gdkpix)
			C.gdk_draw_pixmap (gdkpix, pixgc, a_src_pix, 0, 0, 0, 0, a_width, a_height)
			C.gdk_gc_unref (pixgc)
			if a_src_mask /= NULL then
				gdkmask := C.gdk_pixmap_new (NULL, a_width, a_height, Monochrome_color_depth)
				maskgc := C.gdk_gc_new (gdkmask)
				C.gdk_draw_pixmap (gdkmask, maskgc, a_src_mask, 0, 0, 0, 0, a_width, a_height)
				C.gdk_gc_unref (maskgc)
			end
			set_pixmap (gdkpix, gdkmask)			
		end

feature {EV_ANY_I} -- Implementation

	drawable: POINTER is
		do
			Result := C.gtk_pixmap_struct_pixmap (gtk_pixmap)
		end

	mask: POINTER is
			-- Pointer to the GdkBitmap used for masking.
		do
			Result := C.gtk_pixmap_struct_mask (gtk_pixmap)
		end

feature {EV_ANY_I} -- Implementation

	gtk_pixmap: POINTER
			-- Pointer to the gtk pixmap widget.

feature {EV_STOCK_PIXMAPS_IMP, EV_PIXMAPABLE_IMP} -- Implementation

	set_pixmap (gdkpix, gdkmask: POINTER) is
			-- Set the GtkPixmap using Gdk pixmap data and mask.
		do
			C.gtk_pixmap_set (gtk_pixmap, gdkpix, gdkmask)
			C.gdk_pixmap_unref (gdkpix)
			if gdkmask /= NULL then
				C.gdk_pixmap_unref (gdkmask)
			end
		end	

	set_from_xpm_data (a_xpm_data: POINTER) is
			-- Pixmap symbolizing a piece of information.
		require
			xpm_data_not_null: a_xpm_data /= NULL
		local
			gdkpix, gdkmask: POINTER
			a_style: POINTER
		do
			a_style := C.gtk_widget_get_style (default_gtk_window)
			gdkpix := C.gdk_pixmap_create_from_xpm_d (default_gdk_window, $gdkmask, NULL, a_xpm_data)
			set_pixmap (gdkpix, gdkmask)
		end

feature {NONE} -- Implementation

	parent_widget: POINTER
			-- Parent widget for Current.

	initialize_graphical_context is
			-- Set the foreground color of the Graphical Context to black.
		local
			allocated: BOOLEAN
			fg: POINTER
		do
			fg := C.c_gdk_color_struct_allocate

				-- Create the color black (default with calloc)
			allocated := C.gdk_colormap_alloc_color (C.gdk_rgb_get_cmap, fg, False, True)
			check
				color_has_been_allocated: allocated = True
			end
			C.gdk_gc_set_foreground (gc, fg)
			C.c_gdk_color_struct_free (fg)
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
			valid_data_type: data_type = Loadpixmap_rgb_data
		local
			gdkpix, gdkmask: POINTER
		do
			if error_code /= Loadpixmap_error_noerror then
				(create {EXCEPTIONS}).raise ("Could not load image file.")
			end
			gdkpix := C.gdk_pixmap_new (default_gdk_window, pixmap_width, pixmap_height, Default_color_depth)
			C.gdk_draw_rgb_image (gdkpix, gc, 0, 0, pixmap_width, pixmap_height, C.Gdk_rgb_dither_normal_enum, rgb_data, pixmap_width * 3)
			if alpha_data /= Default_pointer then
				gdkmask := C.gdk_bitmap_create_from_data (default_gdk_window, alpha_data, pixmap_width, pixmap_height)
			end
			set_pixmap (gdkpix, gdkmask)
		end

feature {NONE} -- Constants

	Default_color_depth: INTEGER is -1
			-- Default color depth, use the one from gdk_root_parent.

	Monochrome_color_depth: INTEGER is 1
			-- Black and White color depth (for mask).

	Loadpixmap_error_noerror: INTEGER is 0
			-- `c_ev_load_pixmap' has reported no error.

	Loadpixmap_rgb_data: INTEGER is 0
			-- `c_ev_load_pixmap' has loaded an RBG bitmap (no mask).
			
	Loadpixmap_alpha_data: INTEGER is 1
			-- `c_ev_load_pixmap' has loaded an RBGA bitmap.

feature -- Externals

	c_ev_load_pixmap(curr_object: POINTER; file_name: POINTER; update_fields_routine: POINTER) is
		external
			"C | %"load_pixmap.h%""
		end

feature {EV_PIXMAP_I, EV_PIXMAPABLE_IMP} -- Implementation

	interface: EV_PIXMAP

end -- EV_PIXMAP_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

