note
	description: "EiffelVision pixmap, Carbon implementation."
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
			initialize
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
			dispose,
			initialize,
			minimum_width,
			minimum_height,
			on_event
		end

	EV_PIXMAP_ACTION_SEQUENCES_IMP
		redefine
			interface,
			destroy
		end
	HIVIEW_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	CARBONEVENTS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	CGIMAGE_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	CFSTRING_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	CFBUNDLE_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	CGDATAPROVIDER_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	CFBASE_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	CFURL_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Connect interface and initialize `c_object'.
		local
			ret: INTEGER
			struct_ptr: POINTER
		do
			base_make (an_interface)

			ret := hiimage_view_create_external (null, $struct_ptr)
			set_c_object (struct_ptr)
			ret := hiview_set_visible_external (struct_ptr, 1)
			internal_height := 1
			internal_width := 1
		end

	initialize
			-- Initialize `Current'
		local
			ret: INTEGER
			target, h_ret: POINTER
		do
			Precursor {EV_PRIMITIVE_IMP}

			ret := hiview_set_drawing_enabled_external (c_object, 1)
			event_id := app_implementation.get_id (current)  --getting an id from the application
			target := get_control_event_target_external(c_object)
			--h_ret := app_implementation.install_event_handler (event_id, target, {carbonevents_anon_enums}.kEventClassControl, {carbonevents_anon_enums}.kEventMouseDown)
			expandable := false
			init_default_values
		end

	init_from_pointer_style (a_pointer_style: EV_POINTER_STYLE)
			-- Initialize from `a_pointer_style'
		do
		end

	init_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Initialize from `a_pixel_buffer'
		do
		end

feature -- Drawing operations

	redraw
			-- Force `Current' to redraw itself.
		local
			ret: INTEGER
		do
			ret := hiview_set_needs_display_external (c_object, 1)
		end

	flush
			-- Ensure that the appearance of `Current' is updated on screen
			-- immediately. Any changes that have not yet been reflected will
			-- become visible.
		local
			ret : INTEGER
		do
			ret := hiview_set_needs_display_external (c_object, 1)
		end

	update_if_needed
			-- Update `Current' if needed.
		do
		end

feature -- Measurement

	width: INTEGER
			-- Width of the pixmap in pixels.
		do
			Result := cgimage_get_width_external (drawable)
		end

	height: INTEGER
			-- height of the pixmap.
		do
			Result := cgimage_get_height_external (drawable)
		end

feature -- Element change

	read_from_named_file (file_name: STRING_GENERAL)
			-- Attempt to load pixmap data from a file specified by `file_name'.
		local
			url, provider: POINTER
			ret: INTEGER
			cf_filename, cf_dir: EV_CARBON_CF_STRING
			c_name: C_STRING
		do
			create cf_filename.make_unshared_with_eiffel_string (file_name)
			create cf_dir.make_unshared_with_eiffel_string ("./")

			url := cfbundle_copy_resource_url_external (cfbundle_get_main_bundle_external, cf_filename.item, null, cf_dir.item)
			if url = null then
				create cf_dir.make_unshared_with_eiffel_string ("./../../../")
				url := cfbundle_copy_resource_url_external (cfbundle_get_main_bundle_external, cf_filename.item, null, cf_dir.item)
			end
			if url = null then
				create c_name.make (file_name)
				url := cfurlcreate_from_file_system_representation_external (null, c_name.item, c_name.count, 0)
			end
			if url /= null then
				provider := cgdata_provider_create_with_url_external (url)
				drawable := cgimage_create_with_pngdata_provider_external (provider, null, 0, kCGRenderingIntentDefault) -- source, decode, shouldInterpolate, intent

				cgdata_provider_release_external (provider)
				cfrelease_external (url)

				ret := hiview_set_drawing_enabled_external (c_object, 1)
				ret := hiimage_view_set_image_external (c_object, drawable)
			end

		end

	frozen kCGRenderingIntentDefault: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kCGRenderingIntentDefault"
	end

	frozen kCFStringEncodingASCII: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kCFStringEncodingASCII"
	end

	frozen kHIViewZOrderBelow: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kHIViewZOrderBelow"
	end


	set_with_default
			-- Initialize the pixmap with the default
			-- pixmap (Vision2 logo)
		do
		end

	stretch (a_x, a_y: INTEGER)
			-- Stretch the image to fit in size `a_x' by `a_y'.
		local
			ret: INTEGER
		do
			ret := hiimage_view_set_scale_to_fit_external (c_object, 1)
			set_size (a_x, a_y)
		end

	set_size (a_width, a_height: INTEGER)
			-- Set the size of the pixmap to `a_width' by `a_height'.
		local
			ret : INTEGER
			size : CGSIZE_STRUCT
			rect : CGRECT_STRUCT
		do
			create rect.make_new_unshared
			create size.make_shared (rect.size)

			ret := hiview_get_frame_external (c_object, rect.item)

			size.set_height(a_height)
			size.set_width (a_width)

			ret := hiview_set_frame_external (c_object, rect.item)
			internal_width := a_width
			internal_height := a_height
		end

	reset_for_buffering (a_width, a_height: INTEGER)
			-- Resets the size of the pixmap without keeping original image or clearing background.
		local

		do
			if a_width /= width or else a_height /= height then
				-- so what?
			end
		end

		set_mask (a_mask: EV_BITMAP)
			-- Set the Bitmap used for masking `Current'.
		local
			a_mask_imp: EV_BITMAP_IMP
			ret: INTEGER
		do
			a_mask_imp ?= a_mask.implementation
			drawable := cgimage_create_with_mask_external (drawable, a_mask_imp.drawable)
			ret := hiimage_view_set_image_external (c_object, drawable)
		end

feature -- Access

--	minimum_width: INTEGER is
--			-- Minimum width that the widget may occupy.
--	do
--		Result := width
--		if Result < 1 then
--			Result := 1
--		end
--	end

--	minimum_height: INTEGER is
--			-- Minimum width that the widget may occupy.
--	do
--		Result := width
--		if Result < 1 then
--			Result := 1
--		end
--	end

	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		do
			Result := internal_minimum_width.min (width)
		end

	minimum_height: INTEGER
			-- Minimum width that the widget may occupy.
		do
			Result := internal_minimum_height.min (height)
		end

	image_ptr: POINTER

	raw_image_data: EV_RAW_IMAGE_DATA
		do
		end

feature -- Duplication

	copy_pixmap (other: EV_PIXMAP)
			-- Update `Current' to have same appearance as `other'.
			-- (So as to satisfy `is_equal'.)
		local
			other_imp: EV_PIXMAP_IMP
			ret: INTEGER
		do
			other_imp ?= other.implementation
			drawable := other_imp.drawable
			mask := other_imp.mask
			internal_xpm_data := other_imp.internal_xpm_data

			ret := hiimage_view_set_image_external (c_object, drawable)
		end

feature {EV_ANY_I} -- Implementation

	set_pixmap_from_pixbuf (a_pixbuf: POINTER)
			-- Construct `Current' from GdkPixbuf `a_pixbuf'
		do
		end

feature {EV_ANY_I, EV_ANY_IMP} -- Implementation

	drawable: POINTER
			-- Pointer to the Carbon Pixmap image data.

	mask: POINTER
			-- Pointer to the GdkBitmap used for masking.

feature {EV_ANY_I} -- Implementation

	internal_xpm_data: POINTER
		-- Pointer to the appropriate XPM image used for the default stock cursor if any

feature {EV_APPLICATION_IMP}
	on_event (a_inhandlercallref: POINTER; a_inevent: POINTER; a_inuserdata: POINTER): INTEGER
			-- Feature that is called if an event occurs
		local
			event_class, event_kind : INTEGER
			c_imp: EV_WIDGET_IMP
			ret : INTEGER
		do
				event_class := get_event_class_external (a_inevent)
				event_kind := get_event_kind_external (a_inevent)
				if event_kind = {CARBONEVENTS_ANON_ENUMS}.kEventControlDraw and event_class = {CARBONEVENTS_ANON_ENUMS}.kEventClassControl then
					ret := call_next_event_handler_external (a_inhandlercallref, a_inevent)
					draw ( a_inevent )
					Result := {EV_ANY_IMP}.noErr -- event handled
				else
					Result := Precursor {EV_PRIMITIVE_IMP}(a_inhandlercallref, a_inevent, a_inuserdata)
				end
		end	

feature {NONE} -- Implementation

	internal_height: INTEGER
	internal_width: INTEGER

	save_to_named_file (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME)
			-- Save `Current' in `a_format' to `a_filename'
		do
		end

	destroy
			-- Destroy the pixmap and resources.
		do
		end

	dispose
			-- Clear up resources if needed in object disposal.
		do
		end

feature {NONE} -- Externals

	default_pixmap_xpm: POINTER
		do
		end

feature {NONE} -- Constants

	Default_color_depth: INTEGER = -1
			-- Default color depth, use the one from gdk_root_parent.

	Monochrome_color_depth: INTEGER = 1
			-- Black and White color depth (for mask).

feature {EV_ANY_I} -- Implementation

	interface: EV_PIXMAP;

note
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- EV_PIXMAP_IMP

