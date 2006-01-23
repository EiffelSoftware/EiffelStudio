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
			dispose,
			initialize
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
		-- Needed to receive events on GtkImage

	make (an_interface: like interface) is
			-- Create a gtk pixmap of size (1 * 1) with no mask.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_image_new)
		end

	initialize is
			-- Initialize `Current'
		local
			gdkpix, gdkmask: POINTER
			l_app_imp: like app_implementation
		do
			Precursor {EV_PRIMITIVE_IMP}
			l_app_imp := app_implementation
			gdkpix := {EV_GTK_EXTERNALS}.gdk_pixmap_new (l_app_imp.default_gdk_window, 1, 1, Default_color_depth)

			set_pixmap (gdkpix, gdkmask)
				-- Initialize the Graphical Context
			gc := {EV_GTK_EXTERNALS}.gdk_gc_new (gdkpix)
			{EV_GTK_EXTERNALS}.gdk_gc_set_foreground (gc, l_app_imp.fg_color)
			init_default_values			
		end

feature -- Drawing operations
		
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

	redraw is
			-- Force `Current' to redraw itself.
		do
			update_if_needed
		end

	flush is
			-- Ensure that the appearance of `Current' is updated on screen
			-- immediately. Any changes that have not yet been reflected will
			-- become visible.
		do
			refresh_now
		end

	update_if_needed is
			-- Update `Current' if needed.
		do
			if is_displayed then
				{EV_GTK_EXTERNALS}.gtk_widget_queue_draw (visual_widget)
			end
		end

feature -- Measurement

	width: INTEGER is
			-- Width of the pixmap in pixels.
		local
			a_y: INTEGER
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gdk_drawable_get_size (drawable, $Result, $a_y)
		end

	height: INTEGER is
			-- height of the pixmap.
		local
			a_x: INTEGER
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gdk_drawable_get_size (drawable, $a_x, $Result)
		end

feature -- Element change

	read_from_named_file (file_name: STRING) is
			-- Attempt to load pixmap data from a file specified by `file_name'.
		local
			a_cs: EV_GTK_C_STRING
			g_error: POINTER
			filepixbuf: POINTER
		do
			a_cs := file_name
			filepixbuf := {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_new_from_file (a_cs.item, $g_error)
			if g_error /= default_pointer then
				-- We could not load the image so raise an exception
				(create {EXCEPTIONS}).raise ("Could not load image file.")
			else
				set_pixmap_from_pixbuf (filepixbuf)
			end
			{EV_GTK_EXTERNALS}.object_unref (filepixbuf)
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
			a_gdkpix, a_gdkmask, a_gdkpixbuf, scaled_pixbuf: POINTER
			a_scale_type: INTEGER
		do
			a_gdkpixbuf := pixbuf_from_drawable
			
			if width <= 16 and then height <= 16 then
					-- For small images this method scales better
				a_scale_type := {EV_GTK_DEPENDENT_EXTERNALS}.gdk_interp_nearest
			else
					-- For larger images this mode provides better scaling
				a_scale_type := {EV_GTK_DEPENDENT_EXTERNALS}.gdk_interp_bilinear
			end
			scaled_pixbuf := {EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_scale_simple (a_gdkpixbuf, a_x, a_y, a_scale_type)
			{EV_GTK_EXTERNALS}.object_unref (a_gdkpixbuf)
			a_gdkpixbuf := scaled_pixbuf

			{EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_render_pixmap_and_mask (a_gdkpixbuf, $a_gdkpix, $a_gdkmask, 255)
			set_pixmap (a_gdkpix, a_gdkmask)
			{EV_GTK_EXTERNALS}.object_unref (a_gdkpixbuf)
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
			
			a_gdkimage := {EV_GTK_EXTERNALS}.gdk_image_get (drawable, 0, 0, width, height)
			
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
				{EV_GTK_DEPENDENT_EXTERNALS}.gdk_colormap_query_color (a_color_map, a_pixel, a_color)
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
			a_gdkimage := {EV_GTK_EXTERNALS}.gdk_image_get (drawable, 0, 0, width, height)
		
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
				{EV_GTK_DEPENDENT_EXTERNALS}.gdk_colormap_query_color (a_color_map, a_pixel, a_color)
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
			-- Update `Current' to have same appearance as `other'.
			-- (So as to satisfy `is_equal'.)
		local
			other_imp: EV_PIXMAP_IMP
		do
			other_imp ?= other.implementation
			copy_from_gdk_data (other_imp.drawable, other_imp.mask, other_imp.width, other_imp.height)
			internal_xpm_data := other_imp.internal_xpm_data
		end
		
feature {EV_ANY_I, EV_GTK_DEPENDENT_APPLICATION_IMP} -- Implementation

	set_pixmap_from_pixbuf (a_pixbuf: POINTER) is
			-- Construct `Current' from GdkPixbuf `a_pixbuf'
		local
			a_gdkpix, a_gdkmask: POINTER
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_render_pixmap_and_mask (a_pixbuf, $a_gdkpix, $a_gdkmask, 255)
			set_pixmap (a_gdkpix, a_gdkmask)			
		end
		
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

feature {EV_ANY_I} -- Implementation

	drawable: POINTER
			-- Pointer to the GdkPixmap image data.

	mask: POINTER
			-- Pointer to the GdkBitmap used for masking.

feature {EV_GTK_DEPENDENT_APPLICATION_IMP, EV_ANY_I} -- Implementation

	internal_xpm_data: POINTER
		-- Pointer to the appropriate XPM image used for the default stock cursor if any

feature {EV_STOCK_PIXMAPS_IMP, EV_PIXMAPABLE_IMP} -- Implementation

	set_pixmap (gdkpix, gdkmask: POINTER) is
			-- Set the GtkPixmap using Gdk pixmap data and mask.
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_image_set_from_pixmap (visual_widget, gdkpix, gdkmask)
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
		do
			internal_xpm_data := a_xpm_data
			gdkpix := {EV_GTK_EXTERNALS}.gdk_pixmap_create_from_xpm_d (App_implementation.default_gdk_window, $gdkmask, NULL, a_xpm_data)	
			set_pixmap (gdkpix, gdkmask)
		end

	set_from_stock_id (a_stock_id: POINTER) is
			-- Pixmap symbolizing a piece of information
		require
			a_stock_id_not_null: a_stock_id /= NULL
		local
			stock_pixbuf: POINTER
		do
			stock_pixbuf := {EV_GTK_EXTERNALS}.gtk_widget_render_icon (c_object, a_stock_id, {EV_GTK_DEPENDENT_EXTERNALS}.gtk_icon_size_dialog_enum, default_pointer)
			if stock_pixbuf /= NULL then
					-- If a stock pixmap can be found then set it, else do nothing.
				set_pixmap_from_pixbuf (stock_pixbuf)
				{EV_GTK_EXTERNALS}.object_unref (stock_pixbuf)
			end
		end

feature {NONE} -- Implementation

	save_to_named_file (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME) is
			-- Save `Current' in `a_format' to `a_filename'
		local
			a_gdkpixbuf, stretched_pixbuf: POINTER
			a_gerror: POINTER
			a_handle, a_filetype: EV_GTK_C_STRING
		do			
			if app_implementation.writeable_pixbuf_formats.has (a_format.file_extension.as_upper) then
					-- Perform custom saving with GdkPixbuf
				a_gdkpixbuf := pixbuf_from_drawable
				a_handle := a_filename.string
				a_filetype := a_format.file_extension
				if a_format.scale_width > 0 and then a_format.scale_height > 0 then
					stretched_pixbuf := {EV_GTK_EXTERNALS}.gdk_pixbuf_scale_simple (a_gdkpixbuf, a_format.scale_width, a_format.scale_height, {EV_GTK_EXTERNALS}.gdk_interp_bilinear)
						-- Unref original pixbuf so it gets deleted from memory
					{EV_GTK_EXTERNALS}.object_unref (a_gdkpixbuf)
						-- Set our scaled pixbuf to be the one that is saved
					a_gdkpixbuf := stretched_pixbuf
				end
				{EV_GTK_DEPENDENT_EXTERNALS}.gdk_pixbuf_save (a_gdkpixbuf, a_handle.item, a_filetype.item, $a_gerror)
				if a_gerror /= default_pointer then
					-- We could not save the image so raise an exception
					(create {EXCEPTIONS}).raise ("Could not save image file.")
				end
				{EV_GTK_EXTERNALS}.object_unref (a_gdkpixbuf)
			else
				-- If Gtk cannot save the file then the default is called
				Precursor {EV_PIXMAP_I} (a_format, a_filename)
			end
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

