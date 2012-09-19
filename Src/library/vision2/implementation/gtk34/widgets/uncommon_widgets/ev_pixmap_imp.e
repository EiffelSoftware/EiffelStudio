note
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
			old_make,
			width,
			height,
			destroy,
			drawable,
			pixbuf_from_drawable_at_position
		end

	EV_PRIMITIVE_IMP
		undefine
			foreground_color_internal,
			background_color_internal,
			set_foreground_color,
			set_background_color
		redefine
			interface,
			width,
			height,
			destroy,
			make,
			process_draw_event
		end

	EV_PIXMAP_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Create a gtk pixmap of size (1 * 1) with no mask.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'
		local
			l_app_imp: like app_implementation
			l_expose_actions: like expose_actions
		do
			set_c_object ({GTK}.gtk_drawing_area_new)
			Precursor {EV_PRIMITIVE_IMP}
			l_app_imp := app_implementation

			set_size (1, 1)
				-- Initialize the Graphical Context
			init_default_values
			clear_rectangle (0, 0, 1, 1)

				-- Initialize expose actions so blitting may occur.
			l_expose_actions := expose_actions
		end

	init_from_pointer_style (a_pointer_style: EV_POINTER_STYLE)
			-- Initialize from `a_pointer_style'
		local
			a_pointer_style_imp: detachable EV_POINTER_STYLE_IMP
			l_pixbuf: POINTER
		do
			a_pointer_style_imp ?= a_pointer_style.implementation
			check a_pointer_style_imp /= Void end

			if a_pointer_style_imp.predefined_cursor_code > 0 then
				-- We are building from a stock cursor.
				inspect
					a_pointer_style_imp.predefined_cursor_code
				when {EV_POINTER_STYLE_CONSTANTS}.busy_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.busy_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.wait_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.wait_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.crosshair_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.crosshair_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.help_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.help_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.ibeam_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.ibeam_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.no_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.no_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.sizeall_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.sizeall_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.sizenesw_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.sizenesw_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.sizens_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.sizens_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.sizenwse_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.sizenwse_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.sizewe_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.sizewe_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.uparrow_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.uparrow_cursor_xpm)
				when {EV_POINTER_STYLE_CONSTANTS}.standard_cursor then
					set_from_xpm_data ({EV_STOCK_PIXMAPS_IMP}.standard_cursor_xpm)
				else
					set_size (a_pointer_style.width, a_pointer_style.height)
					clear
				end
			else
				l_pixbuf := a_pointer_style_imp.gdk_pixbuf
				if l_pixbuf /= default_pointer then
					set_pixmap_from_pixbuf (a_pointer_style_imp.gdk_pixbuf)
				else
					set_size (a_pointer_style.width, a_pointer_style.height)
					clear
				end
			end
		end

	init_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Initialize from `a_pixel_buffer'
		local
			l_pixel_buffer_imp: detachable EV_PIXEL_BUFFER_IMP
		do
			l_pixel_buffer_imp ?= a_pixel_buffer.implementation
			check l_pixel_buffer_imp /= Void end
			set_pixmap_from_pixbuf (l_pixel_buffer_imp.gdk_pixbuf)
		end

feature -- Drawing operations

	redraw
			-- Force `Current' to redraw itself.
		do
			if is_displayed then
				{GTK}.gtk_widget_queue_draw (visual_widget)
			end
		end

	flush
			-- Ensure that the appearance of `Current' is updated on screen
			-- immediately. Any changes that have not yet been reflected will
			-- become visible.
		do
			refresh_now
		end

	disable_double_buffering
			-- Disable double buffering for exposed areas.
		do
			{GTK2}.gtk_widget_set_double_buffered (visual_widget, False)
		end

feature -- Measurement

	width: INTEGER
			-- Width of the pixmap in pixels.
		do
			if cairo_surface /= default_pointer then
				Result := {CAIRO}.cairo_image_surface_get_width (cairo_surface)
			end
		end

	height: INTEGER
			-- height of the pixmap.
		do
			if cairo_surface /= default_pointer then
				Result := {CAIRO}.cairo_image_surface_get_height (cairo_surface)
			end
		end

feature -- Element change

	read_from_named_file (file_name: READABLE_STRING_GENERAL)
			-- Attempt to load pixmap data from a file specified by `file_name'.
		local
			a_cs: EV_GTK_C_STRING
			g_error: POINTER
			filepixbuf: POINTER
		do
			a_cs := file_name
			filepixbuf := {GTK}.gdk_pixbuf_new_from_file (a_cs.item, $g_error)
			if g_error /= default_pointer then
				-- We could not load the image so raise an exception
				(create {EXCEPTIONS}).raise ("Could not load image file.")
			end
			set_pixmap_from_pixbuf (filepixbuf)
				-- Unreference pixbuf so that it may be collected.
			{GTK2}.g_object_unref (filepixbuf)
		end

	cairo_surface: POINTER
		-- Cairo drawable surface used for storing pixmap data in RGB format.

	set_with_default
			-- Initialize the pixmap with the default
			-- pixmap (Vision2 logo)
		do
			set_from_xpm_data (default_pixmap_xpm)
		end

	stretch (a_x, a_y: INTEGER)
			-- Stretch the image to fit in size `a_x' by `a_y'.
		local
			a_gdkpixbuf, scaled_pixbuf: POINTER
			a_scale_type: INTEGER
			l_width, l_height: INTEGER
		do
			l_width := width
			l_height := height
			if l_width /= a_x or else l_height /= a_y then
				a_gdkpixbuf := pixbuf_from_drawable
				if l_width <= 16 and then l_height <= 16 then
						-- For small images this method scales better
					a_scale_type := {GTK2}.gdk_interp_nearest
				else
						-- For larger images this mode provides better scaling
					a_scale_type := {GTK2}.gdk_interp_bilinear
				end
				scaled_pixbuf := {GTK2}.gdk_pixbuf_scale_simple (a_gdkpixbuf, a_x, a_y, a_scale_type)
				{GTK2}.g_object_unref (a_gdkpixbuf)
				set_pixmap_from_pixbuf (scaled_pixbuf)
				{GTK2}.g_object_unref (scaled_pixbuf)
			end
		end

	set_size (a_width, a_height: INTEGER)
			-- Set the size of the pixmap to `a_width' by `a_height'.
		do
			if cairo_surface /= default_pointer then
				{CAIRO}.cairo_surface_destroy (cairo_surface)
				{CAIRO}.cairo_destroy (drawable)
			end
			cairo_surface := {CAIRO}.cairo_image_surface_create ({CAIRO}.cairo_format_argb32, a_width, a_height)
			drawable := {CAIRO}.cairo_create (cairo_surface)
			init_default_values
		end

	reset_for_buffering (a_width, a_height: INTEGER)
			-- Resets the size of the pixmap without keeping original image or clearing background.
		do
			set_size (a_width, a_height)
		end

	set_mask (a_mask: EV_BITMAP)
			-- Set the GdkBitmap used for masking `Current'.
		do
		end

feature {EV_GTK_DEPENDENT_APPLICATION_IMP, EV_ANY_I} -- Implementation

	pixbuf_from_drawable_at_position (src_x, src_y, dest_x, dest_y, a_width, a_height: INTEGER): POINTER
			-- Return a GdkPixbuf object from the current Gdkpixbuf structure
		do
			Result := {GTK}.gdk_pixbuf_get_from_surface (cairo_surface, src_x, src_y, a_width, a_height)
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	process_draw_event (a_cairo_context: POINTER)
			-- Call the expose actions for the drawing area.
		local
			l_width, l_height: INTEGER
		do
			l_width := {GTK}.gtk_widget_get_allocated_width (c_object)
			l_height := {GTK}.gtk_widget_get_allocated_height (c_object)

			if expose_actions_internal /= Void then
				expose_actions_internal.call (app_implementation.gtk_marshal.dimension_tuple (0, 0, l_width, l_height))
			end

			{CAIRO}.cairo_set_source_surface (a_cairo_context, cairo_surface, (l_width - width) / 2, (l_height - height) / 2)
			{CAIRO}.cairo_paint (a_cairo_context)
		end

feature -- Access

	raw_image_data: EV_RAW_IMAGE_DATA
		local
--			a_gdkimage, a_visual: POINTER
--			a_visual_type, a_pixel: INTEGER
--			a_color: POINTER
--			a_color_map: POINTER
--			a_width: INTEGER
--			array_offset, array_size: INTEGER
--			array_area: SPECIAL [NATURAL_8]
--			color_struct_size: INTEGER
		do
			create Result.make_with_alpha_zero (width, height)
			Result.set_originating_pixmap (attached_interface)
--			a_gdkimage := {GTK}.gdk_image_get (drawable, 0, 0, width, height)

--			from
--				a_width := width * 4
----				a_color_map := {GTK2}.gdk_screen_get_rgb_colormap ({GTK2}.gdk_screen_get_default)
--				a_visual := {GTK}.gdk_colormap_get_visual (a_color_map)
--				a_visual_type := {GTK}.gdk_visual_struct_type (a_visual)
--				a_color := {GTK}.c_gdk_color_struct_allocate
--				array_size := a_width * height
--				array_area := Result.area
--				color_struct_size := {GTK}.c_gdk_color_struct_size
--			until
--				array_offset = array_size
--			loop
----				a_pixel := {GTK}.gdk_image_get_pixel (
----					a_gdkimage,
----					(array_offset \\ (a_width) // 4), -- Zero based X coord
----					((array_offset) // a_width) -- Zero based Y coord
----				)
--				{GTK2}.gdk_colormap_query_color (a_color_map, a_pixel, a_color)
--					-- RGB values of a_color are 16 bit.
--				array_area.put (({GTK}.gdk_color_struct_red (a_color) // 256).to_natural_8, array_offset)
--				array_area.put (({GTK}.gdk_color_struct_green (a_color) // 256).to_natural_8, array_offset + 1)
--				array_area.put (({GTK}.gdk_color_struct_blue (a_color) // 256).to_natural_8, array_offset + 2)
--				array_area.put (255, array_offset + 3)
--				array_offset := array_offset + 4
--			end
--			a_color.memory_free
--			{GTK}.gdk_image_destroy (a_gdkimage)
		end

feature -- Duplication

	copy_pixmap (other: EV_PIXMAP)
			-- Update `Current' to have same appearance as `other'.
			-- (So as to satisfy `is_equal'.)
		local
			l_width, l_height: INTEGER
		do
			if attached {EV_PIXMAP_IMP} other.implementation as l_other_imp then
				l_width := l_other_imp.width
				l_height := l_other_imp.height
				cairo_surface := {CAIRO}.cairo_image_surface_create ({CAIRO}.cairo_format_argb32, l_width, l_height)
				drawable := {CAIRO}.cairo_create (cairo_surface)
				init_default_values
				{CAIRO}.cairo_set_source_surface (drawable, l_other_imp.cairo_surface, 0, 0)
				{CAIRO}.cairo_paint (drawable)
				{CAIRO}.cairo_set_source_rgb (drawable, 0, 0, 0)
			end
		end

feature {EV_ANY_I, EV_GTK_DEPENDENT_APPLICATION_IMP} -- Implementation

	set_pixmap_from_pixbuf (a_pixbuf: POINTER)
			-- Attempt to load pixmap data from a file specified by `file_name'.
		do
			cairo_surface := {CAIRO}.cairo_image_surface_create (
				{CAIRO}.CAIRO_FORMAT_ARGB32,
				{GTK}.gdk_pixbuf_get_width (a_pixbuf),
				{GTK}.gdk_pixbuf_get_height (a_pixbuf)
			)
			drawable := {CAIRO}.cairo_create (cairo_surface)
			set_drawing_mode (drawing_mode_copy)

				-- Temporarily set the source to the pixbuf so that we can draw it on to the drawable.
			{GTK}.gdk_cairo_set_source_pixbuf (drawable, a_pixbuf, 0, 0)
			{CAIRO}.cairo_paint (drawable)

				-- Reset the cairo context back to rgb source of black.
			{CAIRO}.cairo_set_source_rgb (drawable, 0, 0, 0)
		end

feature {EV_ANY_I} -- Implementation

	drawable: POINTER
			-- Pointer to the GdkPixmap image data.

feature {EV_GTK_DEPENDENT_APPLICATION_IMP, EV_ANY_I} -- Implementation

	internal_xpm_data: POINTER
		-- Pointer to the appropriate XPM image used for the default stock cursor if any

feature {EV_STOCK_PIXMAPS_IMP, EV_PIXMAPABLE_IMP, EV_PIXEL_BUFFER_IMP} -- Implementation

	set_from_xpm_data (a_xpm_data: POINTER)
			-- Pixmap symbolizing a piece of information.
		require
			xpm_data_not_null: a_xpm_data /= NULL
		local
			xpmpixbuf: POINTER
		do
				-- Store internal xpm data for default stock cursor handling.
			internal_xpm_data := a_xpm_data
			xpmpixbuf := {GTK}.gdk_pixbuf_new_from_xpm_data (a_xpm_data)

			set_pixmap_from_pixbuf (xpmpixbuf)
				-- Unreference pixbuf so that it may be collected.
			{GTK2}.g_object_unref (xpmpixbuf)
		end

	set_from_stock_id (a_stock_id: POINTER)
			-- Pixmap symbolizing a piece of information
		require
			a_stock_id_not_null: a_stock_id /= NULL
		local
			stock_pixbuf: POINTER
		do
			stock_pixbuf := {GTK2}.gtk_widget_render_icon (c_object, a_stock_id, {GTK2}.gtk_icon_size_dialog_enum, default_pointer)
			if stock_pixbuf /= NULL then
					-- If a stock pixmap can be found then set it, else do nothing.
				set_pixmap_from_pixbuf (stock_pixbuf)
				{GTK2}.g_object_unref (stock_pixbuf)
			end
		end

feature {NONE} -- Implementation

	save_to_named_file (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME)
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
					stretched_pixbuf := {GTK2}.gdk_pixbuf_scale_simple (a_gdkpixbuf, a_format.scale_width, a_format.scale_height, {GTK2}.gdk_interp_bilinear)
						-- Unref original pixbuf so it gets deleted from memory
					{GTK2}.g_object_unref (a_gdkpixbuf)
						-- Set our scaled pixbuf to be the one that is saved
					a_gdkpixbuf := stretched_pixbuf
				end
				{GTK2}.gdk_pixbuf_save (a_gdkpixbuf, a_handle.item, a_filetype.item, $a_gerror)
				if a_gerror /= default_pointer then
					-- We could not save the image so raise an exception
					(create {EXCEPTIONS}).raise ("Could not save image file.")
				end
				{GTK2}.g_object_unref (a_gdkpixbuf)
			else
				-- If Gtk cannot save the file then the default is called
				Precursor {EV_PIXMAP_I} (a_format, a_filename)
			end
		end

	destroy
			-- Destroy the pixmap and resources.
		do
			Precursor {EV_PRIMITIVE_IMP}
		end

feature {NONE} -- Externals

	default_pixmap_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"default_pixmap_xpm"
		end

feature {NONE} -- Constants

	Monochrome_color_depth: INTEGER = 1
			-- Black and White color depth (for mask).

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PIXMAP note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- EV_PIXMAP_IMP
