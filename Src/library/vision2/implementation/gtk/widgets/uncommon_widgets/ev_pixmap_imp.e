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
			save_to_named_path,
			init_expose_actions
		end

	EV_DRAWABLE_IMP
		redefine
			interface,
			corruptable_onscreen
		end

	EV_PRIMITIVE_IMP
		undefine
			foreground_color_internal,
			background_color_internal,
			set_foreground_color,
			set_background_color,
			needs_event_box
		redefine
			interface,
			width,
			height,
			destroy,
			dispose,
			make
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN
			-- Does `a_widget' need an event box?
		do
			Result := True
		end

	old_make (an_interface: attached like interface)
			-- Create a gtk pixmap of size (1 * 1) with no mask.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'
		local
			gdkpix, gdkmask: POINTER
			l_app_imp: like app_implementation
		do
			set_c_object ({GTK2}.gtk_image_new)
			Precursor {EV_PRIMITIVE_IMP}
			l_app_imp := app_implementation
			gdkpix := {GTK}.gdk_pixmap_new (null, 1, 1, l_app_imp.best_available_color_depth)

			set_pixmap (gdkpix, gdkmask)
				-- Initialize the Graphical Context
			gc := {GTK}.gdk_gc_new (gdkpix)
			{GTK}.gdk_gc_set_foreground (gc, fg_color)
			{GTK}.gdk_gc_set_background (gc, bg_color)
			init_default_values
			clear_rectangle (0, 0, 1, 1)
		end

	init_from_pointer_style (a_pointer_style: EV_POINTER_STYLE)
			-- Initialize from `a_pointer_style'
		local
			a_pointer_style_imp: detachable EV_POINTER_STYLE_IMP
			l_pixbuf: POINTER
		do
			a_pointer_style_imp ?= a_pointer_style.implementation
			check a_pointer_style_imp /= Void then end

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
			check l_pixel_buffer_imp /= Void then end
			set_pixmap_from_pixbuf (l_pixel_buffer_imp.gdk_pixbuf)
		end

feature -- Drawing operations

	redraw
			-- Force `Current' to redraw itself.
		do
			update_if_needed
		end

	flush
			-- Ensure that the appearance of `Current' is updated on screen
			-- immediately. Any changes that have not yet been reflected will
			-- become visible.
		do
			refresh_now
		end

	update_if_needed
			-- Update `Current' if needed.
		do
			if is_displayed then
				{GTK}.gtk_widget_queue_draw (visual_widget)
			end
		end

feature -- Measurement

	width: INTEGER
			-- Width of the pixmap in pixels.
		local
			a_y: INTEGER
		do
			{GTK2}.gdk_drawable_get_size (drawable, $Result, $a_y)
		end

	height: INTEGER
			-- height of the pixmap.
		local
			a_x: INTEGER
		do
			{GTK2}.gdk_drawable_get_size (drawable, $a_x, $Result)
		end

feature -- Element change

	read_from_named_path (file_path: PATH)
			-- Attempt to load pixmap data from a file specified by `file_name'.
		local
			a_cs: EV_GTK_C_STRING
			g_error: POINTER
			filepixbuf: POINTER
		do
			create a_cs.make_from_path (file_path)
			filepixbuf := {GTK}.gdk_pixbuf_new_from_file (a_cs.item, $g_error)
			if g_error /= default_pointer then
				-- We could not load the image so raise an exception
				(create {EXCEPTIONS}).raise ("Could not load image file.")
			else
				set_pixmap_from_pixbuf (filepixbuf)
			end
			{GOBJECT}.g_object_unref (filepixbuf)
		end

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
				{GOBJECT}.g_object_unref (a_gdkpixbuf)
				set_pixmap_from_pixbuf (scaled_pixbuf)
				{GOBJECT}.g_object_unref (scaled_pixbuf)
			end
		end

	set_size (a_width, a_height: INTEGER)
			-- Set the size of the pixmap to `a_width' by `a_height'.
		local
			oldpix, oldmask: POINTER
			l_width, l_height: INTEGER
			pixgc, maskgc: POINTER
			loc_default_pointer: POINTER
		do
			l_width := width
			l_height := height
			if l_width /= a_width or else l_height /= a_height then
				oldpix := {GTK}.gdk_pixmap_ref (drawable)
				if mask /= loc_default_pointer then
					oldmask := {GTK}.gdk_pixmap_ref (mask)
				end

				drawable := {GTK}.gdk_pixmap_new (null, a_width, a_height, app_implementation.best_available_color_depth)
				clear_rectangle (0, 0, a_width, a_height)

				pixgc := {GTK}.gdk_gc_new (drawable)
				{GTK}.gdk_gc_set_clip_mask (pixgc, oldmask)
				{GTK}.gdk_gc_set_clip_origin (pixgc, 0, 0)
				{GTK2}.gdk_draw_drawable (drawable, pixgc, oldpix, 0, 0, 0, 0, l_width, l_height)
				{GTK}.gdk_gc_unref (pixgc)
				{GTK}.gdk_pixmap_unref (oldpix)

				if oldmask /= loc_default_pointer then
					mask := {GTK}.gdk_pixmap_new (null, a_width, a_height, Monochrome_color_depth)
					maskgc := {GTK}.gdk_gc_new (mask)
					{GTK}.gdk_gc_set_foreground (maskgc, bg_color)
					{GTK}.gdk_draw_rectangle (mask, maskgc, 1, 0, 0, a_width, a_height)
					{GTK2}.gdk_draw_drawable (mask, maskgc, oldmask, 0, 0, 0, 0, l_width, l_height)
					{GTK}.gdk_gc_unref (maskgc)
					{GTK}.gdk_pixmap_unref (oldmask)
				end
				set_pixmap (drawable, mask)
			end
		end

	reset_for_buffering (a_width, a_height: INTEGER)
			-- Resets the size of the pixmap without keeping original image or clearing background.
		local
			gdkpix: POINTER
		do
			if a_width /= width or else a_height /= height then
				gdkpix := {GTK}.gdk_pixmap_new (null, a_width, a_height, app_implementation.best_available_color_depth)
				set_pixmap (gdkpix, default_pointer)
			end
		end

	set_mask (a_mask: EV_BITMAP)
			-- Set the GdkBitmap used for masking `Current'.
		local
			a_mask_imp: detachable EV_BITMAP_IMP
		do
			a_mask_imp ?= a_mask.implementation
			check a_mask_imp /= Void then end
			copy_from_gdk_data (drawable, a_mask_imp.drawable, width, height)
		end

feature -- Access

	raw_image_data: EV_RAW_IMAGE_DATA
		local
			a_gdkimage, a_visual: POINTER
			a_visual_type, a_pixel: INTEGER
			a_color: POINTER
			a_color_map: POINTER
			a_width: INTEGER
			array_offset, array_size: INTEGER
			array_area: SPECIAL [NATURAL_8]
			color_struct_size: INTEGER
		do
			create Result.make_with_alpha_zero (width, height)
			Result.set_originating_pixmap (attached_interface)
			a_gdkimage := {GTK}.gdk_image_get (drawable, 0, 0, width, height)

			from
				a_width := width * 4
				a_color_map := {GTK2}.gdk_screen_get_rgb_colormap ({GTK2}.gdk_screen_get_default)
				a_visual := {GTK}.gdk_colormap_get_visual (a_color_map)
				a_visual_type := {GTK}.gdk_visual_struct_type (a_visual)
				a_color := {GTK}.c_gdk_color_struct_allocate
				array_size := a_width * height
				array_area := Result.area
				color_struct_size := {GTK}.c_gdk_color_struct_size
			until
				array_offset = array_size
			loop
				a_pixel := {GTK}.gdk_image_get_pixel (
					a_gdkimage,
					(array_offset \\ (a_width) // 4), -- Zero based X coord
					((array_offset) // a_width) -- Zero based Y coord
				)
				{GTK2}.gdk_colormap_query_color (a_color_map, a_pixel, a_color)
					-- RGB values of a_color are 16 bit.
				array_area.put (({GTK}.gdk_color_struct_red (a_color) // 256).to_natural_8, array_offset)
				array_area.put (({GTK}.gdk_color_struct_green (a_color) // 256).to_natural_8, array_offset + 1)
				array_area.put (({GTK}.gdk_color_struct_blue (a_color) // 256).to_natural_8, array_offset + 2)
				array_area.put (255, array_offset + 3)
				array_offset := array_offset + 4
			end
			a_color.memory_free
			{GTK}.gdk_image_destroy (a_gdkimage)
		end

feature -- Duplication

	copy_pixmap (other: EV_PIXMAP)
			-- Update `Current' to have same appearance as `other'.
			-- (So as to satisfy `is_equal'.)
		local
			other_imp: detachable EV_PIXMAP_IMP
		do
			other_imp ?= other.implementation
			check other_imp /= Void then end
			copy_from_gdk_data (other_imp.drawable, other_imp.mask, other_imp.width, other_imp.height)
			internal_xpm_data := other_imp.internal_xpm_data
		end

feature {EV_ANY_I, EV_GTK_DEPENDENT_APPLICATION_IMP} -- Implementation

	set_pixmap_from_pixbuf (a_pixbuf: POINTER)
			-- Construct `Current' from GdkPixbuf `a_pixbuf'
		local
			a_gdkpix, a_gdkmask: POINTER
		do
				-- Alpha threshold value is set to 127 to match the MSWin implementation.
			{GTK}.gdk_pixbuf_render_pixmap_and_mask (a_pixbuf, $a_gdkpix, $a_gdkmask, 127)
			set_pixmap (a_gdkpix, a_gdkmask)
		end

	copy_from_gdk_data (a_src_pix, a_src_mask: POINTER; a_width, a_height: INTEGER)
			-- Update `Current' to use passed gdk pixmap data.
		local
			gdkpix, gdkmask: POINTER
			pixgc, maskgc: POINTER
		do
 			gdkpix := {GTK}.gdk_pixmap_new (null, a_width, a_height, app_implementation.best_available_color_depth)
			pixgc := {GTK}.gdk_gc_new (gdkpix)
			{GTK2}.gdk_draw_drawable (gdkpix, pixgc, a_src_pix, 0, 0, 0, 0, a_width, a_height)
			{GTK}.gdk_gc_unref (pixgc)
			if a_src_mask /= NULL then
				gdkmask := {GTK}.gdk_pixmap_new (NULL, a_width, a_height, Monochrome_color_depth)
				maskgc := {GTK}.gdk_gc_new (gdkmask)
				{GTK2}.gdk_draw_drawable (gdkmask, maskgc, a_src_mask, 0, 0, 0, 0, a_width, a_height)
				{GTK}.gdk_gc_unref (maskgc)
			end
			set_pixmap (gdkpix, gdkmask)
		end

feature {EV_ANY_I} -- Implementation

	drawable: POINTER
			-- Pointer to the GdkPixmap image data.

	mask: POINTER
			-- Pointer to the GdkBitmap used for masking.

	corruptable_onscreen: BOOLEAN = False
			-- Is drawable corruptable onscreen?

feature {EV_GTK_DEPENDENT_APPLICATION_IMP, EV_ANY_I} -- Implementation

	internal_xpm_data: POINTER
		-- Pointer to the appropriate XPM image used for the default stock cursor if any

feature {EV_STOCK_PIXMAPS_IMP, EV_PIXMAPABLE_IMP, EV_PIXEL_BUFFER_IMP} -- Implementation

	set_pixmap (gdkpix, gdkmask: POINTER)
			-- Set the GtkPixmap using Gdk pixmap data and mask.
		do
			{GTK2}.gtk_image_set_from_pixmap (visual_widget, gdkpix, gdkmask)
			drawable := gdkpix
			mask := gdkmask
			if gdkpix /= NULL then
				{GTK}.gdk_pixmap_unref (gdkpix)
			end
			if gdkmask /= NULL then
				{GTK}.gdk_pixmap_unref (gdkmask)
			end
		end

	set_from_xpm_data (a_xpm_data: POINTER)
			-- Pixmap symbolizing a piece of information.
		require
			xpm_data_not_null: a_xpm_data /= NULL
		local
			gdkpix, gdkmask: POINTER
		do
			internal_xpm_data := a_xpm_data
			gdkpix := {GTK}.gdk_pixmap_create_from_xpm_d (App_implementation.default_gdk_window, $gdkmask, NULL, a_xpm_data)
			set_pixmap (gdkpix, gdkmask)
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
				{GOBJECT}.g_object_unref (stock_pixbuf)
			end
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	call_expose_actions (a_x, a_y, a_width, a_height: INTEGER)
			-- Call the expose actions for the drawing area.
		do
			if expose_actions_internal /= Void then
				expose_actions_internal.call ([a_x, a_y, a_width, a_height])
			end
		end

	init_expose_actions (a_expose_actions: like expose_actions)
			-- <Precursor>
			-- Attach to GTK "expose-event" signal.
		local
			l_app_imp: EV_APPLICATION_IMP
		do
			l_app_imp := app_implementation
			l_app_imp.gtk_marshal.signal_connect (visual_widget, once "expose-event", agent (l_app_imp.gtk_marshal).create_expose_actions_intermediary (c_object, ?, ?, ?, ?), l_app_imp.gtk_marshal.expose_translate_agent, False)
		end

feature {NONE} -- Implementation

	save_to_named_path (a_format: EV_GRAPHICAL_FORMAT; a_file_path: PATH)
			-- Save `Current' in `a_format' to `a_file_path'
		local
			a_gdkpixbuf, stretched_pixbuf: POINTER
			a_gerror: POINTER
			a_handle, a_filetype: EV_GTK_C_STRING
		do
			if app_implementation.writeable_pixbuf_formats.has (a_format.file_extension.as_upper) then
					-- Perform custom saving with GdkPixbuf
				a_gdkpixbuf := pixbuf_from_drawable
				create a_handle.make_from_path (a_file_path)
				a_filetype := a_format.file_extension
				if a_format.scale_width > 0 and then a_format.scale_height > 0 then
					stretched_pixbuf := {GTK2}.gdk_pixbuf_scale_simple (a_gdkpixbuf, a_format.scale_width, a_format.scale_height, {GTK2}.gdk_interp_bilinear)
						-- Unref original pixbuf so it gets deleted from memory
					{GOBJECT}.g_object_unref (a_gdkpixbuf)
						-- Set our scaled pixbuf to be the one that is saved
					a_gdkpixbuf := stretched_pixbuf
				end
				{GTK2}.gdk_pixbuf_save (a_gdkpixbuf, a_handle.item, a_filetype.item, $a_gerror)
				if a_gerror /= default_pointer then
					-- We could not save the image so raise an exception
					(create {EXCEPTIONS}).raise ("Could not save image file.")
				end
				{GOBJECT}.g_object_unref (a_gdkpixbuf)
			else
				-- If Gtk cannot save the file then the default is called
				Precursor {EV_PIXMAP_I} (a_format, a_file_path)
			end
		end

	destroy
			-- Destroy the pixmap and resources.
		do
			set_pixmap (NULL, NULL)
			if gc /= NULL then
				{GTK}.gdk_gc_unref (gc)
				gc := NULL
			end
			Precursor {EV_PRIMITIVE_IMP}
		end

	dispose
			-- Clear up resources if needed in object disposal.
		do
			if gc /= NULL then
				gdk_gc_unref (gc)
				gc := NULL
			end
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
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- EV_PIXMAP_IMP
