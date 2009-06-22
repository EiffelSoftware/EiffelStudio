note
	description: "EiffelVision pixmap, Cocoa implementation."
	author: "Daniel Furrer"
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
			old_make
		redefine
			interface,
			make,
			width,
			height
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
			make,
			minimum_width,
			minimum_height
		end

	EV_PIXMAP_ACTION_SEQUENCES_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		do
			internal_height := 10
			internal_width := 10
			create image_view.make
			cocoa_item := image_view
			image_view.set_image_scaling ({NS_IMAGE_VIEW}.image_scaling_none)

			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_DRAWABLE_IMP}
			disable_tabable_from
			disable_tabable_to
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
		do
		end

	update_if_needed
			-- Update `Current' if needed.
		do
		end

feature -- Measurement

	width, minimum_width: INTEGER
			-- Width of the pixmap in pixels.
		do
			Result := internal_width
		end

	height: INTEGER
			-- height of the pixmap.
		do
			Result := internal_height
		end

	minimum_height: INTEGER
		do
			if is_user_min_height_set then
				Result := internal_minimum_width
			else
				Result := height
			end
		end

feature -- Element change

	read_from_named_file (a_path: STRING_GENERAL)
			-- Attempt to load pixmap data from a file specified by `file_name'.
		local
			l_image: NS_IMAGE
			l_image_rep: detachable NS_IMAGE_REP
		do
			create l_image.make_with_referencing_file (a_path)
			image_view.set_image (l_image)
			if l_image.representations.count > 0 then
				-- File found, representation loaded
				l_image_rep := l_image.representations.item (0)
				check l_image_rep /= void end
				internal_width := l_image_rep.pixels_wide
				internal_height := l_image_rep.pixels_high
				image := l_image
			else
				(create {EXCEPTIONS}).raise ("Could not load image file.")
			end
		end

	load_system_image (a_name: STRING_GENERAL)
			-- Load a OS X default system image
		local
			l_image: NS_IMAGE
			l_image_rep: detachable NS_IMAGE_REP
		do
			create l_image.make_named (a_name)
			image_view.set_image (l_image)
			l_image_rep := l_image.representations.item (0)
			check l_image_rep /= void end
			internal_width := l_image_rep.pixels_wide
			internal_height := l_image_rep.pixels_high
			image := l_image
		end

	set_with_default
			-- Initialize the pixmap with the default
			-- pixmap (Vision2 logo)
		do
		end

	stretch (a_x, a_y: INTEGER)
			-- Stretch the image to fit in size `a_x' by `a_y'.
		do
			set_size (a_x, a_y)
		end

	set_size (a_width, a_height: INTEGER)
			-- Set the size of the pixmap to `a_width' by `a_height'.
		do
			internal_width := a_width
			internal_height := a_height
			image.set_size (create {NS_SIZE}.make_size (a_width, a_height))
		end

	reset_for_buffering (a_width, a_height: INTEGER)
			-- Resets the size of the pixmap without keeping original image or clearing background.
		do
			if a_width /= width or else a_height /= height then
				-- so what?
			end
		end

	set_mask (a_mask: EV_BITMAP)
			-- Set the Bitmap used for masking `Current'.
		local
			a_mask_imp: detachable EV_BITMAP_IMP
		do
			a_mask_imp ?= a_mask.implementation
		end

feature -- Access

	raw_image_data: EV_RAW_IMAGE_DATA
		do
			create Result.make_with_alpha_zero (width, height)
			Result.set_originating_pixmap (interface)
			-- TODO: image -> bitmap, read bitmap values and write in Result
		end

feature -- Duplication

	copy_pixmap (other: EV_PIXMAP)
			-- Update `Current' to have same appearance as `other'.
			-- (So as to satisfy `is_equal'.)
		local
			other_imp: EV_PIXMAP_IMP
		do
			other_imp ?= other.implementation

--			if other_imp.pixmap_filename /= Void then
--				pixmap_filename := other_imp.pixmap_filename.twin
--			end
			internal_width := other_imp.internal_width
			internal_height := other_imp.internal_height
			image := other_imp.image.twin
			image_view.set_image (image)

--			private_mask_bitmap := other_simple_imp.private_mask_bitmap
--			private_palette := other_simple_imp.private_palette

--			 copy_events_from_other (other_imp)
--			 update_needed := False

			-- Update navigation attribute
			if other.is_tabable_from then
				enable_tabable_from
			else
				disable_tabable_from
			end
			if other.is_tabable_to then
				enable_tabable_to
			else
				disable_tabable_to
			end
		end


feature {EV_PIXMAP_IMP} -- Implementation

	internal_height: INTEGER
	internal_width: INTEGER

feature {NONE} -- Constants

	Default_color_depth: INTEGER = -1
			-- Default color depth.

	Monochrome_color_depth: INTEGER = 1
			-- Black and White color depth (for mask).

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_PIXMAP note option: stable attribute end;

	image_view: NS_IMAGE_VIEW

end -- EV_PIXMAP_IMP
