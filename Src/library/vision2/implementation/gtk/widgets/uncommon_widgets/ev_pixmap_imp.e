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

