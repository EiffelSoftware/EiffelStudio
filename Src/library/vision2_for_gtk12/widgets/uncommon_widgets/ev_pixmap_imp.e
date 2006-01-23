indexing
	description: "EiffelVision pixmap, GTK implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			gdkpix := {EV_GTK_EXTERNALS}.gdk_pixmap_new (App_implementation.default_gdk_window, 1, 1, Default_color_depth)
				-- Box the pixmap into a container to receive events
			set_c_object ({EV_GTK_EXTERNALS}.gtk_event_box_new)
			gtk_pixmap := {EV_GTK_EXTERNALS}.gtk_pixmap_new (gdkpix, gdkmask)
			{EV_GTK_EXTERNALS}.gdk_pixmap_unref (gdkpix)
			
			{EV_GTK_EXTERNALS}.gtk_container_add (c_object, gtk_pixmap)
			{EV_GTK_EXTERNALS}.gtk_widget_show (gtk_pixmap)

			drawable := {EV_GTK_EXTERNALS}.gtk_pixmap_struct_pixmap (gtk_pixmap)
			
				-- Initialize the Graphical Context
			gc := {EV_GTK_EXTERNALS}.gdk_gc_new (drawable)
			{EV_GTK_EXTERNALS}.gdk_gc_set_function (gc, {EV_GTK_EXTERNALS}.GDK_COPY_ENUM)
			initialize_graphical_context
			init_default_values
		end

	sub_pixmap (area: EV_RECTANGLE): EV_PIXMAP is
			-- Return sub pixmap of `Current' defined by `area'
		local
			pix_imp: EV_PIXMAP_IMP
			a_src, a_mask: POINTER
			maskgc: POINTER
		do
			create Result.make_with_size (area.width, area.height)
			Result.set_background_color ((create {EV_STOCK_COLORS}).white)
			Result.clear
			pix_imp ?= Result.implementation
			Result.draw_sub_pixmap (0, 0, interface, area)
			
			if mask /= default_pointer then
				a_mask := {EV_GTK_EXTERNALS}.gdk_pixmap_new (null, area.width, area.height, monochrome_color_depth)
				maskgc := {EV_GTK_EXTERNALS}.gdk_gc_new (a_mask)
				{EV_GTK_EXTERNALS}.gdk_draw_pixmap (a_mask, maskgc, mask, area.x, area.y, 0, 0, area.width, area.height)
				{EV_GTK_EXTERNALS}.gdk_gc_unref (maskgc)
				a_src := {EV_GTK_EXTERNALS}.gdk_pixmap_ref (pix_imp.drawable)
				pix_imp.set_pixmap (a_src, a_mask)
			end
		end

	draw_full_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; x_src, y_src, src_width, src_height: INTEGER) is
			-- Draw `a_pixmap' on to `Current' using given coordinates and dimensions.
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
				mask_gc := {EV_GTK_EXTERNALS}.gdk_gc_new (mask)
				{EV_GTK_EXTERNALS}.gdk_gc_set_function (mask_gc, {EV_GTK_EXTERNALS}.GDK_INVERT_ENUM)
	 			{EV_GTK_EXTERNALS}.gdk_draw_point (mask, mask_gc, x, y)
	 			{EV_GTK_EXTERNALS}.gdk_gc_unref (mask_gc)
			end
			Precursor {EV_DRAWABLE_IMP} (x, y)
		end

feature -- Drawing operations

	flush is
		do
			if is_displayed then
				{EV_GTK_EXTERNALS}.gtk_widget_queue_draw (gtk_pixmap)
			end
		end

feature -- Measurement

	width: INTEGER is
			-- width of the pixmap.
		local
			wid, hgt: INTEGER
		do
			{EV_GTK_EXTERNALS}.gdk_window_get_size ({EV_GTK_EXTERNALS}.gtk_pixmap_struct_pixmap (gtk_pixmap), $wid, $hgt)
			Result := wid
		end

	height: INTEGER is
			-- height of the pixmap.
		local
			wid, hgt: INTEGER
		do
			{EV_GTK_EXTERNALS}.gdk_window_get_size ({EV_GTK_EXTERNALS}.gtk_pixmap_struct_pixmap (gtk_pixmap), $wid, $hgt)
			Result := hgt
		end

feature -- Element change

	read_from_named_file (file_name: STRING) is
			-- Attempt to load pixmap data from a file specified by `file_name'.
			-- May raise `Ev_unknown_image_format' or `Ev_corrupt_image_data'
			-- exceptions.
			--|FIXME do this!
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := file_name
			c_ev_load_pixmap ($Current, a_cs.item, $update_fields)
		end

	set_with_default is
			-- Initialize the pixmap with the default
			-- pixmap (Vision2 logo)
			--
			-- Exceptions "Unable to retrieve icon information"
		do
			c_ev_load_pixmap ($Current, NULL, $update_fields)
		end

	stretch (a_x, a_y: INTEGER) is
			-- Stretch the image to fit in size `a_x' by `a_y'.
		local
			source_gdkimage, source_mask_gdkimage, destination_mask_gdkimage, destination_gdkimage: POINTER
			gdkpix, gdkmask: POINTER
			pixgc, maskgc: POINTER
			column_counter, row_counter: INTEGER
			mapped_x, mapped_y, source_width, source_height: INTEGER
			mapped_x_lookup, mapped_y_lookup: ARRAY [INTEGER]
		do
				-- Create our pre-calculation arrays
			source_width := width
			source_height := height

			from
				create mapped_x_lookup.make (0, a_x - 1)
				column_counter := 0
			until
				column_counter = a_x
			loop
				mapped_x := ((column_counter / a_x) * source_width).truncated_to_integer
				mapped_x_lookup.put (mapped_x, column_counter)
				column_counter := column_counter + 1
			end		
			
			from
				create mapped_y_lookup.make (0, a_y)
				row_counter := 0
			until
				row_counter = a_y
			loop
				mapped_y := ((row_counter / a_y ) * source_height).truncated_to_integer
				mapped_y_lookup.put (mapped_y, row_counter)
				row_counter := row_counter + 1
			end
			
				-- Create our new stretched pixmap canvas.
			gdkpix := {EV_GTK_EXTERNALS}.gdk_pixmap_new (App_implementation.default_gdk_window, a_x, a_y, Default_color_depth)
			pixgc := {EV_GTK_EXTERNALS}.gdk_gc_new (gdkpix)
			
			
				-- Retrieve our existing image information
			source_gdkimage := {EV_GTK_EXTERNALS}.gdk_image_get (drawable, 0, 0, width, height)
			destination_gdkimage := {EV_GTK_EXTERNALS}.gdk_image_get (gdkpix, 0, 0, a_x, a_y)
			if mask /= NULL then
				gdkmask := {EV_GTK_EXTERNALS}.gdk_pixmap_new (NULL, a_x, a_y, 1)
				source_mask_gdkimage := {EV_GTK_EXTERNALS}.gdk_image_get (mask, 0, 0, width, height)
				destination_mask_gdkimage := {EV_GTK_EXTERNALS}.gdk_image_get (gdkmask, 0, 0, a_x, a_y)
				maskgc := {EV_GTK_EXTERNALS}.gdk_gc_new (gdkmask)
			end
		
			from
					-- We are using zero-based arrays to match gdkimage lookup and thus gain performance
				row_counter := 0
			until
				row_counter = a_y
			loop
				from
					column_counter := 0
				until
					column_counter = a_x
				loop
						-- Map destination pixels to source pixels
					{EV_GTK_EXTERNALS}.gdk_image_put_pixel (
						destination_gdkimage,
						column_counter,
						row_counter,
						{EV_GTK_EXTERNALS}.gdk_image_get_pixel (source_gdkimage, mapped_x_lookup @ column_counter, mapped_y_lookup @ row_counter)
					)
						-- Map mask destination to mask source.
					if gdkmask /= NULL then
						{EV_GTK_EXTERNALS}.gdk_image_put_pixel (
							destination_mask_gdkimage,
							column_counter,
							row_counter,
							{EV_GTK_EXTERNALS}.gdk_image_get_pixel (source_mask_gdkimage, mapped_x_lookup @ column_counter, mapped_y_lookup @ row_counter)
						)
					end
					column_counter := column_counter + 1
				end
				row_counter := row_counter + 1
			end
			
				-- Copy image over to our new pixmap and cleanup
			{EV_GTK_EXTERNALS}.gdk_draw_image (gdkpix, pixgc, destination_gdkimage, 0, 0, 0, 0, a_x, a_y)
			if gdkmask /= NULL then
				{EV_GTK_EXTERNALS}.gdk_draw_image (gdkmask, maskgc, destination_mask_gdkimage, 0, 0, 0, 0, a_x, a_y)
			end
			
			set_pixmap (gdkpix, gdkmask)
			
			{EV_GTK_EXTERNALS}.gdk_gc_unref (pixgc)
			{EV_GTK_EXTERNALS}.gdk_image_destroy (source_gdkimage)
			{EV_GTK_EXTERNALS}.gdk_image_destroy (destination_gdkimage)
			
			if gdkmask /= NULL then
				{EV_GTK_EXTERNALS}.gdk_image_destroy (source_mask_gdkimage)
				{EV_GTK_EXTERNALS}.gdk_image_destroy (destination_mask_gdkimage)
				{EV_GTK_EXTERNALS}.gdk_gc_unref (maskgc)
			end
		end

	set_size (a_x, a_y: INTEGER) is
			-- Set the size of the pixmap to `a_x' by `a_y'.
		local
			gdkpix, gdkmask: POINTER
			pixgc, maskgc: POINTER
			loc_default_pointer: POINTER
		do
			gdkpix := {EV_GTK_EXTERNALS}.gdk_pixmap_new (App_implementation.default_gdk_window, a_x, a_y, Default_color_depth)
			pixgc := {EV_GTK_EXTERNALS}.gdk_gc_new (gdkpix)
			{EV_GTK_EXTERNALS}.gdk_gc_set_function (pixgc, {EV_GTK_EXTERNALS}.GDK_COPY_INVERT_ENUM)
			{EV_GTK_EXTERNALS}.gdk_draw_rectangle (gdkpix, pixgc, 1, 0, 0, -1, -1)
			{EV_GTK_EXTERNALS}.gdk_gc_set_function (pixgc, {EV_GTK_EXTERNALS}.GDK_COPY_ENUM)
			
			{EV_GTK_EXTERNALS}.gdk_draw_pixmap (gdkpix, pixgc, drawable, 0, 0, 0, 0, width, height)
			{EV_GTK_EXTERNALS}.gdk_gc_unref (pixgc)

			if mask /= loc_default_pointer then
				gdkmask := {EV_GTK_EXTERNALS}.gdk_pixmap_new (NULL, a_x, a_y, Monochrome_color_depth)
				maskgc := {EV_GTK_EXTERNALS}.gdk_gc_new (gdkmask)
				{EV_GTK_EXTERNALS}.gdk_draw_pixmap (gdkmask, maskgc, mask, 0, 0, 0, 0, width, height)
				{EV_GTK_EXTERNALS}.gdk_gc_unref (maskgc)
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
			
			a_gdkimage := {EV_GTK_EXTERNALS}.gdk_image_get ({EV_GTK_EXTERNALS}.gtk_pixmap_struct_pixmap (gtk_pixmap), 0, 0, width, height)
			from
				a_width := width
				a_color_map := {EV_GTK_EXTERNALS}.gdk_rgb_get_cmap
				a_visual := {EV_GTK_EXTERNALS}.gdk_colormap_get_visual (a_color_map)
				a_visual_type := {EV_GTK_EXTERNALS}.gdk_visual_struct_type (a_visual)
				a_color := {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
				array_area := Result.area
				color_struct_size := {EV_GTK_EXTERNALS}.c_gdk_color_struct_size
				array_offset := 0
				n_character := 0
			until
				array_offset = width * height
			loop
				a_pixel := {EV_GTK_EXTERNALS}.gdk_image_get_pixel (
					a_gdkimage,
					(array_offset \\ (a_width)), -- Zero based X coord
					((array_offset) // a_width) -- Zero based Y coord
				)
				{EV_GTK_DEPENDENT_EXTERNALS}.c_gdk_colormap_query_color (a_color_map, a_pixel, a_color)
				-- RGB values of a_color are 16 bit.
				if n_character = 8 then
					n_character := 0
					character_result := 0
				end		
				if 
					{EV_GTK_EXTERNALS}.gdk_color_struct_red (a_color) > 0
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
			{EV_GTK_EXTERNALS}.gdk_image_destroy (a_gdkimage)
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
			a_gdkimage := {EV_GTK_EXTERNALS}.gdk_image_get ({EV_GTK_EXTERNALS}.gtk_pixmap_struct_pixmap (gtk_pixmap), 0, 0, width, height)
			from
				a_width := width * 4
				a_color_map := {EV_GTK_EXTERNALS}.gdk_rgb_get_cmap
				a_visual := {EV_GTK_EXTERNALS}.gdk_colormap_get_visual (a_color_map)
				a_visual_type := {EV_GTK_EXTERNALS}.gdk_visual_struct_type (a_visual)
				a_color := {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
				array_size := a_width * height
				array_area := Result.area
				color_struct_size := {EV_GTK_EXTERNALS}.c_gdk_color_struct_size
				temp_alpha_int := 255
				temp_alpha := temp_alpha_int.to_character
			until
				array_offset = array_size
			loop
				a_pixel := {EV_GTK_EXTERNALS}.gdk_image_get_pixel (
					a_gdkimage,
					(array_offset \\ (a_width) // 4), -- Zero based X coord
					((array_offset) // a_width) -- Zero based Y coord
				)
				{EV_GTK_DEPENDENT_EXTERNALS}.c_gdk_colormap_query_color (a_color_map, a_pixel, a_color)
				-- RGB values of a_color are 16 bit.
				array_area.put (({EV_GTK_EXTERNALS}.gdk_color_struct_red (a_color) // 256).to_character, array_offset)
				array_area.put (({EV_GTK_EXTERNALS}.gdk_color_struct_green (a_color) // 256).to_character, array_offset + 1)
				array_area.put (({EV_GTK_EXTERNALS}.gdk_color_struct_blue (a_color) // 256).to_character, array_offset + 2)
				array_area.put (temp_alpha, array_offset + 3)
				array_offset := array_offset + 4
			end
			a_color.memory_free
			{EV_GTK_EXTERNALS}.gdk_image_destroy (a_gdkimage)
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
 			gdkpix := {EV_GTK_EXTERNALS}.gdk_pixmap_new (App_implementation.default_gdk_window, a_width, a_height, Default_color_depth)
			pixgc := {EV_GTK_EXTERNALS}.gdk_gc_new (gdkpix)
			{EV_GTK_EXTERNALS}.gdk_draw_pixmap (gdkpix, pixgc, a_src_pix, 0, 0, 0, 0, a_width, a_height)
			{EV_GTK_EXTERNALS}.gdk_gc_unref (pixgc)
			if a_src_mask /= NULL then
				gdkmask := {EV_GTK_EXTERNALS}.gdk_pixmap_new (NULL, a_width, a_height, Monochrome_color_depth)
				maskgc := {EV_GTK_EXTERNALS}.gdk_gc_new (gdkmask)
				{EV_GTK_EXTERNALS}.gdk_draw_pixmap (gdkmask, maskgc, a_src_mask, 0, 0, 0, 0, a_width, a_height)
				{EV_GTK_EXTERNALS}.gdk_gc_unref (maskgc)
			end
			set_pixmap (gdkpix, gdkmask)			
		end

feature {EV_ANY_I, EV_GTK_DEPENDENT_APPLICATION_IMP} -- Implementation

	drawable: POINTER
		-- Pointer to the GdkPixmap structure

	mask: POINTER
		-- Pointer to the GdkBitmap masking structure

feature {EV_ANY_I} -- Implementation

	gtk_pixmap: POINTER
			-- Pointer to the gtk pixmap widget.

feature {EV_STOCK_PIXMAPS_IMP, EV_PIXMAPABLE_IMP, EV_NOTEBOOK_IMP, EV_PIXMAP_IMP} -- Implementation

	set_pixmap (gdkpix, gdkmask: POINTER) is
			-- Set the GtkPixmap using Gdk pixmap data and mask.
		do
			{EV_GTK_EXTERNALS}.gtk_pixmap_set (gtk_pixmap, gdkpix, gdkmask)
			{EV_GTK_EXTERNALS}.gdk_pixmap_unref (gdkpix)
			drawable := gdkpix
			mask := gdkmask
			if gdkmask /= NULL then
				{EV_GTK_EXTERNALS}.gdk_pixmap_unref (gdkmask)
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
			a_style := {EV_GTK_EXTERNALS}.gtk_widget_get_style (App_implementation.default_gtk_window)
			gdkpix := {EV_GTK_EXTERNALS}.gdk_pixmap_create_from_xpm_d (App_implementation.default_gdk_window, $gdkmask, NULL, a_xpm_data)
			set_pixmap (gdkpix, gdkmask)
		end

	save_to_named_file (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME) is
			-- Save `Current' to `a_filename' in `a_format' format.
		local
			png_format: EV_PNG_FORMAT
			a_fn, char_array: ANY
			a_width, a_height: INTEGER
		do
			png_format ?= a_format
			if png_format /= Void then
				a_fn := a_filename.to_c
				char_array := raw_image_data.to_c
				if png_format.scale_height /= 0 then
					a_height := png_format.scale_height
				else
					a_height := raw_image_data.height
				end
	
				if png_format.scale_width /= 0 then
					a_width := png_format.scale_width
				else
					a_width := raw_image_data.width
				end
				c_ev_save_png ($char_array, $a_fn, raw_image_data.width, raw_image_data.height, a_width, a_height, png_format.color_mode)
			end
							
			a_format.save (raw_image_data, a_filename)
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
			fg := {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate

				-- Create the color black (default with calloc)
			allocated := {EV_GTK_EXTERNALS}.gdk_colormap_alloc_color ({EV_GTK_EXTERNALS}.gdk_rgb_get_cmap, fg, False, True)
			check
				color_has_been_allocated: allocated = True
			end
			{EV_GTK_EXTERNALS}.gdk_gc_set_foreground (gc, fg)
			fg.memory_free
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
			gdkpix := {EV_GTK_EXTERNALS}.gdk_pixmap_new (App_implementation.default_gdk_window, pixmap_width, pixmap_height, Default_color_depth)
			{EV_GTK_EXTERNALS}.gdk_draw_rgb_image (gdkpix, gc, 0, 0, pixmap_width, pixmap_height, {EV_GTK_EXTERNALS}.Gdk_rgb_dither_normal_enum, rgb_data, pixmap_width * 3)
			if alpha_data /= Default_pointer then
				gdkmask := {EV_GTK_EXTERNALS}.gdk_bitmap_create_from_data (App_implementation.default_gdk_window, alpha_data, pixmap_width, pixmap_height)
			end
			set_pixmap (gdkpix, gdkmask)
		end
		
	destroy is
			-- Destroy the pixmap and resources.
		do
			Precursor {EV_PRIMITIVE_IMP}
			if gc /= NULL then
				{EV_GTK_EXTERNALS}.gdk_gc_unref (gc)
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

	c_ev_save_png (char_array, path: POINTER;
			array_width,
			array_height,
			a_scale_width,
			a_scale_height,
			a_colormode: INTEGER) is
		external
			"C signature (char *, char *, int, int, int, int, int) use %"load_pixmap.h%""
		end

feature {EV_PIXMAP_I, EV_PIXMAPABLE_IMP} -- Implementation

	interface: EV_PIXMAP;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- EV_PIXMAP_IMP

