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
			flush,
			save_to_named_file
		end

	EV_DRAWABLE_IMP
		redefine
			interface,
			make,
			width,
			height,
			destroy,
			drawable,
			draw_full_pixmap,
			draw_point
		end

	EV_PRIMITIVE_IMP
		undefine
			foreground_color,
			background_color,
			set_foreground_color,
			set_background_color,
			needs_event_box
		redefine
			interface,
			width,
			height,
			destroy,
			dispose
		end

	EV_PIXMAP_ACTION_SEQUENCES_IMP
		redefine
			needs_event_box,
			interface,
			destroy
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is True

	make (an_interface: like interface) is
			-- Create a gtk pixmap of size (1 * 1) with no mask.
		local
			gdkpix, gdkmask: POINTER
		do
			base_make (an_interface)
			gdkpix := feature {EV_GTK_EXTERNALS}.gdk_pixmap_new (App_implementation.default_gdk_window, 1, 1, Default_color_depth)
			gtk_image := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_image_new
			set_c_object (gtk_image)
			set_pixmap (gdkpix, gdkmask)

				-- Initialize the Graphical Context
			gc := feature {EV_GTK_EXTERNALS}.gdk_gc_new (gdkpix)
			feature {EV_GTK_EXTERNALS}.gdk_gc_set_function (gc, feature {EV_GTK_EXTERNALS}.GDK_COPY_ENUM)
			initialize_graphical_context
			init_default_values
		end
		
	draw_full_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; x_src, y_src, src_width, src_height: INTEGER) is
			-- 
		do
			Precursor {EV_DRAWABLE_IMP} (x, y, a_pixmap, x_src, y_src, src_width, src_height)
			flush	
		end
		
	draw_point (x, y: INTEGER) is
			-- Draw point at (`x', `y').
		local
			mask_gc: POINTER
		do
			if mask /= NULL then
				mask_gc := feature {EV_GTK_EXTERNALS}.gdk_gc_new (mask)
				feature {EV_GTK_EXTERNALS}.gdk_gc_set_function (mask_gc, feature {EV_GTK_EXTERNALS}.GDK_INVERT_ENUM)
	 			feature {EV_GTK_EXTERNALS}.gdk_draw_point (mask, mask_gc, x, y)
	 			feature {EV_GTK_EXTERNALS}.gdk_gc_unref (mask_gc)
			end
			Precursor {EV_DRAWABLE_IMP} (x, y)
		end

feature -- Drawing operations

	flush is
		do
			if is_displayed then
				feature {EV_GTK_EXTERNALS}.gtk_widget_queue_draw (gtk_image)
			end
		end

feature -- Measurement

	width: INTEGER is
			-- width of the pixmap.
		local
			wid, hgt: INTEGER
		do
			feature {EV_GTK_EXTERNALS}.gdk_window_get_size (drawable, $wid, $hgt)
			Result := wid
		end

	height: INTEGER is
			-- height of the pixmap.
		local
			wid, hgt: INTEGER
		do
			feature {EV_GTK_EXTERNALS}.gdk_window_get_size (drawable, $wid, $hgt)
			Result := hgt
		end

feature -- Element change

	read_from_named_file (file_name: STRING) is
			-- Attempt to load pixmap data from a file specified by `file_name'.
		local
			a_cs: EV_GTK_C_STRING
			g_error: POINTER
			pixbuf: POINTER
		do
			create a_cs.make (file_name)
			pixbuf := feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_new_from_file (a_cs.item, $g_error)
			if g_error /= default_pointer then
				-- We could not load the image so raise an exception
				(create {EXCEPTIONS}).raise ("Could not load image file.")
			else
				set_pixmap_from_pixbuf (pixbuf)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.object_unref (pixbuf)
			end
		end

	set_with_default is
			-- Initialize the pixmap with the default
			-- pixmap (Vision2 logo)
		do
			set_from_xpm_data (default_pixmap_xpm)
		end

	stretch (a_x, a_y: INTEGER) is
			-- Stretch the image to fit in size `a_x' by `a_y'.
		local
			a_gdkpix, a_gdkmask, a_gdkpixbuf: POINTER
		do
			a_gdkpixbuf := pixbuf_from_drawable
			a_gdkpixbuf := feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_scale_simple (a_gdkpixbuf, a_x, a_y, feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_interp_bilinear)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_render_pixmap_and_mask (a_gdkpixbuf, $a_gdkpix, $a_gdkmask, 255)
			set_pixmap (a_gdkpix, a_gdkmask)
			feature {EV_GTK_EXTERNALS}.object_unref (a_gdkpixbuf)
		end

	pixbuf_from_drawable: POINTER is
			-- Return a GdkPixbuf object from the current Gdkpixbuf structure
		local
			a_pix, mask_pixbuf1, mask_pixbuf2: POINTER
		do
			a_pix := feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_get_from_drawable (Result, drawable, default_pointer, 0, 0, 0, 0, -1, -1)
			if mask /= default_pointer then
				mask_pixbuf1 := feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_get_from_drawable (default_pointer, mask, default_pointer, 0, 0, 0, 0, -1, -1)
				mask_pixbuf2 := feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_add_alpha (mask_pixbuf1, True, '%/255/', '%/255/', '%/255/')
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_composite (mask_pixbuf2, a_pix, 0, 0, width, height, 0, 0, 1, 1, feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_interp_bilinear, 254)
				Result := feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_add_alpha (a_pix, False, '%/0/', '%/0/', '%/0/')
				feature {EV_GTK_DEPENDENT_EXTERNALS}.object_unref (a_pix)
				draw_mask_on_pixbuf (Result, mask_pixbuf2)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.object_unref (mask_pixbuf1)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.object_unref (mask_pixbuf2)
			else
				Result := a_pix
			end
		end

	draw_mask_on_pixbuf (a_pixbuf_ptr, a_mask_ptr: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				int x, y;
				
				GdkPixbuf *pixbuf, *mask;
				
				pixbuf = (GdkPixbuf*) $a_pixbuf_ptr;
				mask = (GdkPixbuf*) $a_mask_ptr; 
				
				for (y = 0; y < gdk_pixbuf_get_height (pixbuf); y++)
				{
					guchar *src, *dest;
					
					src = gdk_pixbuf_get_pixels (mask) + y * gdk_pixbuf_get_rowstride (mask);
					dest = gdk_pixbuf_get_pixels (pixbuf) + y * gdk_pixbuf_get_rowstride (pixbuf);
					
					for (x = 0; x < gdk_pixbuf_get_width (pixbuf); x++)
					{
						if (src [0] == 0)
							dest [3] = 0;
						
						src += 4;
						dest += 4;				
					}
					
				}
			]"
		end
		

	pixbuf_from_drawable_with_size (a_width, a_height: INTEGER): POINTER is
			-- Return a GdkPixbuf object from the current Gdkpixbuf structure with dimensions `a_width' * `a_height'
		do
			Result := feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_scale_simple (pixbuf_from_drawable, a_width, a_height, feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_interp_bilinear)
		end

	set_size (a_x, a_y: INTEGER) is
			-- Set the size of the pixmap to `a_x' by `a_y'.
		local
			gdkpix, gdkmask: POINTER
			pixgc, maskgc: POINTER
			loc_default_pointer: POINTER
		do
			gdkpix := feature {EV_GTK_EXTERNALS}.gdk_pixmap_new (App_implementation.default_gdk_window, a_x, a_y, Default_color_depth)
			pixgc := feature {EV_GTK_EXTERNALS}.gdk_gc_new (gdkpix)
			feature {EV_GTK_EXTERNALS}.gdk_gc_set_function (pixgc, feature {EV_GTK_EXTERNALS}.GDK_COPY_INVERT_ENUM)
			feature {EV_GTK_EXTERNALS}.gdk_draw_rectangle (gdkpix, pixgc, 1, 0, 0, -1, -1)
			feature {EV_GTK_EXTERNALS}.gdk_gc_set_function (pixgc, feature {EV_GTK_EXTERNALS}.GDK_COPY_ENUM)
			
			feature {EV_GTK_EXTERNALS}.gdk_draw_pixmap (gdkpix, pixgc, drawable, 0, 0, 0, 0, width, height)
			feature {EV_GTK_EXTERNALS}.gdk_gc_unref (pixgc)

			if mask /= loc_default_pointer then
				gdkmask := feature {EV_GTK_EXTERNALS}.gdk_pixmap_new (NULL, a_x, a_y, Monochrome_color_depth)
				maskgc := feature {EV_GTK_EXTERNALS}.gdk_gc_new (gdkmask)
				feature {EV_GTK_EXTERNALS}.gdk_draw_pixmap (gdkmask, maskgc, mask, 0, 0, 0, 0, width, height)
				feature {EV_GTK_EXTERNALS}.gdk_gc_unref (maskgc)
			end
			set_pixmap (gdkpix, gdkmask)
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
			character_result, n_character: INTEGER
		do
			array_size := width * height
			if (array_size \\ 8) > 0 then
				array_size := array_size + (8 - (array_size \\ 8))
			end
			check
				array_size_factor_of_8: (array_size \\ 8) = 0
			end
			array_size := array_size // 8
			create Result.make (1, array_size)
			
			a_gdkimage := feature {EV_GTK_EXTERNALS}.gdk_image_get (drawable, 0, 0, width, height)
			
			from
				a_width := width
				a_color_map := feature {EV_GTK_EXTERNALS}.gdk_rgb_get_cmap
				a_visual := feature {EV_GTK_EXTERNALS}.gdk_colormap_get_visual (a_color_map)
				a_visual_type := feature {EV_GTK_EXTERNALS}.gdk_visual_struct_type (a_visual)
				a_color := feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
				array_area := Result.area
				color_struct_size := feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_size
				array_offset := 0
				n_character := 0
			until
				array_offset = width * height
			loop
				a_pixel := feature {EV_GTK_EXTERNALS}.gdk_image_get_pixel (
					a_gdkimage,
					(array_offset \\ (a_width)), -- Zero based X coord
					((array_offset) // a_width) -- Zero based Y coord
				)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_colormap_query_color (a_color_map, a_pixel, a_color)
				-- RGB values of a_color are 16 bit.
				if n_character = 8 then
					n_character := 0
					character_result := 0
				end		
				if 
					feature {EV_GTK_EXTERNALS}.gdk_color_struct_red (a_color) > 0
					--or else local_feature {EV_GTK_EXTERNALS}.gdk_color_struct_green (a_color) > 0
					--or else local_feature {EV_GTK_EXTERNALS}.gdk_color_struct_blue (a_color) > 0
				then
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
			a_color.memory_free
			feature {EV_GTK_EXTERNALS}.gdk_image_destroy (a_gdkimage)
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
		do
			create Result.make_with_alpha_zero (width, height)
			Result.set_originating_pixmap (interface)
			a_gdkimage := feature {EV_GTK_EXTERNALS}.gdk_image_get (drawable, 0, 0, width, height)
		
			from
				a_width := width * 4
				a_color_map := feature {EV_GTK_EXTERNALS}.gdk_rgb_get_cmap
				a_visual := feature {EV_GTK_EXTERNALS}.gdk_colormap_get_visual (a_color_map)
				a_visual_type := feature {EV_GTK_EXTERNALS}.gdk_visual_struct_type (a_visual)
				a_color := feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
				array_size := a_width * height
				array_area := Result.area
				color_struct_size := feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_size
				temp_alpha_int := 255
				temp_alpha := temp_alpha_int.to_character
			until
				array_offset = array_size
			loop
				a_pixel := feature {EV_GTK_EXTERNALS}.gdk_image_get_pixel (
					a_gdkimage,
					(array_offset \\ (a_width) // 4), -- Zero based X coord
					((array_offset) // a_width) -- Zero based Y coord
				)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_colormap_query_color (a_color_map, a_pixel, a_color)
				-- RGB values of a_color are 16 bit.
				array_area.put ((feature {EV_GTK_EXTERNALS}.gdk_color_struct_red (a_color) // 256).to_character, array_offset)
				array_area.put ((feature {EV_GTK_EXTERNALS}.gdk_color_struct_green (a_color) // 256).to_character, array_offset + 1)
				array_area.put ((feature {EV_GTK_EXTERNALS}.gdk_color_struct_blue (a_color) // 256).to_character, array_offset + 2)
				array_area.put (temp_alpha, array_offset + 3)
				array_offset := array_offset + 4
			end
			a_color.memory_free
			feature {EV_GTK_EXTERNALS}.gdk_image_destroy (a_gdkimage)
		end

feature -- Duplication

	copy_pixmap (other: EV_PIXMAP) is
			-- Update `Current' to have same appearance as `other'.
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
 			gdkpix := feature {EV_GTK_EXTERNALS}.gdk_pixmap_new (App_implementation.default_gdk_window, a_width, a_height, Default_color_depth)
			pixgc := feature {EV_GTK_EXTERNALS}.gdk_gc_new (gdkpix)
			feature {EV_GTK_EXTERNALS}.gdk_draw_pixmap (gdkpix, pixgc, a_src_pix, 0, 0, 0, 0, a_width, a_height)
			feature {EV_GTK_EXTERNALS}.gdk_gc_unref (pixgc)
			if a_src_mask /= NULL then
				gdkmask := feature {EV_GTK_EXTERNALS}.gdk_pixmap_new (NULL, a_width, a_height, Monochrome_color_depth)
				maskgc := feature {EV_GTK_EXTERNALS}.gdk_gc_new (gdkmask)
				feature {EV_GTK_EXTERNALS}.gdk_draw_pixmap (gdkmask, maskgc, a_src_mask, 0, 0, 0, 0, a_width, a_height)
				feature {EV_GTK_EXTERNALS}.gdk_gc_unref (maskgc)
			end
			set_pixmap (gdkpix, gdkmask)			
		end

feature {EV_ANY_I} -- Implementation

	drawable: POINTER
			-- Pointer to the GdkPixmap image data.

	mask: POINTER
			-- Pointer to the GdkBitmap used for masking.

feature {EV_ANY_I} -- Implementation

	gtk_image: POINTER
			-- Pointer to the gtk pixmap widget.

feature {EV_STOCK_PIXMAPS_IMP, EV_PIXMAPABLE_IMP} -- Implementation

	set_pixmap (gdkpix, gdkmask: POINTER) is
			-- Set the GtkPixmap using Gdk pixmap data and mask.
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_image_set_from_pixmap (gtk_image, gdkpix, gdkmask)
			feature {EV_GTK_EXTERNALS}.gdk_pixmap_unref (gdkpix)
			drawable := gdkpix
			mask := gdkmask
			if gdkmask /= NULL then
				feature {EV_GTK_EXTERNALS}.gdk_pixmap_unref (gdkmask)
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
			a_style := feature {EV_GTK_EXTERNALS}.gtk_widget_get_style (App_implementation.default_gtk_window)
			gdkpix := feature {EV_GTK_EXTERNALS}.gdk_pixmap_create_from_xpm_d (App_implementation.default_gdk_window, $gdkmask, NULL, a_xpm_data)	
			set_pixmap (gdkpix, gdkmask)
		end

	set_from_stock_id (a_stock_id: POINTER) is
			-- Pixmap symbolizing a piece of information
		require
			a_stock_id_not_null: a_stock_id /= NULL
		local
			stock_pixbuf, scaled_pixbuf: POINTER
		do
			stock_pixbuf := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_render_icon (gtk_image, a_stock_id, gtk_icon_size_dialog, NULL)
			scaled_pixbuf := feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_scale_simple (stock_pixbuf, 48, 48, feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_interp_hyper)		
			set_pixmap_from_pixbuf (scaled_pixbuf)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.object_unref (stock_pixbuf)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.object_unref (scaled_pixbuf)
		end

	gtk_icon_size_dialog: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_ICON_SIZE_DIALOG"
		end		

feature {NONE} -- Implementation

	set_pixmap_from_pixbuf (a_pixbuf: POINTER) is
			-- 
		local
			a_gdkpix, a_gdkmask: POINTER
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_render_pixmap_and_mask (a_pixbuf, $a_gdkpix, $a_gdkmask, 255)
			set_pixmap (a_gdkpix, a_gdkmask)			
		end

	save_to_named_file (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME) is
			-- 
		local
			a_gdkpixbuf: POINTER
			a_gerror: POINTER
			a_handle, a_filetype: EV_GTK_C_STRING
		do			
			if app_implementation.writeable_pixbuf_formats.has (a_format.file_extension.as_upper) then
				-- Perform custom saving with GdkPixbuf
				a_gdkpixbuf := pixbuf_from_drawable
				create a_handle.make (a_filename)
				create a_filetype.make (a_format.file_extension)
				if a_format.scale_width > 0 and then a_format.scale_height > 0 then
					a_gdkpixbuf := feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_scale_simple (a_gdkpixbuf, a_format.scale_width, a_format.scale_height, feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_interp_bilinear)
				end
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_save (a_gdkpixbuf, a_handle.item, a_filetype.item, $a_gerror)
				if a_gerror /= default_pointer then
					-- We could not save the image so raise an exception
					(create {EXCEPTIONS}).raise ("Could not save image file.")
				end
				feature {EV_GTK_EXTERNALS}.object_unref (a_gdkpixbuf)
			else
				-- If Gtk cannot save the file then the default is called
				Precursor {EV_PIXMAP_I} (a_format, a_filename)
			end
		end

	parent_widget: POINTER
			-- Parent widget for Current.

	initialize_graphical_context is
			-- Set the foreground color of the Graphical Context to black.
		local
			allocated: BOOLEAN
			fg: POINTER
		do
			fg := feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate

				-- Create the color black (default with calloc)
			allocated := feature {EV_GTK_EXTERNALS}.gdk_colormap_alloc_color (feature {EV_GTK_EXTERNALS}.gdk_rgb_get_cmap, fg, False, True)
			check
				color_has_been_allocated: allocated = True
			end
			feature {EV_GTK_EXTERNALS}.gdk_gc_set_foreground (gc, fg)
			fg.memory_free
		end

	destroy is
			-- Destroy the pixmap and resources.
		do
			Precursor {EV_PRIMITIVE_IMP}
			if gc /= NULL then
				feature {EV_GTK_EXTERNALS}.gdk_gc_unref (gc)
				gc := NULL	
			end
		end
		
	dispose is
			-- Clear up resources if needed in object disposal.
		do
			if gc /= NULL then
				gdk_gc_unref (gc)
				gc := NULL
			end
			Precursor {EV_PRIMITIVE_IMP}
		end

feature {NONE} -- Externals

	default_pixmap_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"default_pixmap_xpm"
		end

feature {NONE} -- Constants

	Default_color_depth: INTEGER is -1
			-- Default color depth, use the one from gdk_root_parent.

	Monochrome_color_depth: INTEGER is 1
			-- Black and White color depth (for mask).

feature {EV_ANY_I} -- Implementation

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

