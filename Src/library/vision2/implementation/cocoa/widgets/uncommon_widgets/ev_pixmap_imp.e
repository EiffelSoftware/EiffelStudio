note
	description: "EiffelVision pixmap, Cocoa implementation."
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
			initialize,
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

	make (an_interface: like interface)
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			internal_height := 10
			internal_width := 10
			create {NS_IMAGE_VIEW}cocoa_item.new
			image_view.set_image_scaling ({NS_IMAGE_VIEW}.image_scaling_none)
		end

	initialize
			-- Initialize `Current'
		do
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

	flush
			-- Ensure that the appearance of `Current' is updated on screen
			-- immediately. Any changes that have not yet been reflected will
			-- become visible.
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
			l_image_rep: NS_IMAGE_REP
		do
			create l_image.init_by_referencing_file (a_path)
			image_view.set_image (l_image)
			l_image_rep := l_image.representations.object_at_index (0)
			internal_width := l_image_rep.pixels_wide
			internal_height := l_image_rep.pixels_high
			image := l_image
		end

	load_system_image (a_name: STRING_GENERAL)
			-- Load a OS X default system image
		local
			l_image: NS_IMAGE
			l_image_rep: NS_IMAGE_REP
		do
			create l_image.image_named (a_name)
			image_view.set_image (l_image)
			l_image_rep := l_image.representations.object_at_index (0)
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
		do
			a_mask_imp ?= a_mask.implementation
		end

feature -- Access

	raw_image_data: EV_RAW_IMAGE_DATA
		do
		end

feature -- Duplication

	copy_pixmap (other: EV_PIXMAP)
			-- Update `Current' to have same appearance as `other'.
			-- (So as to satisfy `is_equal'.)
		local
			other_imp: EV_PIXMAP_IMP
		do
			other_imp ?= other.implementation
		end

feature {NONE} -- Implementation

	internal_height: INTEGER
	internal_width: INTEGER

	save_to_named_file (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME)
			-- Save `Current' in `a_format' to `a_filename'
		do
		end

feature {NONE} -- Constants

	Default_color_depth: INTEGER = -1
			-- Default color depth.

	Monochrome_color_depth: INTEGER = 1
			-- Black and White color depth (for mask).

feature {EV_ANY_I} -- Implementation

	interface: EV_PIXMAP;

	image_view: NS_IMAGE_VIEW
		do
			Result ?= cocoa_item
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- EV_PIXMAP_IMP

